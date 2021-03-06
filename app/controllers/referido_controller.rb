class ReferidoController < ApplicationController
  def index
    rutaData = "public/data/referidos.txt"
    datos = cargarData( rutaData )
    data = crearLista( datos )
    @referidos = recorrerLista( data )
  end

  def add
    rutaData = "public/data/referidos.txt"
    datos = cargarData( rutaData )
    lista = crearLista( datos )
    if request.post? then
      codigo = params[:codigo]
      nombre = params[:nombre]
      dni = params[:dni]
      elemento = codigo.to_s + "," + nombre.to_s + "," + dni.to_s
      agregarData(rutaData, elemento)
      insertarListaFin(lista, elemento)
    end
  end

  def delete
    pos = params[:pos]
    rutaData = "public/data/referidos.txt"
    datos = cargarData( rutaData )
    lista = crearLista( datos )
    lista = eliminarElementoPosicion(lista, pos)
  end

  def cargarData( archivo )
    arch = File.new(archivo, 'r')
    data = Array.new
    data = arch.readlines
    return data
  end

  def agregarData( archivo, registro )
    File.new(archivo, 'w') do |file|
      file.write "/n" + registro
    end
  end

  def crearLista( datos )
    lista = nil
    for i in 0...datos.size
      nodo = [datos[datos.size-1-i],nil]
      nodo[1] = lista
      lista = nodo
    end
    return lista
  end

  def insertarListaFin(lista, elemento)
    nodo = lista
    if(nodo == nil)
      lista = elemento
    else
      while nodo != nil
        if nodo[1] == nil then
          nodo[1] = elemento
          break
        else
          nodo = nodo[1]
        end
      end
    end
    return lista
  end

  def eliminarElementoPosicion(lista, pos)
    nodo = lista
    if lista == nil
      return lista
    else
      if pos == 1
        lista = lista[1]
      else
        anterior = lista
        nodo = nodo[1]
        cont = 2
        while nodo != nil
          if(cont==pos)
            anterior[1] = nodo[1]
            break
          else
            anterior = nodo
            nodo=nodo[1]
            cont = cont + 1
          end
        end	
      end
    end
    return lista 
  end

  def recorrerLista(lista)
  	nodo = lista
    campos = Array.new
    while nodo != nil
      fila = nodo[0]
      campos.push( fila.split(',') )
      nodo = nodo[1]
    end
    return campos
  end
end
