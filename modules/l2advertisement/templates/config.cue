package templates

import (
	"net"
	l2advertisementv1 "metallb.io/l2advertisement/v1beta1"
	timoniv1 "timoni.sh/core/v1alpha1"
)

#Config: {
	kubeVersion!: string
	clusterVersion: timoniv1.#SemVer & {#Version: kubeVersion, #Minimum: "1.20.0"}
	moduleVersion!: string
	metadata: timoniv1.#Metadata & {#Version: moduleVersion}
	metadata: labels:       timoniv1.#Labels
	metadata: annotations?: timoniv1.#Annotations
	addresses: [...net.IPCIDR]
	interfaces: l2advertisementv1.#L2AdvertisementSpec.interfaces | *[]
	nodeSelectors: l2advertisementv1.#L2AdvertisementSpec.nodeSelectors | *[]
}

#Instance: {
	config: #Config
	objects: {
		ipaddresspool: #IPAddressPool & {#config: config}
		l2advertisement: #L2Advertisement & {#config: config}
	}
}
