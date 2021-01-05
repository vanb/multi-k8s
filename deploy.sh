docker build -t vanb/multi-client:latest -t vanb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vanb/multi-server:latest -t vanb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vanb/multi-worker:latest -t vanb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vanb/multi-client:latest
docker push vanb/multi-server:latest
docker push vanb/multi-worker:latest

docker push vanb/multi-client:$SHA
docker push vanb/multi-server:$SHA
docker push vanb/multi-worker:$SHA

kubectl apply -f k8s # this refers to some other server image but i guess it will be changed imperitively below
kubectl set image deployments/client-deployment client=vanb/multi-client:$SHA
kubectl set image deployments/server-deployment server=vanb/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=vanb/multi-worker:$SHA
