package templates

import (
	l2advertisementv1 "metallb.io/l2advertisement/v1beta1"
)

#L2Advertisement: l2advertisementv1.#L2Advertisement & {
	#config:  #Config
	metadata: #config.metadata
	spec: {
		interfaces: #config.interfaces
		ipAddressPools: [#config.metadata.name]
		nodeSelectors: #config.nodeSelectors
	}
}
