#!/usr/bin/fish

multipass exec $argv[1] -- sudo kubeadm init --pod-network-cidr=10.244.0.0/16
multipass exec $argv[1] -- mkdir -p .kube
multipass exec $argv[1] -- sudo cp -i /etc/kubernetes/admin.conf .kube/config
multipass exec $argv[1] -- sudo chown ubuntu .kube/config
multipass exec $argv[1] -- kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "waiting 30 seconds for flannel to come up"
sleep 30

set join (string trim (multipass exec $argv[1] -- sudo kubeadm token create --print-join-command | grep join))
for n in $argv[2..-1]
	multipass exec $n -- /bin/bash -c "sudo $join"
end
