FROM phusion/baseimage:latest
MAINTAINER Ericson Cepeda <ericson@picorb.com>

# Install Nginx
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx curl

# Install Consul Template
ADD https://github.com/hashicorp/consul-template/releases/download/v0.9.0/consul-template_0.9.0_linux_amd64.tar.gz /tmp/
RUN tar -C /usr/local/bin --strip-components 1 -zxf /tmp/consul-template_0.9.0_linux_amd64.tar.gz

# Create directories
WORKDIR /consul
VOLUME /consul/templates /consul/config

# Add confd files
ADD ./nginx.conf.tmpl /consul/templates/nginx.conf.tmpl
ADD ./nginx.hcl /consul/config/nginx.hcl

# Remove default site
# RUN rm -f /etc/nginx/sites-enabled/default

# Add boot script
ADD ./boot.sh /opt/boot.sh
RUN chmod +x /opt/boot.sh

VOLUME ["/etc/nginx/certs"]

# Run the boot script
CMD /opt/boot.sh
