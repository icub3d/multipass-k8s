#!/usr/bin/fish

multipass exec $argv[1] -- docker swarm init

set join (string trim -- (multipass exec $argv[1] -- docker swarm join-token manager | grep 'docker swarm join --token'))

for n in $argv[2..-1]
	multipass exec $n -- /bin/bash -c $join
end
