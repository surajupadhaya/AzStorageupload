#!/bin/sh
currentdate=$(date)
Inputfile=input.txt
if [ ! -f "$Inputfile" ];then
        echo -e "\n$Inputfile does not exists" >>  /var/tmp/script.log
        exit 1
fi
source $Inputfile
dir= #file path that need backup
for filename in $dir; do
url="https://${accountname}.blob.core.windows.net/${containername}/$(date +'%Y'_'%m'_'%d')/"$filename""${SharedAccessSignature}""
Response=$(curl -o response.txt -s -w "%{http_code}" -H "x-ms-blob-type:BlockBlob" -H "x-ms-access-tier:Cool" --upload-file "$filename" "${url}")
echo $Response
if [[ $Response == 201 ]];then
        echo -e "\n$currentdate -- $1 -- Upload is successfull  $Response OK" >>  /var/tmp/script.log

elif [[ $Response == 403 ]];then
        echo -e "\n$currentdate -- $1 --  Upload unsuccessfull error code $Response->SAS token expire Please recreate" >>  /var/tmp/script.log
        exit 1
else
        echo -e "\n $currentdate- -- $1 --  Upload unsuccessfull error code $Response \n" >>  /var/tmp/script.log
        exit 1

fi
done
