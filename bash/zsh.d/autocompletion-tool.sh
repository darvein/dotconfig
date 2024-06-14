#!/bin/bash

rm -rf *.autocomplete

awless completion zsh > ~/.zsh.d/awless.autocomplete
helm completion zsh > ~/.zsh.d/helm.autocomplete
kubectl completion zsh > ~/.zsh.d/kubectl.autocomplete
docker completion zsh > ~/.zsh.d/docker.autocomplete

echo "complete -o nospace -C /usr/bin/terraform terraform" > ~/.zsh.d/terraform.autocomplete
echo "complete -C /usr/local/bin/aws_completer aws" > ~/.zsh.d/aws.autocomplete
