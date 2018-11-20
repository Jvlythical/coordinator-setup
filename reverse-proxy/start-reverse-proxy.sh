docker run -d -p 80:80 -p 443:443 \
    --name nginx-proxy \
    -v $(pwd)/certs:/etc/nginx/certs:ro \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy


docker run -d \
    --name letsencrypt \
    -v $(pwd)/certs:/etc/nginx/certs:rw \
    --volumes-from nginx-proxy \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    jrcs/letsencrypt-nginx-proxy-companion

# For testing letsencrypt...
#-e "ACME_CA_URI=https://acme-staging.api.letsencrypt.org/directory" \
