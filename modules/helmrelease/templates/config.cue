package templates

import (
	"strings"
	timoniv1 "timoni.sh/core/v1alpha1"
)

#Config: {
	kubeVersion!: string
	clusterVersion: timoniv1.#SemVer & {#Version: kubeVersion, #Minimum: "1.20.0"}
	moduleVersion!: string
	metadata: timoniv1.#Metadata & {#Version: moduleVersion}
	metadata: labels:       timoniv1.#Labels
	metadata: annotations?: timoniv1.#Annotations
	repository: {
		url!: string & =~"^(http|https|oci)://.*$"
		auth?: {
			username!: string
			password!: string
		}
		provider: *"generic" | "aws" | "azure" | "gcp"
		insecure: *false | bool
	}
	chart: {
		name!:   string
		version: string | *"*"
	}
	sync: {
		retries:             int | *-1
		interval:            int | *60
		timeout:             int | *5
		serviceAccountName?: string
		targetNamespace?:    string
	}
	driftDetection?: "enabled" | "warn" | "disabled"
	dependsOn?: [...{
		name:       string
		namespace?: string
	}]
	helmValues?: {...}
}

#Instance: {
	config: #Config
	objects: release: _HelmRelease & {#config: config}
	if config.sync.targetNamespace != _|_ {
		objects: namespace: _Namespace & {#config: config}
	}
	if strings.HasPrefix(config.repository.url, "oci://") {
		objects: repository: _OCIRepository & {#config: config}
		if config.repository.auth != _|_ {
			objects: secret: _OCIRepositoryAuth & {#config: config}
		}
	}
	if !strings.HasPrefix(config.repository.url, "oci://") {
		objects: repository: _HelmRepository & {#config: config}
		if config.repository.auth != _|_ {
			objects: secret: _HelmRepositoryAuth & {#config: config}
		}
	}
}
