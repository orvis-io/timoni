package templates

import (
	gatewayclassv1 "gateway.networking.k8s.io/gatewayclass/v1"
)

#GatewayClass: gatewayclassv1.#GatewayClass & {
	#config: #Config
	metadata: {
		name:         #config.name
		labels:       #config.metadata.labels
		annotations?: #config.metadata.annotations
	}
	spec: controllerName: #config.controllerName
}
