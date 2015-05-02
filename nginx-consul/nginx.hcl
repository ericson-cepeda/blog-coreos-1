retry = "10s"
max_stale = "10m"

syslog {
  enabled = true
  facility = "LOCAL5"
}

template {
  source = "/consul/templates/nginx.conf.tmpl"
  destination = "/etc/nginx/sites-enabled/app.conf"
  command = "/usr/sbin/service nginx reload"
}