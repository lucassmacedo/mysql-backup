#!/bin/bash
#By: Lucas macedo
#Defina seu usuário e senha
#tutorial http://lucasmacedo.blog.br/backup-e-restauracao-de-bancos-no-mysql-via-shell-script/
usuarioesenha="-u root -proot"

#define o path do mysql, se estiver global deixe apenas "mysql" ou wamp/mamp ex: C:\wamp\bin\mysql\mysql5.6.12\bin\mysql
_mysql="/Applications/MAMP/Library/bin/mysql"

#busca todas databases
databases=(`$mysql -e "show databases" ${usuarioesenha}`)

#define a pasta que tem os arquivos .sql a serem importados
FOLDER=/Users/Lucas/backup_banco/*

if [ -d "$FOLDER" ];
	then
		for FILE in $FOLDER
		do
			#define o nome dos arquivos sem a extensão e caminho ex: banco_api
		   db_name=$(echo $FILE | sed 's/.*\///' | cut -f 1 -d '.')

		   # armazena o resultado da consulta (se já existe banco com este nome)
		   output=$($_mysql -s -N -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name = '${db_name}'" information_schema)

		     if [[ -z "${output}" ]]; then
			    echo "create database $db_name CHARACTER SET utf8 COLLATE utf8_general_ci;" | $_mysql $usuarioesenha

			    $_mysql $usuarioesenha $db_name < $FILE

			    echo "Banco '$db_name' foi criado e importado com sucesso!"
			  else
			    echo "Banco '$db_name' já existe!"
			  fi

		done
	else
		echo "Caminho : $FOLDER não encontrado"

fi