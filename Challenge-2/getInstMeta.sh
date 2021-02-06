echo "Below is the list of available metadata keys for this intsance:"
python meta2json.py | jq -r --arg METATYPE "meta-data" '.[$METATYPE]|keys'
read -p "Enter key name from above list: " KEYNAME

python meta2json.py | jq -r --arg KEYNAME "$KEYNAME" --arg METATYPE "meta-data" '.["meta-data"]|.[$KEYNAME]'