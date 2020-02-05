#!/usr/bin/env bash

echo 'Enter a url to a service layer.'

read url
param="/?f=json"
countparams="/query?where=0%3D0&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=&returnGeometry=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=true&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token="
id=$(curl "$url$param")

ui=$(echo "$id" | jq -r '.layers[].id')


for num in $ui
do 
 offset=0
 myurl="$url/MapServer/$num"
 count=$(curl "$myurl$countparams" | jq '.count')	
 maxcount=$(curl "$url$maxcountparam" | jq '.maxRecordCount')
 until [ $offset -gt $count ]
 do
  params="/query?where=1%3D1&geometryType=esriGeometryEnvelope&geometryPrecision=6&spatialRel=esriSpatialRelIntersects&outFields=*&resultOffset=${offset}&returnGeometry=false&returnZ=false&returnM=false&returnIdsOnly=false&returnCountOnly=false&returnDistinctValues=false&returnTrueCurves=false&returnExtentsOnly=false&f=json"
  newurl="$url$params"
  wget "$newurl" -O - >> $num.json
  ((offset=offset+$maxcount))
done
