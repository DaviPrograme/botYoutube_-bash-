#!/bin/bash


wget -O nome.html $1 > /dev/null 2>&1
clear
#Esta função ela captura o nome do canal do youtube:
function Nome_Canal () {
	local CANAL=$(cat nome.html | grep "\/channel\/" | cut -d'>' -f2 | cut -d'<' -f1 | grep -v "^$" | grep -v " $")
	#local TT=$(echo $CANAL | cut -c-10)
	if [ -z "$CANAL" ]
	then
		echo "Nome do Canal: NÃO ENCONTRADO!"
		return 1
	fi
	
	echo "Nome do Canal: $CANAL"
	return 0
}

#Esta função captura o nome do video:
function Titulo_Video () {
	local VIDEO=$(cat nome.html | grep '<title>' | sed 's/ - YouTube.*//' | cut -d'>' -f2)

	if test -z "$VIDEO"
	then
		echo "Titulo do Video: NÃO ENCONTRADO!"
		return 1
	fi

	echo "Titulo do Video: $VIDEO"
	return 0
}

#Esta função captura a quantidade de "LIKES" de um video no youtube:
function Qtd_Like () {
	local LIKE=$(cat nome.html | grep "like" | tr '>' '\n' | grep -v '>\n[a-Z]'| cut -d':' -f1 | grep "[0-9]<" | head -1 | cut -d'<' -f1)

	if [ -z $LIKE ]
        then
                echo "Quantidade de Likes: NÃO ENCONTRADO!"
                return 1
        fi
	
	echo "Quantidade de Likes: $LIKE"
	return 0
}

#Esta função captura a quantidade de "DESLIKES" de um video no youtube:
function Qtd_Deslike () {
	local DESLIKE=$(cat nome.html | grep "like" | tr '>' '\n' | grep -v '>\n[a-Z]'| cut -d':' -f1 | grep "[0-9]<" | sed '1,2d' | sed '2d' | cut -d'<' -f1)

	if test -z "$DESLIKE"
        then
                echo "Quantidade de Deslikes: NÃO ENCONTRADO!"
                return 1
        fi

	echo "Quantidade de Deslikes: $DESLIKE"
	return 0
}

#Esta Função captura a quantidade de VISUALIZAÇÕES que um video do youtube tem:
function Qtd_Views () {
	local VIEW=$(cat nome.html | grep "watch-view-count" | cut -d'=' -f4 | cut -d' ' -f1 | cut -d'>' -f2)

	if test -z "$VIEW"
        then
                echo "Quantidade de Visualizações: NÃO ENCONTRADO!"
                return 1
        fi

	echo "Quantidade de Visualizações: $VIEW"
	return 0
}


echo "======================================================================"
echo "                             BOT YOUTUBE                              "
echo "======================================================================"
echo ""

Nome_Canal $1
Titulo_Video $1
Qtd_Like $1
Qtd_Deslike $1
Qtd_Views $1

echo ""
echo "======================================================================"
echo "                             BOT YOUTUBE                              "
echo "======================================================================"
