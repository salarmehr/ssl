######################
# Become a Certificate Authority
######################

# Generate private key
openssl genrsa -des3 -out root.key 2048
# Generate root certificate
openssl req -x509 -new -nodes -key root.key -sha256 -days 825 -out root.pem
