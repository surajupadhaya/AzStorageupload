# AzStorageupload

This script  will upload servers devices or any other platforms either logs , backup  or any files to Azure Storage Account with Cool blob type .
First you need to create Storage Account and generate SAS token having expiration and add it into input.txt file with account and container name .

Once its uploaded , if now we want to download it we can use Az shell commands .

#This will get us the lists of Blob stored

az storage blob list --container-name nameofconatainer --account-name nameofaccount --query "[].{name:name}"

#using the blob names you can use here to download 

az storage blob download --blob-url https://accountname.blob.core.windows.net/containername/filename --file downloadfilename


