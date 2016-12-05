class VentasController < ApplicationController
  def index
    rutaData = "public/data/referidos.txt"
    dni = "42146964"
    $data = cargarData( rutaData )
    insercionDirecta
    ind = buscar(dni)
    if ind > -1 then
      @cliente = $data[ind].split(',')
    else
      @cliente = []
    end
  end

  def insercionDirecta
    indMayor = $data.size-1
    for i in 1..indMayor
        j = i-1
    	while ( j >= 0 && $data[i] <= $data[j] )
    		j = j-1
    	end
    	valor = $data[i]
    	k=i
    	while k > j+1
    		$data[k] = $data[k-1]
    		k = k-1
    	end
    	$data[j+1] = valor
    end
  end

  def buscar(valor)
    indMen = 0
    indMay = $data.size-1
    indMedio= ( indMen + indMay ) / 2
    while ( indMen <= indMay ) && !( $data[indMedio].include? valor )
    	if valor > $data[indMedio] then
    		indMen = indMedio+1
    	else
    		indMay = indMedio-1
    	end
    	indMedio = ( indMen + indMay ) / 2
    end
    if $data[indMedio].include? valor then
    	indice = indMedio
    else
    	indice = -1
    end
    return indice
  end

  def cargarData( archivo )
    arch = File.new(archivo, 'r')
    data = Array.new
    data = arch.readlines
    return data
  end
end
