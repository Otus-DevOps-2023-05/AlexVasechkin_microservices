#!/bin/bash
docker-machine create \
 --driver generic \
 --generic-ip-address=<external_ip> \
 --generic-ssh-user <user> \
 --generic-ssh-key ~/.ssh/id_rsa \
 <hostname>

docker build -t aleksandervas/post:1.0 ./post-py
docker build -t aleksandervas/comment:1.0 ./comment
docker build -t aleksandervas/ui:1.0 ./ui

docker network create reddit

docker volume create reddit_db

docker run -d --network=reddit --network-alias=post_db \
 --network-alias=comment_db -v reddit_db:/data/db mongo:latest \ &&
docker run -d --network=reddit --network-alias=post aleksandervas/post:1.0 \ &&
docker run -d --network=reddit --network-alias=comment aleksandervas/comment:1.0 \ &&
docker run -d --network=reddit -p 9292:9292 aleksandervas/ui:2.0

docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest \ &&
docker run -d --network=back_net --name post aleksandervas/post:1.0 \ &&
docker run -d --network=back_net --name comment aleksandervas/comment:1.0 \ &&
docker run -d --network=front_net -p 9292:9292 --name ui aleksandervas/ui:2.0

docker network connect front_net post
docker network connect front_net comment
