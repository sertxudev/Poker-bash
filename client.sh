#!/bin/bash

# formato de la mano del jugador
# carta está compuesta de "numero o figura" seguido de "palo"
# números posibles: A,2,3,4,5,6,7,8,9,X,J,Q,K    palos posibles: C,D,T,P

# mano="AC 4T"

function comprobarCarta(){
	carta=$( echo $1 | egrep '^[aA23456789XJKQ][PCDT]$' ) 

	if [ "$carta" != $1 ] ; then return 1; fi
	return 0
}

function comprobarMano(){
	if [ $# -ne 2 ] ; then return 1; fi

	if comprobarCarta $1 && comprobarCarta $2 ; then
		return 0;
	else
		return 1;
	fi
}

function mostrarMano(){
	una=$( echo $1 | tr c h | tr t c | tr p s | tr [a-z] [A-Z] )
	dos=$( echo $2 | tr c h | tr t c | tr p s | tr [a-z] [A-Z] )

	# eog "imagenes/$una.png" &
	# eog "imagenes/$dos.png" &
	echo -e "+---------------------------------------------------------------+"
	echo -e "|\t\t\t\t\t\t\t\t|"
	echo -e "|\t\t  POKER 666 - Sertxu Developer  \t\t|"
	echo -e "|\t\t\t\t\t\t\t\t|"
	echo -e "|\t+-----------------------------------------------+\t|"
	echo -e "|\t|                                               |\t|"
  	echo -e "|\t|\t$una\t$dos\t$una\t$dos\t$una\t|\t|"
	echo -e "|\t|                                               |\t|"
	echo -e "|\t+-----------------------------------------------+\t|"
	echo -e "|\t\t\t\t\t\t\t\t|"
	echo -e "|\t\t\t\t\t\t\t\t|"
  	echo -e "|\t\t$una\t$dos\t\t\t\t\t|"
	echo -e "|\t\t\t\t\t\t\t\t|"
	echo -e "+---------------------------------------------------------------+"
}

mostrarMano 3C 4P
mano[0]="AC 4T"
mano[1]="11C 4T"
mano[2]="XA 4T"
mano[3]="XT 4T"
mano[4]="AC AP"
mano[5]="AC AP 4T"
mano[6]="5C 9X"

cuenta=0;
while [ $cuenta -lt ${#mano[@]} ] ; do
	if comprobarMano ${mano[$cuenta]} ; then
		echo "la mano ${mano[$cuenta]} es correcta"
	else
		echo "la mano ${mano[$cuenta]} es incorrecta"
	fi
	((cuenta++))
done


mano="Ac 4t"

if comprobarMano $mano ; then
	echo "la mano $mano es correcta"
fi

