cluster:
	multipass launch -n cluster0 -c 2 -d 40G -m 4G
	multipass launch -n cluster1 -c 2 -d 40G -m 4G
	multipass launch -n cluster2 -c 2 -d 40G -m 4G
	multipass exec cluster0 -- /bin/bash -c 'sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y'
	multipass exec cluster1 -- /bin/bash -c 'sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y'
	multipass exec cluster2 -- /bin/bash -c 'sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y'

	multipass restart cluster0 cluster1 cluster2

k8s:
	./k8s-tools.fish cluster0
	./k8s-tools.fish cluster1
	./k8s-tools.fish cluster2

	./k8s.fish cluster0 cluster1 cluster2

config-k8s:
	mkdir -p ~/.kube
	multipass exec cluster0 -- cat .kube/config > ~/.kube/config

docker-host:
	@echo set -x DOCKER_HOST $(shell multipass ls | grep cluster0 | awk '{print $$3;}')

docker-swarm:
	./docker.fish cluster0
	./docker.fish cluster1
	./docker.fish cluster2

	./swarm.fish cluster0 cluster1 cluster2

clean:
	multipass delete cluster0 cluster1 cluster2
	multipass purge
