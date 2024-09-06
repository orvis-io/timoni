package templates

import (
	"strings"
	gatewayv1 "gateway.networking.k8s.io/gateway/v1"
	timoniv1 "timoni.sh/core/v1alpha1"
)

// Config defines the schema and defaults for the Instance values.
#Config: {
	kubeVersion!: string
	clusterVersion: timoniv1.#SemVer & {#Version: kubeVersion, #Minimum: "1.20.0"}
	moduleVersion!: string
	metadata: timoniv1.#Metadata & {#Version: moduleVersion}
	metadata: labels:       timoniv1.#Labels
	metadata: annotations?: timoniv1.#Annotations
	name:             string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(253) & strings.MinRunes(1)
	gatewayClassName: gatewayv1.#GatewaySpec.gatewayClassName
	listeners:        gatewayv1.#GatewaySpec.listeners
}

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: #Config

	objects: gateway: #Gateway & {#config: config}
}
