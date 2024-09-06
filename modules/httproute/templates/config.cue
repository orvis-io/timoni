package templates

import (
	"list"
	"strings"
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
	gateway: {
		name: strings.MaxRunes(253) & strings.MinRunes(1)
		namespace: strings.MaxRunes(63) & strings.MinRunes(1) & {
			=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		} | *metadata.namespace
		sectionName: strings.MaxRunes(253) & strings.MinRunes(1) & {
			=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		} | *"https"
	}
	hostnames: list.MaxItems(16) & [...strings.MaxRunes(253) & strings.MinRunes(1) & =~"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"] | *[]
	service: {
		name: strings.MaxRunes(63) & strings.MinRunes(1) & {=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"}
		namespace: strings.MaxRunes(63) & strings.MinRunes(1) & {
			=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		} | *metadata.namespace
		port: int
	}
}

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: #Config

	objects: {
		httproute: #HTTPRoute & {#config: config}
	}
}
