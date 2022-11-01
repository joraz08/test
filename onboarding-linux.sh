# Add the service principal application ID and secret here
servicePrincipalClientId="fda7c2de-4369-4449-beae-d0447d8218d8";
servicePrincipalSecret="kAV8Q~qQ~LLP9z8rRz6onnDJ~Z6alnTNYaVN5aer";


export subscriptionId="67e3289f-ecc9-44ab-840b-20eb34d81fd6";
export resourceGroup="JRRZ-ARC";
export tenantId="d12ca1ca-63a6-411e-a6f0-fdaaa084b214";
export location="westeurope";
export authType="principal";
export correlationId="242b83b2-4165-42e6-af95-b4f5dc25d54b";
export cloud="AzureCloud";

# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";


