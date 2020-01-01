docker build -t bpremkumar/multi-client:latest -t bpremkumar/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t bpremkumar/multi-server:latest -t bpremkumar/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t bpremkumar/multi-worker:latest -t bpremkumar/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push bpremkumar/multi-client:latest
docker push bpremkumar/multi-server:latest
docker push bpremkumar/multi-worker:latest
docker push bpremkumar/multi-client:$GIT_SHA
docker push bpremkumar/multi-server:$GIT_SHA
docker push bpremkumar/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bpremkumar/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=bpremkumar/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=bpremkumar/multi-worker:$GIT_SHA
