// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f crds.yaml

package v1alpha2

import (
	"strings"
	"list"
)

// ReferenceGrant identifies kinds of resources in other
// namespaces that are
// trusted to reference the specified kinds of resources in the
// same namespace
// as the policy.
//
//
// Each ReferenceGrant can be used to represent a unique trust
// relationship.
// Additional Reference Grants can be used to add to the set of
// trusted
// sources of inbound references for the namespace they are
// defined within.
//
//
// A ReferenceGrant is required for all cross-namespace references
// in Gateway API
// (with the exception of cross-namespace Route-Gateway
// attachment, which is
// governed by the AllowedRoutes configuration on the Gateway, and
// cross-namespace
// Service ParentRefs on a "consumer" mesh Route, which defines
// routing rules
// applicable only to workloads in the Route namespace).
// ReferenceGrants allowing
// a reference from a Route to a Service are only applicable to
// BackendRefs.
//
//
// ReferenceGrant is a form of runtime verification allowing users
// to assert
// which cross-namespace object references are permitted.
// Implementations that
// support ReferenceGrant MUST NOT permit cross-namespace
// references which have
// no grant, and MUST respond to the removal of a grant by
// revoking the access
// that the grant allowed.
#ReferenceGrant: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "gateway.networking.k8s.io/v1alpha2"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "ReferenceGrant"
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

	// Spec defines the desired state of ReferenceGrant.
	spec!: #ReferenceGrantSpec
}

// Spec defines the desired state of ReferenceGrant.
#ReferenceGrantSpec: {
	// From describes the trusted namespaces and kinds that can
	// reference the
	// resources described in "To". Each entry in this list MUST be
	// considered
	// to be an additional place that references can be valid from, or
	// to put
	// this another way, entries MUST be combined using OR.
	//
	//
	// Support: Core
	from: list.MaxItems(16) & [...{
		// Group is the group of the referent.
		// When empty, the Kubernetes core API group is inferred.
		//
		//
		// Support: Core
		group: strings.MaxRunes(253) & {
			=~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}

		// Kind is the kind of the referent. Although implementations may
		// support
		// additional resources, the following types are part of the
		// "Core"
		// support level for this field.
		//
		//
		// When used to permit a SecretObjectReference:
		//
		//
		// * Gateway
		//
		//
		// When used to permit a BackendObjectReference:
		//
		//
		// * GRPCRoute
		// * HTTPRoute
		// * TCPRoute
		// * TLSRoute
		// * UDPRoute
		kind: strings.MaxRunes(63) & strings.MinRunes(1) & {
			=~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
		}

		// Namespace is the namespace of the referent.
		//
		//
		// Support: Core
		namespace: strings.MaxRunes(63) & strings.MinRunes(1) & {
			=~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		}
	}] & [_, ...]

	// To describes the resources that may be referenced by the
	// resources
	// described in "From". Each entry in this list MUST be considered
	// to be an
	// additional place that references can be valid to, or to put
	// this another
	// way, entries MUST be combined using OR.
	//
	//
	// Support: Core
	to: list.MaxItems(16) & [...{
		// Group is the group of the referent.
		// When empty, the Kubernetes core API group is inferred.
		//
		//
		// Support: Core
		group: strings.MaxRunes(253) & {
			=~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}

		// Kind is the kind of the referent. Although implementations may
		// support
		// additional resources, the following types are part of the
		// "Core"
		// support level for this field:
		//
		//
		// * Secret when used to permit a SecretObjectReference
		// * Service when used to permit a BackendObjectReference
		kind: strings.MaxRunes(63) & strings.MinRunes(1) & {
			=~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
		}

		// Name is the name of the referent. When unspecified, this policy
		// refers to all resources of the specified Group and Kind in the
		// local
		// namespace.
		name?: strings.MaxRunes(253) & strings.MinRunes(1)
	}] & [_, ...]
}