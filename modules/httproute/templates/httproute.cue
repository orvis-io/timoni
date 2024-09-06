package templates

import (
	httproutev1 "gateway.networking.k8s.io/httproute/v1"
)

#HTTPRoute: httproutev1.#HTTPRoute & {
	#config:  #Config
	metadata: #config.metadata
	spec: {
		parentRefs: [#config.gateway]
		hostnames: #config.hostnames
		rules: [
			{
				backendRefs: [
					{
						kind:      "Service"
						name:      #config.service.name
						namespace: #config.service.namespace
					},
				]
				matches: [
					{
						path: {
							type:  "PathPrefix"
							value: "/"
						}
					},
				]
			},
		]
	}
}
