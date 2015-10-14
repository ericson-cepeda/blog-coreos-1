docker build -t twnel/nginx-sky:dev .

docker rm -f nginx
source /etc/environment; docker run -d --name nginx -p 80:80 -p 443:433 -e DOMAIN=twnel.com -e REGION=api -e CLUSTER=beta -e HOST_IP=${COREOS_PRIVATE_IPV4} twnel/nginx-sky:dev

docker logs nginx
