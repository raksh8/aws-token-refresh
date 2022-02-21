#!/bin/bash

ACCOUNT=349243291567
REGION=us-east-2
SECRET_NAME=${REGION}-ecr-registry
EMAIL=anymail.doesnt.matter@email.com
TOKEN=$"aws ecr get-login --region ${REGION} --registry-ids ${ACCOUNT} | cut -d' ' - f6"
echo "ENV variables setup done."
kubectl delete secret --ignore-not-found $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
--docker-server=https://${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com \
--docker-username=AWS \
--docker-password="${TOKEN}" \
--docker-email="${EMAIL}"
echo "Secret created by name. $SECRET_NAME"
kubectl patch serviceaccount default -p '{"imagePullSecrets":[{"name":"'$SECRET_NAME'"}]}'
echo "All done."
