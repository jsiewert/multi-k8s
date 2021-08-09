docker build -t jstalle/multi-client:latest -t jstalle/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jstalle/multi-server:latest -t jstalle/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jstalle/multi-worker:latest -t jstalle/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jstalle/multi-client:latest
docker push jstalle/multi-server:latest
docker push jstalle/multi-worker:latest

docker push jstalle/multi-client:$SHA
docker push jstalle/multi-server:$SHA
docker push jstalle/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jstalle/multi-server:$SHA
kubectl set image deployments/client-deployment client=jstalle/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jstalle/multi-worker:$SHA