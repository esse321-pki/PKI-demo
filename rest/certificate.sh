IT=$(cat it)
username=eriktest-0000${IT}
CSR=$(awk 'NR>2 { sub(/\r/, ""); printf "%s",last} { last=$0 }' test${IT}.csr)
certificaterequest_data="{\
              \"username\":\"${username}\", \
              \"password\":\"0DQP9IWYzWeK9vYRy3br\", \
              \"certificate_authority_name\":\"TLSSUBCA\", \
              \"include_chain\":\"false\", \
              \"certificate_request\":\"${CSR}\" \
			  }"
curl  --request POST --url https://ca.erik.local/ejbca/ejbca-rest-api/v1/certificate/certificaterequest \
      --header 'accept: application/json' \
      --header 'Content-Type: application/json' \
      --cert rest.cer \
      --key rest.key \
      -o test$IT.response \
      --data "$(echo $certificaterequest_data)"
jq .certificate test$IT.response|sed -e 's|^\"|-----BEGIN CERTIFICATE-----\n|' -e 's|\"$|\n-----END CERTIFICATE-----|'|openssl x509 -text|head -11
