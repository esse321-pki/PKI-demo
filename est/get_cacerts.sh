curl  -o cacerts.b64 -H "Content-Type: application/pkcs10" -H "Content-Transfer-Encoding: base64" https://ca.erik.local/.well-known/est/estra/cacerts
sed -e '1i-----BEGIN PKCS7-----' -e '$a-----END PKCS7-----' cacerts.b64 > cacerts.pkcs7
openssl pkcs7 -print_certs -in cacerts.pkcs7 -out ../ca/clientca.cer