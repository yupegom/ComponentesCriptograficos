functor
%import
 %  Browser
export
   archivo:Archivo
define
   class Archivo
      attr nombreArchivo contenido tipoArchivo
      meth init(NombreArchivo Contenido TipoArchivo)
	 nombreArchivo := NombreArchivo
	 contenido := Contenido
	 tipoArchivo := TipoArchivo
      end
      
      meth nombreArchivo(?NombreArchivo)
	 NombreArchivo = @nombreArchivo
      end

      meth contenido(?Contenido)
	 Contenido = @contenido
      end

      meth tipoArchivo(?TipoArchivo)
	 TipoArchivo = @tipoArchivo
      end
      
   end
end
