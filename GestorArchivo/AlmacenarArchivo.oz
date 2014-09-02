functor
import
   Archivo
export
   gestorArchivo:AlmacenarArchivo
define
   class AlmacenarArchivo

      meth init
	 skip
      end
      
      meth almacenarArchivo(Contenido RutaArchivo)
	 ArchivoAAlmacenar = {New Archivo.archivo init(RutaArchivo Contenido 'txt')}
      in
	 {ArchivoAAlmacenar almacenar}
      end
      
   end
end