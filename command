command

generate SSL certificate (use .crt and .key)
STEP 1: Create the server private key

openssl genrsa -out cert.key 2048
STEP 2: Create the certificate signing request (CSR)

openssl req -new -key cert.key -out cert.csr
STEP 3: Sign the certificate using the private key and CSR

openssl x509 -req -days 3650 -in cert.csr -signkey cert.key -out cert.crt


