ESTPASSWORD=
mkdir newkey oldkey
openssl req -nodes -newkey rsa:3072 -keyout ./newkey/testEST.key   -out ./newkey/testEST.csr   -subj "/C=NO/O=Erik/CN=eriksinESTtest"
sed -i '/^-----BEGIN CERTIFICATE REQUEST-----$/d; /^-----END CERTIFICATE REQUEST-----$/d' ./newkey/testEST.csr 
curl --user est:$ESTPASSWORD --data @./newkey/testEST.csr  -o certs-p7.b64 -H "Content-Type: application/pkcs10" -H "Content-Transfer-Encoding: base64" https://ca.erik.local/.well-known/est/estra/simpleenroll
sed -e '1i-----BEGIN PKCS7-----' -e '$a-----END PKCS7-----' certs-p7.b64 > certificate.pkcs7
openssl pkcs7 -print_certs -in certificate.pkcs7  -out ./newkey/certs.pem -print_certs
openssl x509 -in ./newkey/certs.pem -text|head -11
rm certs-p7.b64 certificate.pkcs7