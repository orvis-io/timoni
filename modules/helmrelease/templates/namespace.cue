package templates

import (
	corev1 "k8s.io/api/core/v1"
)

_Namespace: corev1.#Namespace & {
	#config:    #Config
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		name:         #config.sync.targetNamespace
		labels:       #config.metadata.labels
		annotations?: #config.metadata.annotations
	}
}
