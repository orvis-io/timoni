package templates

import (
	ipaddresspoolv1 "metallb.io/ipaddresspool/v1beta1"
)

#IPAddressPool: ipaddresspoolv1.#IPAddressPool & {
	#config:  #Config
	metadata: #config.metadata
	spec: addresses: #config.addresses
}
