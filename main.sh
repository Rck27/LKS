# piping atau | digunakan untuk memasukkan outputan dari suatu perintah ke perintah lain
# misal ls | grep "file.txt"       
# ls digunakan untuk menampilkan isi dari direktori
# grep digunakan untuk mencari kata tertentu dalam suatu file
# jadi output dari ls akan dimasukkan ke dalam grep untuk mencari file.txt


# redirection atau > < digunakan untuk mengalihkan outputan dari suatu perintah ke perintah lain
# > untuk output, misal ls > file.txt
# ls akan menampilkan isi direktori
# yang mana outputnya akan dimasukkan ke dalam file.txt
# > juga digunakan untuk membuat file baru, misal > file.txt
# sedangkan >> digunakan untuk menambahkan outputan ke dalam file yang sudah ada

# < untuk input, misal cat < file.txt
# cat akan menampilkan isi dari file.txt
# yang mana inputnya berasal dari file.txt


# sed adalah singkatan dari stream editor
# sed digunakan untuk mengedit isi dari suatu file
# misal sed "s/awal/akhir/" file.txt
# s adalah singkatan dari substitute
# jadi sed "s/awal/akhir/" file.txt
# akan mengganti kata awal menjadi akhir dalam file.txt
# sed "s/awal/akhir/g" file.txt
# g adalah singkatan dari global
# jadi sed "s/awal/akhir/g" file.txt
# akan mengganti semua kata awal menjadi akhir dalam file.txt
# sed "s/awal/akhir/2" file.txt
# 2 adalah angka
# jadi sed "s/awal/akhir/2" file.txt
# akan mengganti kata awal menjadi akhir pada baris ke 2 dalam file.txt
# sed "s/awal/akhir/2g" file.txt
# jadi sed "s/awal/akhir/2g" file.txt
# akan mengganti semua kata awal menjadi akhir pada baris ke 2 dalam file.txt
# sed "s/awal/akhir/2w file.txt" file.txt
# jadi sed "s/awal/akhir/2w file.txt" file.txt
# akan mengganti semua kata awal menjadi akhir pada baris ke 2 dalam file.txt
# dan seterusnya

# \n digunakan untuk membuat baris baru
# misal echo "baris pertama \n baris kedua"
# maka outputnya adalah
# baris pertama
# baris kedua
# gunakan echo -e agar dapat menggunakan \n


#!/bin/bash

domain="smkbisa.net"
ip="192.168.1.1"

apt install apache2 bind9 php php-mysqli mariadb mysql-server php-cli

a2enmod ssl

openssl req -x509 -sha256 -newkey rsa:2048 -keyout /crt/out.key -out /crt/out.pem -days 365

for i in {1..100}; do

useradd  -m -d /var/www/html/user$i user$i 
echo "user$i:12345" | chpasswd

sed "s,/html,/html/user$i \n ServerName www$i.$domain," 000-default.conf >> user$i.conf


sed -e "s,/html,/html/user$i \n ServerName www$i.$domain \n SSLCertificateFile /crt/out.pem \n SSLCertificateKeyFile /crt/out.key," -e "s,SSLCerti,#SSLDISABLED," default-ssl.conf >> user$i-ssl.conf
a2ensite user$i.conf
a2ensite user$i-ssl.conf

done

systemctl restart apache2
systemtl restart bind9

echo "www$i IN A $ip" >> /etc/bind/db.lks
echo "$digitTerakhir IN PTR $domain." >> /etc/bin/rev.lks


#misal ip server adalah 192.168.1.2 maka nilai dari $digitTerakhir adalah 2
#jadi dalam named.conf.local akan ada 2 zone yaitu db.lks dan rev.lks, rev lks menggunakan 3 digit awal dari ip yang dibalik
#misal 1.168.192.in-addr.arpa {type master; blablabla}


sed  "s/html/www$i \n ServerName $domain/" /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/www$i.conf
echo "<html><h1>user$i</h1></html>" >> /var/www/www$i/index.html
chown www-data:www-data /var/www/www$i; chmod -r 755 /var/www/www$i
a2ensite www$i.conf
