// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f crds.yaml

package v2

import "strings"

// CiliumIdentity is a CRD that represents an identity managed by
// Cilium. It is intended as a backing store for identity
// allocation, acting as the global coordination backend, and can
// be used in place of a KVStore (such as etcd). The name of the
// CRD is the numeric identity and the labels on the CRD object
// are the kubernetes sourced labels seen by cilium. This is
// currently the only label source possible when running under
// kubernetes. Non-kubernetes labels are filtered but all labels,
// from all sources, are places in the SecurityLabels field.
// These also include the source and are used to define the
// identity. The labels under metav1.ObjectMeta can be used when
// searching for CiliumIdentity instances that include particular
// labels. This can be done with invocations such as:
// kubectl get ciliumid -l 'foo=bar'
#CiliumIdentity: {
	// APIVersion defines the versioned schema of this representation
	// of an object. Servers should convert recognized schemas to the
	// latest internal value, and may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "cilium.io/v2"

	// Kind is a string value representing the REST resource this
	// object represents. Servers may infer this from the endpoint
	// the client submits requests to. Cannot be updated. In
	// CamelCase. More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "CiliumIdentity"
	metadata: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace?: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// SecurityLabels is the source-of-truth set of labels for this
	// identity.
	"security-labels": {
		[string]: string
	}
}