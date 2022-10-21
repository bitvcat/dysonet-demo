#!/bin/bash
ip=`hostname -I`
cat /etc/ssl/openssl.cnf > openssl.cnf
cat >> openssl.cnf <<EOF
[SAN]
subjectAltName=DNS.1:www.xxx.com,DNS.2:*.xxx.com,IP.1:$ip
EOF

if [ ! -f openssl.cnf ]; then
    echo "openssl.cnf don't exist !!!"
    exit -1;
fi

openssl req \
-newkey rsa:2048 \
-x509 \
-nodes \
-keyout ../assets/ssl/server-key.pem \
-new \
-out ../assets/ssl/server-cert.pem \
-subj /C=CN/ST=GuangDong/L=GuangZhou/CN=xxx.com \
-extensions SAN \
-config openssl.cnf \
-sha256 \
-days 3650

rm openssl.cnf
echo "generate ok ..."
