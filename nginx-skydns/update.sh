docker rm -f nginx
docker build -t twnel/nginx-sky:latest .
source /etc/environment; docker run -d --name nginx -p 80:80 -p 443:433 -e DOMAIN=twnel.com -e REGION=beta -e HOST_IP=${COREOS_PRIVATE_IPV4} twnel/nginx-sky
docker logs nginx
