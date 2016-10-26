#!/bin/bash
#Por : Lucas Macedo
#tutorial http://lucasmacedo.blog.br/backup-e-restauracao-de-bancos-no-mysql-via-shell-script/
#se você usar apenas usuário sem senha, use este linha abaixo
usuarioesenha="-u root -proot"

#pasta para exportação do banco
pasta_backup="/Users/Lucas/backup_banco"

#define o path do mysql, se estiver global deixe apenas "mysql" ex: C:\wamp\bin\mysql\mysql5.6.12\bin\mysql
_mysql="/Applications/MAMP/Library/bin/mysql"

#define o path do mysqldump, se estiver global deixe apenas "mysqldump" ex: C:\wamp\bin\mysql\mysql5.6.12\bin\mysqldump
_mysqldump="/Applications/MAMP/Library/bin/mysqldump"


databases=(`$_mysql -e "show databases" ${usuarioesenha}`)

if [ -d "$pasta_backup" ];
	then
		#MYSQL DUMP
		for database in "${databases[@]}"
		do
		    if [ $database != "Database" ] && [ $database != "information_schema" ] &&  [ $database != "performance_schema" ]; then
		        echo "Exportando banco: $database"
		        $_mysqldump ${usuarioesenha} ${database} > "$pasta_backup/$database.sql"
		    fi
		done

	else
		echo "Caminho : $pasta_backup não encontrado"

fi