// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f crds.yaml

package v1beta1

import "strings"

// GrafanaFolder is the Schema for the grafanafolders API
#GrafanaFolder: {
	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "grafana.integreatly.org/v1beta1"

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "GrafanaFolder"
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

	// GrafanaFolderSpec defines the desired state of GrafanaFolder
	spec!: #GrafanaFolderSpec
}

// GrafanaFolderSpec defines the desired state of GrafanaFolder
#GrafanaFolderSpec: {
	// allow to import this resources from an operator in a different
	// namespace
	allowCrossNamespaceImport?: bool

	// selects Grafanas for import
	instanceSelector: {
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
	}

	// Reference to an existing GrafanaFolder CR in the same namespace
	parentFolderRef?: string

	// UID of the folder in which the current folder should be created
	parentFolderUID?: string

	// raw json with folder permissions
	permissions?: string

	// how often the folder is synced, defaults to 5m if not set
	resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$" | *"5m"
	title?:        string
}