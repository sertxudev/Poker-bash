#!/bin/bash

# opción 1 : un vector de 52 Elementos (todas las cartas están en el mismo vector)
# tres de picas
# ¿Qué contien cada elemento ? Cada elemento es una cadena del estilo "4P"
#¿Donde guardaría el cuatro de picas?  Proponemos un vector secuenciado y ordenado por 
# primero por palos y después por números : AP, 2P, 3P, ...,KP,AC,2C,3C, ... QC,AD,...,AT
# ¿Qué orden cogemos para palos ? el orden del corazones: 
# =============================> T,D,P,C <==============================
# AT,2T,3T,4T,5T,6T,7T,8T,9T,XT,JT,QT,KT,AD,2D,....


# ¿Dónde está el cuatro de picas? picas es el tercer palo (o sea, el número 2)
#	cuatro es la cuarta carta (o sea, la núm 3)


function obtenerIndice() {
	# me pasan "4P" y devuelvo "29"   T, D, P, C
	carta=$1

	# la variable "numero" contiene exactamente lo que aparece al principio de la carta
	# (excluyendo el palo) 4P -> numero=4    XC -> numero=X 
	numero=$( echo $carta | cut -c1 )
	palo=$( echo $carta | cut -c2 )

	valorPalo=$( echo $palo | tr TDPC 0123 )

	# Ahora convierto el numero con el "otro" número... que es el útil para la formula
	case $numero in

		A ) valorNumero=0;
			;;
		X ) valorNumero=9;
			;;
		J ) valorNumero=10;
			;;
		Q ) valorNumero=11;
			;;
		K ) valorNumero=12;
			;;
		* )	valorNumero=$( expr $numero - 1 )	
	esac

	# y aquí está la fórmula:
	resultado=$(( 13 * $valorPalo + $valorNumero )) 
	echo $resultado;
}

function inicializarBaraja(){
	#Inicializar la baraja entera ubicando todos los elementos (o cartas) en la baraja
	i=0;
	while [ $i -lt 52 ] ; do
		baraja[$i]="baraja"
		(( i++ ))
	done
}

function mostrarBaraja(){
	indice=0;
	echo  "--------------- Estado cartas ------------------"
	while [ $indice -lt 52 ] ; do

		resto=$( expr $indice % 13 )
		if [ $resto -eq 0 ] ; then
			echo ""
			palo=$( expr $indice / 13 | tr 0123 tdpc)
			echo -e -n '\033[0m'"$palo "
		fi
		if [ ${baraja[$indice]} == "baraja" ] ; then
			echo -e -n '\033[0m'"${baraja[$indice]} "
		else
		  if [ ${baraja[$indice]} == "mesa" ] ; then
   		    echo -e -n '\033[0;101m''\033[1;34m'"${baraja[$indice]}"
		  else
		    echo -e -n '\033[0;103m''\033[1;31m''\033[5m''\033[4m'"${baraja[$indice]}"
		fi
		echo -e -n '\033[0m'" "
	       fi
		(( indice++ ))
	done
	echo -e -n '\033[0m'"\n----------------------------------------------\n"
}

function comprobarJugador(){
    veces=$( echo ${baraja[@]} | grep -o $1 | wc -l )
    if [ $veces -eq 2 ] ; then
	return 0;
    fi
    return 1;
}

function reparteCarta(){
	local destino=$1
	
	if [ -z "$destino" ] ; then
		destino="mesa";
	fi

	pos=$( expr $RANDOM % 52 )
	while [ ${baraja[$pos]} != "baraja" ] ; do
		pos=$( expr $RANDOM % 52 )
	done
	baraja[$pos]=$destino

}

function repartirAJugadores(){
# el objetivo es repartir 2 cartas a cada jugador
# los jugadores son pasados por argumentos. La función se debe invocar 
# repartirAJugadores juan perico andres

	local jugador="";

	while [ -n "$1" ] ;  do
		jugador=$1
		reparteCarta $jugador		
		reparteCarta $jugador
		shift;
	done;
}

function flop(){
	reparteCarta;
	reparteCarta;
	reparteCarta;
}

function turn(){
	reparteCarta;
}

function river(){
	reparteCarta;
}

function manoJugador(){
  local jugador=$1
  local resultado=""
  indice=0;
  while [ $indice -lt 52 ] ; do
     if [ ${baraja[$indice]} == "mesa" ] || [ ${baraja[$indice]} == "$jugador" ] ; then
		resultado="$resultado $indice"
     fi
     (( indice++ ))
  done
  echo $resultado
}

# ver si el jugador tiene dos cartas con el mísmo número
function pareja(){
	local jugador=$1

	mano=$( manoJugador $jugador ) 
	# mano es una lista de cartas "absolutas" con la mano del jugador
	for carta in $mano ; do 
		echo $carta
	done

	# he de obtener la lista de cartas relativas al palo (usar el módulo)
	# al mismo tiempo construyo un vector para manipular depsués buscanod parejas

	local vectorAux;
	# doble bucle while anidado que recorre el vector y compara cada elemento
	# con todos los demás


}

cartas[0]=4p
cartas[1]=5p
cartas[2]=10c
cartas[3]=10t
cartas[4]=At

contador=0;
cuenta=0;
while [ $cuenta -lt ${#cartas[@]} ] ; do
	echo "la carta ${cartas[$cuenta]} tiene índice= $( obtenerIndice ${cartas[$cuenta]} )"
	((cuenta++))
done

jugador[0]=juan
jugador[1]=perico
jugador[2]=andres
jugador[3]=vicente


# repartir cartas a los jugadores

echo "Inicializando"
inicializarBaraja;
echo "repartiendo "
repartirAJugadores ${jugador[@]};
echo "Flop"
flop;
echo "Turn"
turn;
echo "River"
river;
mostrarBaraja;

manoJugador ${jugador[1]}



