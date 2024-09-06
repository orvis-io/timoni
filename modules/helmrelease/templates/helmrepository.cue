package templates

import (
	helmrepov1 "source.toolkit.fluxcd.io/helmrepository/v1"
)

_HelmRepository: helmrepov1.#HelmRepository & {
	#config:  #Config
	metadata: #config.metadata
	spec: helmrepov1.#HelmRepositorySpec & {
		interval: "12h"
		url:      #config.repository.url
		if #config.repository.auth != _|_ {
			secretRef: name: "\(#config.metadata.name)-helm-auth"
		}
		if #config.repository.insecure {
			insecure: true
		}
		provider: #config.repository.provider
	}
}

_HelmRepositoryAuth: {
	#config:    #Config
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		name:      "\(#config.metadata.name)-helm-auth"
		namespace: #config.metadata.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}
	stringData: {
		if #config.repository.auth != _|_ {
			username: #config.repository.auth.username
			password: #config.repository.auth.password
		}
	}
}
