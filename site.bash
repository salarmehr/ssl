######################
# Create CA-signed certs
######################

NAME=${1:-localhost} # Use your own domain name
mkdir $NAME
# Generate a private key
openssl genrsa -out $NAME/server.key 2048
# Create a certificate-signing request
openssl req -new -key $NAME/server.key -out $NAME/server.csr
# Create a config file for the extensions
>$NAME/server.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $NAME # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = bar.$NAME # Optionally, add additional domains (I've added a subdomain here)
IP.1 = 192.168.0.13 # Optionally, add an IP address (if the connection which you have planned requires it)
EOF
# Create the signed certificate
openssl x509 -req -in $NAME/server.csr -CA root.pem -CAkey root.key -CAcreateserial \
-out $NAME/server.crt -days 825 -sha256 -extfile $NAME/server.ext
