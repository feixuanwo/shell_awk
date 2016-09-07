#匹配空行 ，如果是空行则输出Blank line
awk '/^$/ {print "Blank line"}' awk.txt

#打印包含主机名的行，没有指定动作，默认动作为打印
awk '/HOSTNAME/' /etc/sysconfig/network

# $0存储awk一次读取的整条记录，记录被分割为字段依次存储在$1,$2...
# 內建变量NF为记录的字段的个数，$NF为读取的行中的最后一个字段
echo hello the world | awk '{print $1, $2, $3}'
echo hello the world | awk '{print $0}'
echo hello the world | awk '{print NF}'
echo hello the world | awk '{print $NF}'

#改变分隔符
awk -F: '{print $1}' /etc/passwd
awk 'BEGIN {FS = ":"} {print $1}' /etc/passwd
#指定多个分隔符
echo 'hello the:world,!' | awk 'BEGIN {FS = "[:, ]"} {print $1, $2, $3, $4}'

#输出当前文档的当前行号
awk '{print FNR}' awk.txt awk.txt1
#将两个文档合为一个输入流，通过NR输入当前编号
awk '{print NR}' awk.txt*

#获取文件每行地段个数，默认以空格分隔
awk '{print NF}' awk.txt

#指定输出分隔符
awk 'BEGIN {OPS = "-"} {print $1, $2, $3}' awk.txt

#以空白行为记录分隔符，以\n为地段分隔符
awk 'BEGIN {FS = "\n"; RS = ""} {print $3}' awk.mail

#取出第一个域匹配/root/的记录, ~:匹配 ~!:不匹配
awk -F: '$1~/root/ {print $3}' /etc/passwd

#取出第三个域大于500的
awk -F: '$3 > 500 {print $1}' /etc/passwd

#if else 在awk中的应用
df | grep "boot" | awk '{if($4 < 20000) print "Alart"; else print "OK"}'

#while 在awk中的应用
awk 'i=1 {} BEGIN {while (i<=10){++1; print i}}' awk.txt
awk 'BEGIN {do {++x; print x} while (x<=10)}' awk.txt

#for 在awk中的应用
awk 'BEGIN {for(i=1; i<=10; i++) print i}' awk.txt
awk 'BEGIN {for(i=10; i>=1; i--) print i}' awk.txt

#continue/break
awk 'BEGIN {for(i=1; i<=10; i++){if(i==5)contiune; print i}}'
awk 'BEGIN {for(i=1; i<=10; i++){if(i==5)break; print i}}'

#rand和srand  如果不用srand则rand每次的数值都一样
awk 'BEGIN {print rand();srand(); print rand()}'
awk 'BEGIN {print rand(); print rand()}'

#gsub/sub在awk中的应用 gsub替换所有 sub替换第一个
awk -F: 'gsub(/root/, "helo", $0) {print $0}' /etc/passwd
awk -F: 'sub(/root/, "helo", $0) {print $0}' /etc/passwd

#length在awk中的应用
awk '{print length()}' awk.txt

#处理特殊行例如df的输出有可能出现折行的情况

awk '{if(NF==1){getline;print $3};if(NF==6){print $4}}' df
awk 'BEGIN {print "Disk Free:"} {if(NF==1){getline; print $4}; if(NF==6)print $4}' df
