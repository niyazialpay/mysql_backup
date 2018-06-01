mkdir -p /root/mysql_yedek
cd /root/mysql_yedek
echo "show databases;" | mysql -u admin -p`cat /etc/psa/.psa.shadow` |egrep -vi 'information_schema|performance_schema|mysql|phpmyadmin|psa|roundcubemail|horde|Database' > databaseslist.txt
while read line
do
        mysqldump -u admin -p`cat /etc/psa/.psa.shadow` $line > $line.sql
		
		tar -cvzf $line.tar.gz $line.sql
		rm -rf $line.sql
done <databaseslist.txt
rm -rf databaseslist.txt

