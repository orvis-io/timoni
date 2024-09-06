#Config: {
	k8sServiceHost: "localhost"
	k8sServicePort: 7445
	domain:         "orvis.io"
	...
}

bundle: {
	apiVersion: "v1alpha1"
	name:       "flux-aio"
	instances: {
		"flux": {
			module: url: "oci://ghcr.io/stefanprodan/modules/flux-aio"
			namespace: "flux-system"
			values: {
				hostNetwork:     true
				securityProfile: "privileged"
				env: {
					"KUBERNETES_SERVICE_HOST": #Config.k8sServiceHost
					"KUBERNETES_SERVICE_PORT": "\(#Config.k8sServicePort)"
				}
			}
		}
		"cilium": {
			module: url: "file://modules/helmrelease"
			namespace: "cuebernetes"
			values: {
				repository: url: "https://helm.cilium.io/"
				chart: {
					name:    "cilium"
					version: "1.16.1"
				}
				sync: targetNamespace: "kube-system"
				helmValues: {
					kubeProxyReplacement: true
					k8sServiceHost:       #Config.k8sServiceHost
					k8sServicePort:       #Config.k8sServicePort
					operator: replicas: 1
					ipam: mode:         "kubernetes"
					hubble: {
						relay: enabled: true
						ui: enabled:    true
					}
					envoy: enabled: true
					securityContext: capabilities: {
						ciliumAgent: ["CHOWN", "KILL", "NET_ADMIN", "NET_RAW", "IPC_LOCK", "SYS_ADMIN", "SYS_RESOURCE", "DAC_OVERRIDE", "FOWNER", "SETGID", "SETUID"]
						cleanCiliumState: ["NET_ADMIN", "SYS_ADMIN", "SYS_RESOURCE"]
					}
					cgroup: {
						autoMount: enabled: true
						hostRoot: "/sys/fs/cgroup"
					}
				}
			}
		}
		"metallb": {
			module: url: "file://modules/helmrelease"
			namespace: "cuebernetes"
			values: {
				repository: url: "https://metallb.github.io/metallb"
				chart: {
					name:    "metallb"
					version: "0.14.8"
				}
				sync: targetNamespace: "metallb-system"
			}
		}
		"metallb-pool": {
			module: url: "file://modules/l2advertisement"
			namespace: "metallb-system"
			values: {
				addresses: ["192.168.69.20/30"]
			}
		}
		"envoy-gateway": {
			module: url: "file://modules/helmrelease"
			namespace: "cuebernetes"
			values: {
				repository: url: "oci://docker.io/envoyproxy"
				chart: {
					name:    "gateway-helm"
					version: "v1.1.0"
				}
				sync: targetNamespace: "envoy-gateway-system"
			}
		}
		"gateway-class": {
			module: url: "file://modules/gatewayclass"
			namespace: "envoy-gateway-system"
			values: {
				name:           "envoy"
				controllerName: "gateway.envoyproxy.io/gatewayclass-controller"
			}
		}
		"gateway": {
			module: url: "file://modules/gateway"
			namespace: "envoy-gateway-system"
			values: {
				name:             "core"
				gatewayClassName: bundle.instances["gateway-class"].values.name
				listeners: [
					{
						name:     "http"
						protocol: "HTTP"
						port:     80
						allowedRoutes: namespaces: from: "All"
					},
					{
						name:     "https"
						protocol: "HTTPS"
						port:     443
						allowedRoutes: namespaces: from: "All"
					},
				]
			}
		}
		"grafana-operator": {
			module: url: "file://modules/helmrelease"
			namespace: "cuebernetes"
			values: {
				repository: url: "oci://ghcr.io/grafana/helm-charts"
				chart: {
					name:    "grafana-operator"
					version: "v5.12.0"
				}
				sync: targetNamespace: "grafana-system"
			}
		}
		"grafana": {
			module: url: "file://modules/grafana"
			namespace: "cuebernetes"
			values: config: {
				server: {
					root_url:    "https://grafana.\(#Config.domain)"
					enable_gzip: "true"
				}
				log: mode:                  "console"
				security: disable_gravatar: "true"
			}
		}
		"grafana-routes": {
			module: url: "file://modules/httproute"
			namespace: "cuebernetes"
			values: {
				gateway: {
					name:      bundle.instances["gateway"].values.name
					namespace: bundle.instances["gateway"].namespace
				}
				hostnames: ["grafana.\(#Config.domain)"]
				service: {
					name:      "grafana-service"
					namespace: bundle.instances["grafana"].namespace
					port:      3000
				}
			}
		}
	}
}
