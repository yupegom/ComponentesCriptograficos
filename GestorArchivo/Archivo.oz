functor
import
   Browser
   Open
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

      meth almacenar()
	 try
	    File={New Open.file init(name:{self nombreArchivo($)} flags:[write create truncate])} in
	    {File write(vs:{self contenido($)})} 
	    {File close}
	 catch X then {Browser.browse 'Excepción: ' #X# ' No se pudo almacenar el archivo deseado.' }
	 end
      end
   end
end
