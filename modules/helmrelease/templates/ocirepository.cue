package templates

import (
	"strings"
	ocirepov1 "source.toolkit.fluxcd.io/ocirepository/v1beta2"
	timoniv1 "timoni.sh/core/v1alpha1"
)

_OCIRepository: ocirepov1.#OCIRepository & {
	#config:  #Config
	metadata: #config.metadata
	spec: ocirepov1.#OCIRepositorySpec & {
		interval: "\(#config.sync.interval)m"
		url:      #config.repository.url + "/" + #config.chart.name
		ref: semver: #config.chart.version
		provider: #config.repository.provider
		if #config.repository.auth != _|_ {
			secretRef: name: "\(#config.metadata.name)-helm-auth"
		}
		if #config.repository.insecure {
			insecure: #config.repository.insecure
		}
	}
}

_OCIRepositoryAuth: timoniv1.#ImagePullSecret & {
	#config:   #Config
	#Meta:     #config.metadata
	#Suffix:   "-helm-auth"
	#Registry: strings.Split(#config.repository.url, "/")[2]
	#Username: #config.repository.auth.username
	#Password: #config.repository.auth.password
}
