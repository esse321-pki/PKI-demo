az login --identity
export AZURE_TENANT_ID=$(az account show --query tenantId --output tsv)
export AZURE_RESOURCE_GROUP=rg-my
export AZURE_PRIVATE_ZONE=true
az keyvault certificate create --vault-name my-kv-90345689023 --name testcert-001 --policy "$(cat policy)"|jq .csr>csr-file
sed -e 's|^\"|-----BEGIN CERTIFICATE REQUEST-----\n|' -e 's|\"$|\n-----END CERTIFICATE REQUEST-----|' -i csr-file
lego -a -m e@e.com --csr csr-file --dns azuredns --server 'https://10.0.11.4/ejbca/acme/eriktestintern/directory' --dns.propagation-disable-ans run
az keyvault certificate pending merge --vault-name my-kv-90345689023 --name testcert-001 --file .lego/certificates/vm.erik.local.crt
az keyvault certificate list --vault-name kv-pki-com-test-ne-001