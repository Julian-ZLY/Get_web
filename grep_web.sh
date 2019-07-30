#! /bin/bash 

touch result.txt 

function grep_str() { 
    # 删除匹配到关键字一下所有行
    sed -i '/<p>点击查看地图<\/p>/,$d' cp_web.html  
    
    # 更新时间
    up_time=$(cat cp_web.html | grep -E '<p class="gray".*[0-9]</p>' | gawk -F [\>\<] '{print $3}')  

    # 招聘标题
    title=$(cat cp_web.html | grep '<title>【' | grep '<title>【' | gawk -F [\>\<] '{print "\t"$3"\n"}')
    
    # 招聘状态
    job_status=$(cat cp_web.html | grep '<div class="job-status"' | gawk -F [\>\<] '{print "招聘状态:\t"$3"\n"}')
    
    # 招聘基本要求
    basic_requirements=$(cat cp_web.html | grep '<p>.*<em class=' | gawk -F [\>\<] '{print "基本要求:\t"$3,$7,$11,$15}')
    
    # 招聘岗位
    row_num=$(cat cp_web.html | grep -n '<h1>' | gawk -F : 'END{print $1}')
    next_row_num=$[ $row_num + 1 ] 
    job_name=$(sed -n ''$row_num'p' cp_web.html | gawk -F [\>\<] '{print "招聘岗位:\t"$3}')  

    # 参考薪资
    job_money=$(sed -n ''$next_row_num'p' cp_web.html | gawk -F [\>\<] '{print "参考薪资:\t"$3}')  
    
    # 工作福利
    job_welfare=$(cat cp_web.html | grep '</span><span>'| gawk -F [\>\<] 'END{print "工作福利:\n","\t"$3,$7,$11,$15,$19,$23,$27}')
    
    # 招聘人
    HR=$(cat cp_web.html | grep '<h2 class="name">' | gawk -F [\>\<] '{print "信息发起人:\t"$3"\n"}') 
    
    # 招聘人信息
    HR_info=$(cat cp_web.html | grep -E '<p class="gray">.*<em' | gawk -F [\>\<] 'END{print $3,$5,$7}')
 
    # 删除匹配到关键字以上所有行
    row_num=$(cat cp_web.html | gawk '/<h3>职位描述<\/h3>/{print NR}') 
    sed -i '1,'$row_num'd' cp_web.html 
    
    # 获取公司工商信息
    business_information=$(cat cp_web.html | sed -n '/<h3>工商信息<\/h3>/,$p')
    information=$(echo "$business_information" | gawk -F [\>\<] '{print $3,$5,$7}') 
    
    
    # 删除工商信息 
    row_num=$(cat cp_web.html | gawk '/<h3>竞争力分析<\/h3>/{print NR}')
    sed -i ''$row_num',$d' cp_web.html 
    
    
    # 筛选招聘要求
    str_01=$(cat cp_web.html | sed  's/<\/*[a-z]*>//g') 
    str_02=$(echo "$str_01" | gawk -F [\>\<] '{print " "$3"\n",$5"\n",$7"\n",$9"\n",$11"\n",$13"\n",$15"\n",$17"\n",$19"\n",$21"\n"}') 
    recruitment_info=$(echo "$str_02" | grep -En '[0-9]|要求|资格' | gawk '{print $2"\n"}' | sed 's/^[0-9]/\ \ \ \ &/g') 
    
    
    # 筛选公司简介
    row_num=$(cat cp_web.html |  grep -n '<div class="text">' | gawk -F : 'END{print $1}')
    sed -i '1,'$row_num'd' cp_web.html 
    
    work_info=$(cat cp_web.html | sed  '/<.*>/d')
    # echo "${work_info}" >> result.txt 
    
    
    echo "${information}" >> result.txt 
} 


# 编排文本
function string() { 
    grep_str 

    # 更新时间
    echo "${up_time}" > result.txt    

    # 招聘标题
    echo -e "${title}\n" >> result.txt 
    
    # 招聘岗位
    echo "${job_name}" >> result.txt 

    # 招聘发起人;招聘人信息
    echo "${HR}    ${HR_info}" >> result.txt 
    
    # 招聘状态
    echo "${job_status}" >> result.txt 
    
    # 招聘基本要求
    echo "${basic_requirements}" >> result.txt 
    
    # 参考薪资
    echo "${job_money}" >> result.txt 

    # 工作福利
    echo -e  "${job_welfare}\n" >> result.txt 

    # 工作职责;招聘要求
    echo -e "职位信息:\n${recruitment_info}\n" >> result.txt 
    

    # 工商信息
    echo "${information}" >> result.txt 

} 

string 





















