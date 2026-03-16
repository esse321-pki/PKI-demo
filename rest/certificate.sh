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
      --data "$(echo $certificaterequest_data)"