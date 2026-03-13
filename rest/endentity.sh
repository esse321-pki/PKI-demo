IT=$(shuf -i 1000-10000 -n 1)
SAN="DNS:*.erik.local"
SANREST=$(echo  $SAN|sed -e 's/DNS:/DNSNAME=/g')
openssl req -nodes -newkey rsa:4096 \
  -keyout test${IT}.key \
  -out test${IT}.csr \
  -subj "CN=test.erik.local"  \
  -addext "subjectAltName = ${SAN} " 

CSR=$(awk 'NR>2 { sub(/\r/, ""); printf "%s",last} { last=$0 }' test${IT}.csr)
username=eriktest-0000${IT}
endentity_data="{\
            \"username\":\"${username}\", \
            \"password\":\"0DQP9IWYzWeK9vYRy3br\", \
            \"subject_dn\":\"CN=test.erik.local\", \
            \"ca_name\":\"TLSSUBCA\", \
            \"certificate_profile_name\":\"cp_eep_tls\", \
            \"subject_alt_name\":\"${SANREST}\", \
            \"end_entity_profile_name\":\"eep_tls\", \
            \"token\":\"USERGENERATED\"\
        }"

curl   --request POST \
    --url https://ca.erik.local/ejbca/ejbca-rest-api/v1/endentity \
    --header 'content-type: application/json' \
    --cert rest.cer \
        --key rest.key \
        --data "$(echo $endentity_data)"
echo $username