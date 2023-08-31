docker run --rm -it -p 80:80 \
 -v /isaac/data/certificates:/etc/letsencrypt \
 certbot/certbot certonly\
  --standalone \
  --domains superset.isaacscience.org \
  --cert-name superset.isaacscience.org \
  --email webmaster@isaacphysics.org \
  --no-eff-email \
  --agree-tos