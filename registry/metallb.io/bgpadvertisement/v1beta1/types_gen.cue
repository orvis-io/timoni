// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://raw.githubusercontent.com/metallb/metallb/v0.14.8/config/manifests/metallb-native.yaml

package v1beta1

import "strings"

// BGPAdvertisement allows to advertise the IPs coming
// from the selected IPAddressPools via BGP, setting the
// parameters of the
// BGP Advertisement.
#BGPAdvertisement: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "metallb.io/v1beta1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "BGPAdvertisement"
	metadata!: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace!: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// BGPAdvertisementSpec defines the desired state of
	// BGPAdvertisement.
	spec!: #BGPAdvertisementSpec
}

// BGPAdvertisementSpec defines the desired state of
// BGPAdvertisement.
#BGPAdvertisementSpec: {
	// The aggregation-length advertisement option lets you “roll up”
	// the /32s into a larger prefix. Defaults to 32. Works for IPv4
	// addresses.
	aggregationLength?: int & >=1 | *32

	// The aggregation-length advertisement option lets you “roll up”
	// the /128s into a larger prefix. Defaults to 128. Works for
	// IPv6 addresses.
	aggregationLengthV6?: int | *128

	// The BGP communities to be associated with the announcement.
	// Each item can be a standard community of the
	// form 1234:1234, a large community of the form
	// large:1234:1234:1234 or the name of an alias defined in the
	// Community CRD.
	communities?: [...string]

	// A selector for the IPAddressPools which would get advertised
	// via this advertisement.
	// If no IPAddressPool is selected by this or by the list, the
	// advertisement is applied to all the IPAddressPools.
	ipAddressPoolSelectors?: [...{
		// matchExpressions is a list of label selector requirements. The
		// requirements are ANDed.
		matchExpressions?: [...{
			// key is the label key that the selector applies to.
			key: string

			// operator represents a key's relationship to a set of values.
			// Valid operators are In, NotIn, Exists and DoesNotExist.
			operator: string

			// values is an array of string values. If the operator is In or
			// NotIn,
			// the values array must be non-empty. If the operator is Exists
			// or DoesNotExist,
			// the values array must be empty. This array is replaced during a
			// strategic
			// merge patch.
			values?: [...string]
		}]

		// matchLabels is a map of {key,value} pairs. A single {key,value}
		// in the matchLabels
		// map is equivalent to an element of matchExpressions, whose key
		// field is "key", the
		// operator is "In", and the values array contains only "value".
		// The requirements are ANDed.
		matchLabels?: {
			[string]: string
		}
	}]

	// The list of IPAddressPools to advertise via this advertisement,
	// selected by name.
	ipAddressPools?: [...string]

	// The BGP LOCAL_PREF attribute which is used by BGP best path
	// algorithm,
	// Path with higher localpref is preferred over one with lower
	// localpref.
	localPref?: int

	// NodeSelectors allows to limit the nodes to announce as next
	// hops for the LoadBalancer IP. When empty, all the nodes having
	// are announced as next hops.
	nodeSelectors?: [...{
		// matchExpressions is a list of label selector requirements. The
		// requirements are ANDed.
		matchExpressions?: [...{
			// key is the label key that the selector applies to.
			key: string

			// operator represents a key's relationship to a set of values.
			// Valid operators are In, NotIn, Exists and DoesNotExist.
			operator: string

			// values is an array of string values. If the operator is In or
			// NotIn,
			// the values array must be non-empty. If the operator is Exists
			// or DoesNotExist,
			// the values array must be empty. This array is replaced during a
			// strategic
			// merge patch.
			values?: [...string]
		}]

		// matchLabels is a map of {key,value} pairs. A single {key,value}
		// in the matchLabels
		// map is equivalent to an element of matchExpressions, whose key
		// field is "key", the
		// operator is "In", and the values array contains only "value".
		// The requirements are ANDed.
		matchLabels?: {
			[string]: string
		}
	}]

	// Peers limits the bgppeer to advertise the ips of the selected
	// pools to.
	// When empty, the loadbalancer IP is announced to all the
	// BGPPeers configured.
	peers?: [...string]
}