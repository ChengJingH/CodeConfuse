#!/usr/bin/env bash

#维护数据库
#TABLENAME=symbols

#项目名称
SYMBOL_DB_FILE=""
#混淆函数列表
STRING_SYMBOL_FILE="func.list"
#宏定义配置函数
HEAD_FILE="$PROJECT_DIR/$PROJECT_NAME/codeObfuscation.h"

#数据
export LC_CTYPE=C

##维护数据库方便日后作排重
#createTable()
#{
#echo "create table $TABLENAME(src text, des text);" | sqlite3 $SYMBOL_DB_FILE
#}
#
#insertValue()
#{
#echo "insert into $TABLENAME values('$1' ,'$2');" | sqlite3 $SYMBOL_DB_FILE
#}
#
#query()
#{
#echo "select * from $TABLENAME where src='$1';" | sqlite3 $SYMBOL_DB_FILE
#}

#base64加密
ramdomString()
{
openssl rand -base64 64 | tr -cd 'a-zA-Z' |head -c 16
}

#rm -f $SYMBOL_DB_FILE
rm -f $HEAD_FILE
#createTable

touch $HEAD_FILE
echo '#ifndef Demo_codeObfuscation_h' >> $HEAD_FILE
echo '#define Demo_codeObfuscation_h' >> $HEAD_FILE
echo "//confuse string at `date`" >> $HEAD_FILE

cat "$STRING_SYMBOL_FILE" | while read -ra line; do
if [[ ! -z "$line" ]]; then
ramdom=`ramdomString`
echo $line $ramdom
#insertValue $line $ramdom
echo "#define $line $ramdom" >> $HEAD_FILE
fi
done
echo "#endif" >> $HEAD_FILE

#sqlite3 $SYMBOL_DB_FILE .dump
