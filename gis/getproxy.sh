
ipresponse=$(curl 'https://gimmeproxy.com/api/getProxy')

ip=$(echo "$ipresponse" | jq '.ipPort')
ipt=$(echo $ipresponse | jq '.type')


echo "$ip"
echo "$ipt"


