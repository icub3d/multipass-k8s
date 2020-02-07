#!/usr/bin/fish

multipass exec $argv[1] -- /bin/bash -c 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -'
multipass exec $argv[1] -- /bin/bash -c 'echo deb https://apt.kubernetes.io/ kubernetes-xenial main | sudo tee /etc/apt/sources.list.d/kubernetes.list'
multipass exec $argv[1] -- sudo apt-get update
multipass exec $argv[1] -- sudo apt-get install -y kubelet kubeadm kubectl 
multipass exec $argv[1] -- sudo apt-mark hold kubelet kubeadm kubectl
