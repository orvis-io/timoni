// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f crds.yaml

package v1beta1

import "strings"

// GrafanaAlertRuleGroup is the Schema for the
// grafanaalertrulegroups API
#GrafanaAlertRuleGroup: {
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
	kind: "GrafanaAlertRuleGroup"
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

	// GrafanaAlertRuleGroupSpec defines the desired state of
	// GrafanaAlertRuleGroup
	spec!: #GrafanaAlertRuleGroupSpec
}

// GrafanaAlertRuleGroupSpec defines the desired state of
// GrafanaAlertRuleGroup
#GrafanaAlertRuleGroupSpec: {
	allowCrossNamespaceImport?: bool

	// Match GrafanaFolders CRs to infer the uid
	folderRef?: string

	// UID of the folder containing this rule group
	// Overrides the FolderSelector
	folderUID?: string

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
	interval:      =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
	resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$" | *"10m"
	rules: [...{
		annotations?: {
			[string]: string
		}
		condition: string
		data: [...{
			// Grafana data source unique identifier; it should be '__expr__'
			// for a Server Side Expression operation.
			datasourceUid?: string

			// JSON is the raw JSON query and includes the above properties as
			// well as custom properties.
			model?: _

			// QueryType is an optional identifier for the type of query.
			// It can be used to distinguish different types of queries.
			queryType?: string

			// RefID is the unique identifier of the query, set by the
			// frontend call.
			refId?: string

			// relative time range
			relativeTimeRange?: {
				// from
				from?: int

				// to
				to?: int
			}
		}]
		execErrState: "OK" | "Alerting" | "Error" | "KeepLast"
		for:          =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
		isPaused?:    bool
		labels?: {
			[string]: string
		}
		noDataState: "Alerting" | "NoData" | "OK" | "KeepLast"
		notificationSettings?: {
			group_by?: [...string]
			group_interval?: string
			group_wait?:     string
			mute_time_intervals?: [...string]
			receiver:         string
			repeat_interval?: string
		}
		title: strings.MaxRunes(190) & strings.MinRunes(1)
		uid:   =~"^[a-zA-Z0-9-_]+$"
	}]
}
