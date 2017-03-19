#!/bin/bash
#Avtor: Andrej Mernik, 2009-2017, https://andrej.mernik.eu/
#Licenca: GPLv3

#Mapa, kjer se nahajajo datoteke
SRCDIR="/home/uporabnik/arhivi/zip/"

#Mapa, v katero bi radi razsirili datoteke
DIR="/home/uporabnik/arhivi/razsirjeni/"

if [ -d $SRCDIR ]
	then
		if [ -d $DIR ] 
		then
			echo "Ciljna mapa obstaja!"
		else
			mkdir "$DIR"
			echo "Mapa "$DIR" ustvarjena!"
		fi
		COUNT=0
		for i in "$SRCDIR"*.zip;
		do
		#odstranimo SRCDIR, kot razmejilnik sem uporabil |, ker je malo mozno, da bi nastopal v imenu datoteke
		TMPNAME=`echo -e "$i" | sed "s|$SRCDIR||g"`
		#odstranimo pripono .zip
		REALNAME=`echo -e "$TMPNAME" | sed "s/.zip//g"`
		#odstranimo presledke v imenih datotek, ker jih unzip ne mara :)
		NAME=`echo -e "$REALNAME" | sed "s/ /_/g"`
		#obdelovanje
		echo "Razsirjam $NAME"
		unzip -q "$i" -d "$DIR$NAME"
		let COUNT=COUNT+1
		done
		echo "Koncano. Razsirjenih $COUNT arhivov!"
else
echo "Napaka. Mapa "$SRCDIR" ne obstaja!"
fi
