
echo "enter a first name"

read first

echo "enter a last name"

read last

echo "enter state"

read state

echo "abbreviated form"

read abbrev


#enterother relatives


url="https://www.legacy.com/search?countryId=366899&countryUrl=united-states-of-america&dateRange=All&firstName=${first,,}&lastName=${last,,}&stateAbbrev=${abbrev^^}&stateId=366861&stateUrl=${state,,}"


var3=$(curl $url)
j=$(echo "$var3" | xidel -  -s  -e "/html/body/script[9]/text()")
u=$(echo "$j" | sed  's/window.__INITIAL_STATE__ = //g'| sed 's/};/}/g'  )

k=$(echo "$u" | xidel -  -s  -e '($json).SearchStore.results')

l=$(echo "$k" | jq -c '.[]' | jq '.displayText')


txtKey=$(echo "$l" | sed -e 's;<[^>]*>;;g'| tr -d '\n\'| sed 's;}{;}\'$'\n{;g')



#txtKeys=$(echo "$l" | sed -e 's;<[^>]*>;;g'| tr -d '\n\')

echo "$txtKey" 
echo "$txtKey" #> "$first$last".txt