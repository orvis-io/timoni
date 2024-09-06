package templates

import (
	grafanav1 "grafana.integreatly.org/grafana/v1beta1"
)

#Grafana: grafanav1.#Grafana & {
	#config:  #Config
	metadata: #config.metadata
	spec: {
		config:     #config.config
		deployment: #config.deployment
	}
}
