#! /bin/bash 

# curl https://www.zhipin.com/job_detail/?query=网络运维&city=101200100&industry=&position= > index_url.txt  
url_str=`curl "https://www.zhipin.com/job_detail/?query=%E7%BD%91%E7%BB%9C%E8%BF%90%E7%BB%B4&city=101200100&industry=&position="` 

url=`echo "${url_str}" | grep 'data-index' | awk -F [\"] '{print $2}'`

for i in $url 
do 
    echo "https://www.zhipin.com${i}" >> index_url.txt 
    sleep 1 
done 
