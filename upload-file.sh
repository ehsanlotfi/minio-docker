bucket=bt1300
file=test3.png

host=play.min.io:9000
s3_key=Q3AM3UQ867SPQQA43P2F
s3_secret=zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG

resource="/${bucket}/${file}"
content_type="application/octet-stream"
date=`date -R`
_signature="PUT\n\n${content_type}\n${date}\n${resource}"
signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`

curl -X PUT -T "${file}" \
          -H "Host: ${host}" \
          -H "Date: ${date}" \
          -H "Content-Type: ${content_type}" \
          -H "Authorization: AWS ${s3_key}:${signature}" \
          https://${host}${resource}
