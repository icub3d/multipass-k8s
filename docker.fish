#!/usr/bin/fish

multipass exec $argv[1] -- sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
multipass exec $argv[1] -- /bin/bash -c 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
multipass exec $argv[1] -- sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
multipass exec $argv[1] -- sudo apt-get update
multipass exec $argv[1] -- sudo mkdir -p /etc/systemd/system/docker.service.d /etc/docker/
multipass exec $argv[1] -- /bin/bash -c 'echo -e "[Service]\nExecStart=\nExecStart=/usr/bin/dockerd --containerd=/run/containerd/containerd.sock\n" | sudo tee /etc/systemd/system/docker.service.d/docker.conf'
multipass exec $argv[1] -- /bin/bash -c 'echo -e "{\"hosts\": [\"unix:///var/run/docker.sock\",\"tcp://0.0.0.0:2375\"]}" | sudo tee /etc/docker/daemon.json'
multipass exec $argv[1] -- sudo systemctl daemon-reload
multipass exec $argv[1] -- sudo apt-get install -y docker-ce docker-ce-cli containerd.io
multipass exec $argv[1] -- sudo systemctl enable --now docker
multipass exec $argv[1] -- sudo usermod -aG docker ubuntu
