#!/bin/bash
docker build -t ouokki/passTime-backend .
docker push ouokki/passTime-backend

ssh deploy@$DEPLOY_SERVER << EOF
docker pull ouokki/passTime-backend
docker stop api-boilerplate || true
docker rm api-boilerplate || true
docker rmi ouokki/passTime-backend:current || true
docker tag ouokki/passTime-backend:latest ouokki/passTime-backend:current
docker run -d --restart always --name api-boilerplate -p 3000:3000 ouokki/passTime-backend:current
EOF
