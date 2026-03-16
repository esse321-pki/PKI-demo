az login --identity
export AZURE_TENANT_ID=$(az account show --query tenantId --output tsv)
export AZURE_RESOURCE_GROUP=rg-my
export AZURE_PRIVATE_ZONE=true
export AZURE_KEY_VAULT_NAME=my-kv-90345689023
IT=$(shuf -i 1000-10000 -n 1)
az keyvault certificate create --vault-name $AZURE_KEY_VAULT_NAME --name testcert-$IT --policy "$(cat policy)"|jq .csr>csr-file
sed -e 's|^\"|-----BEGIN CERTIFICATE REQUEST-----\n|' -e 's|\"$|\n-----END CERTIFICATE REQUEST-----|' -i csr-file
~/go/bin/lego -a -m e@e.com --csr csr-file --dns azuredns --server 'https://ca.erik.local/ejbca/acme/eriktestintern/directory' --dns.propagation-disable-ans run
openssl x509 -in .lego/certificates/vm.erik.local.crt -text|head -20
az keyvault certificate pending merge --vault-name $AZURE_KEY_VAULT_NAME --name testcert-$IT --file .lego/certificates/vm.erik.local.crt
az keyvault certificate list --vault-name $AZURE_KEY_VAULT_NAME