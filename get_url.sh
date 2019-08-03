#! /bin/bash 

# curl https://www.zhipin.com/job_detail/?query=网络运维&city=101200100&industry=&position= > index_url.txt  
# url_str=`curl "https://www.zhipin.com/job_detail/?query=%E7%BD%91%E7%BB%9C%E8%BF%90%E7%BB%B4&city=101200100&industry=&position="` 

rm -rf index_url.txt 

# citycode = {"北京":"101010100","上海":"101020100","天津":"101030100","重庆":"101040100",
# "哈尔滨":"101050100","长春":"101060100","沈阳":"101070100","呼和浩特":"101080100","石家庄":"101090100",
# "太原":"101100100","西安":"101110100","济南":"101120100","乌鲁木齐":"101130100","西宁":"101150100",
# "兰州":"101160100","银川":"101170100","郑州":"101180100","南京":"101190100","武汉":"101200100",
# "杭州":"101210100","合肥":"101220100","福州":"101230100","南昌":"101240100","长沙":"101250100",
# "贵阳":"101260100","成都":"101270100","广州":"101280100","昆明":"101290100","南宁":"101300100",
# "海口":"101310100","台湾":"101341100","拉萨":"101140100","香港":"101320300","澳门":"101330100"}


read -p "请输入招聘 职位 * 公司:" info 

# 字符串编码
url_coding=$(echo "${info}" | xxd -plaion | sed 's/\(..\)/%\1/g')

# 访问网页
URL_str=`curl -H 'content-type:text/html;charset=utf-8' https://www.zhipin.com/job_detail/?query="${url_coding}"&city=101200100&industry=&position=`

# 过滤URL地址
url=`echo "${URL_str}" | grep 'data-index' | awk -F [\"] '{print $2}'`
if [ -z "${url}" ]; then 
    echo -e "\033[31m\t搜索失败...\033[0m" 
    sleep 1 
    exit 0 
fi 

# 收集URL地址
for i in $url 
do 
    echo "https://www.zhipin.com${i}" >> index_url.txt 
    [ ! -s index_url.txt ] && echo -e "\033[31m\t没找到您想要的数据...\033[0m`exit 0`"
done 

