#!/bin/bash

path="$HOME/openvpn"
#path="/etc/openvpn/client" #Uncomment this line if your config files are in /etc/openvpn/client directory
choice="" #Contains the name files corresponding to the openvpn .conf
script="" #Script number choose by user 

echo "Script de connexion à openvpn, choisissez la config à utiliser"
choice=`ls -R  $path | grep .conf`

i=-1
for fichier in $choice
do
	let "i = i + 1"
	echo "$i $fichier"
	choice[$i]="$fichier"
done

read -p 'Entrer le nombre correspondant à la config : ' script

if [ $script -gt $i ] 
then
	echo "Nombre entré incorrect"

else
	x="${choice[$i]}"
	echo "Updating files database..."
	sudo updatedb #Updating database for locate function
	y=`locate $x`
	sudo openvpn $y 
fi
