#!/bin/bash

numero=0;

while [ "$respuesta" != "Asertaste" ] ; do
	echo $numero
	read resultado
	echo "client- respuesta leída  para número $numero: $resultado" >> fichero
	(( numero++ ))
	sleep 1
done

# echo $resultado  // esto no funcionaría por pantalla, porque la salida estándar está conectada con su puta madre.


