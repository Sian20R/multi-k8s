docker build -t sian20r/multi-client:latest -t sian20r/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sian20r/multi-server:latest -t sian20r/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sian20r/multi-worker:latest -t sian20r/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sian20r/multi-client:latest
docker push sian20r/multi-server:latest
docker push sian20r/multi-worker:latest

docker push sian20r/multi-client:$SHA
docker push sian20r/multi-server:$SHA
docker push sian20r/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sian20r/multi-server:$SHA
kubectl set image deployments/client-deployment client=sian20r/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sian20r/multi-worker:$SHA