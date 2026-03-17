IT=$(shuf -i 1000-10000 -n 1)
SAN="DNS:test.erik.local"
SANREST=$(echo  $SAN|sed -e 's/DNS:/DNSNAME=/g')
openssl req -nodes -newkey rsa:4096 \
  -keyout /tmp/test${IT}.key \
  -out /tmp/test${IT}.csr \
  -subj "/C=NO/O=Erik/CN=test.erik.local"  \
  -addext "subjectAltName = ${SAN} " 

CSR=$(awk 'NR>2 { sub(/\r/, ""); printf "%s",last} { last=$0 }' /tmp/test${IT}.csr)
username=eriktest-0000${IT}


pkcs10enroll_data="{\
  \"certificate_request\":\"${CSR}\", \
  \"certificate_profile_name\":\"cp_eep_tls\", \
  \"end_entity_profile_name\":\"eep_tls\", \
  \"certificate_authority_name\":\"TLSSUBCA\", \
  \"username\":\"${username}\", \
  \"password\":\"0DQP9IWYzWeK9vYRy3br\" \
  }"

curl  --request POST --url https://ca.erik.local/ejbca/ejbca-rest-api/v1/certificate/pkcs10enroll \
      --header 'accept: application/json' \
      --header 'Content-Type: application/json' \
      --cert rest.cer \
      --key rest.key \
      -o test$IT.response \
      --data "$(echo $pkcs10enroll_data)"

jq .certificate test$IT.response|sed -e 's|^\"|-----BEGIN CERTIFICATE-----\n|' -e 's|\"$|\n-----END CERTIFICATE-----|'|openssl x509 -text|head -11
