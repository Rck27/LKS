command

Generate SSL certificate

openssl req -x509 -sha256 -newkey rsa:2048 -keyout /crt/out.key -out /crt/out.pem -days 365
#keyout adalah private key
#out adalah certificateFile



