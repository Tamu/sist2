#!/bin/bash

# Nead JQ : apt install jq
DOCKERREGISTRY=hub.mintello.com
IMAGENAME=sist2
# --------------------------------


# Tag & Build for prod
CURVERSION=$(curl -sX GET https://p5:Mintello4fun@$DOCKERREGISTRY/v2/$IMAGENAME/tags/list | jq -r '.tags[-2]')
NEWVERSION=$(echo "($CURVERSION + 0.1)" | bc)
echo "Last version : $CURVERSION / new version : $NEWVERSION"
read -p "Enter $IMAGENAME image version: " VERSION

DOCKERIMAGE=$DOCKERREGISTRY/$IMAGENAME
docker build -t $DOCKERIMAGE .
docker tag $DOCKERIMAGE:latest $DOCKERIMAGE:$VERSION
docker push $DOCKERIMAGE:$VERSION
docker push $DOCKERIMAGE:latest

