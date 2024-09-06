module: "timoni.orvis.io/helmrelease"
language: {
	version: "v0.9.2"
}
source: {
	kind: "self"
}
deps: {
	"helm.toolkit.fluxcd.io@v0": {
		v: "v0.0.2"
	}
	"k8s.io@v0": {
		v: "v0.0.2"
	}
	"source.toolkit.fluxcd.io@v0": {
		v: "v0.0.2"
	}
	"timoni.sh@v0": {
		v: "v0.0.2"
	}
}
