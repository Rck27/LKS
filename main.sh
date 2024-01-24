#!/bin/bash
for i in {1..100}; do

useradd -d -m /var/www/html/user$i
echo "user$i:12345" | chpasswd

cd /etc/apache2/sites-available

sed "s,/html,/html/user$i \n ServerName www$i.smkbisa.net," 000-default.conf >> user$i.conf
sed -e "s,/html,/html/user$i \n ServerName www$i.smkbisa.net \n SSLCertificateFile /crt/out.pem \n SSLCertificateKeyFile /crt/out.key," -e "s,SSLCerti,#SSLDISABLED," default-ssl.conf >> user$i-ssl.conf
a2ensite user$i.conf
a2ensite user$i-ssl.conf

done

systemctl restart apache2
systemtl restart bind9

echo "www$i IN A 192.168.122.2" >> /etc/bind/db.lks
echo "2 IN PTR $domain." >> /etc/bin/rev.lks

sed -e 's/^$/ServerName $domain/' -e 's/html/www$i/' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/www$i.conf
echo "<html><h1>user$i</h1></html>" >> /var/www/www$i/index.html
chown www-data:www-data /var/www/www$i; chmod -r 755 /var/www/www$i
a2ensite www$i.conf
