docker build -t chuckmdonaldson/multi-client:latest -t chuckmdonaldson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chuckmdonaldson/multi-server:latest -t chuckmdonaldson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chuckmdonaldson/multi-worker:latest -t chuckmdonaldson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chuckmdonaldson/multi-client:latest
docker push chuckmdonaldson/multi-server:latest
docker push chuckmdonaldson/multi-worker:latest

docker push chuckmdonaldson/multi-client:$SHA
docker push chuckmdonaldson/multi-server:$SHA
docker push chuckmdonaldson/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=chuckmdonaldson/multi-server:$SHA
kubectl set image deployments/client-deployment client=chuckmdonaldson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chuckmdonaldson/multi-worker:$SHA