#! /bin/bash 

# https://www.zhipin.com/job_detail/b8947511e6ce331803Zz39y1FFY~.html?ka=search_list_1
# url='https://www.zhipin.com/job_detail/b8947511e6ce331803Zz39y1FFY~.html?ka=search_list_1'
# url='https://www.zhipin.com/job_detail/87cf2d737bfebbdf1HZz0925F1A~.html?ka=search_list_2' 
# url='https://www.zhipin.com/job_detail/9553caba63e13b9303R429-5EVs~.html?ka=search_list_6' 
# url='https://www.zhipin.com/job_detail/87cf2d737bfebbdf1HZz0925F1A~.html?ka=search_list_4_blank&lid=1CwjQEy0QWW.search'
# url='https://www.zhipin.com/job_detail/d112ec5fc84b99071HRz39m-FlM~.html?ka=search_list_1' 
# url='https://www.zhipin.com/job_detail/9553caba63e13b9303R429-5EVs~.html?ka=search_list_2' 
# url='https://www.zhipin.com/job_detail/4c0042e9a5b4bc2303R92ti9GVI~.html?ka=search_list_1' 
# url='https://www.zhipin.com/job_detail/319bb8d27e1cdfd01Hx93d67EFs~.html?ka=search_list_1_blank&lid=1CvZrIXE3V8.search'
# url='https://www.zhipin.com/job_detail/8159e1a7c4e0d7b003R-39u8EFo~.html?ka=search_list_1'
# url='https://www.zhipin.com/job_detail/11a400b48860f91c1Xd52tm_E1s~.html?ka=search_list_19_blank&lid=1CwjQEy0QWW.search'

for i in `cat index_url.txt` 
do 
    curl --connect-timeout 5 "$i" > web.txt 
    \cp web.txt cp_web.html 
    bash -x grep_web.sh
done 

