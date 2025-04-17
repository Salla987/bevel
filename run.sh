#!/bin/bash
##############################################################################################
#  Copyright Accenture. All Rights Reserved.
#
#  SPDX-License-Identifier: Apache-2.0
##############################################################################################

set -e

echo "Starting build process..."

echo "Adding env variables..."
export PATH=/root/bin:$PATH

# Path to k8s config file
export KUBECONFIG=/home/ali/blockchain/hyperledger-bevel/bevel/project/bevel/bevel/build/config

echo "Validatin network yaml"
ajv validate -s /home/ali/blockchain/hyperledger-bevel/bevel/project/bevel/bevel/platforms/network-schema.json -d /home/ali/blockchain/hyperledger-bevel/bevel/project/bevel/bevel/build/network.yaml 

echo "Running the playbook..."
exec ansible-playbook -vv /home/ali/blockchain/hyperledger-bevel/bevel/project/bevel/bevel/platforms/shared/configuration/site.yaml --inventory-file=/home/ali/blockchain/hyperledger-bevel/bevel/project/bevel/bevel/platforms/shared/inventory/ -e "@//home/ali/blockchain/hyperledger-bevel/bevel/project/bevel/bevel/build/network.yaml" -e 'ansible_python_interpreter=/usr/bin/python3' --ask-become-pass
