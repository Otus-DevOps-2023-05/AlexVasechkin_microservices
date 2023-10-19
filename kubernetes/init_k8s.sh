#!/bin/bash
kubeadm init \
 --apiserver-cert-extra-sans=<external_ip> \
 --apiserver-advertise-address=0.0.0.0 \
 --control-plane-endpoint=<external_ip> \
 --pod-network-cidr=192.168.0.0/16
