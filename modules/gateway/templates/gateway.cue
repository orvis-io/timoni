package templates

import (
	gatewayv1 "gateway.networking.k8s.io/gateway/v1"
)

#Gateway: gatewayv1.#Gateway & {
	#config: #Config
	metadata: {
		name:         #config.name
		namespace:    #config.metadata.namespace
		labels:       #config.metadata.labels
		annotations?: #config.metadata.annotations
	}
	spec: {
		gatewayClassName: #config.gatewayClassName
		listeners:        #config.listeners
	}
}
