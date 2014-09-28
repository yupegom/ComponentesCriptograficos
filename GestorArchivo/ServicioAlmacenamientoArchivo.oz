functor
import
   Archivo
export
   gestorArchivo:ServicioAlmacenamientoArchivo
define

   class ServicioAlmacenamientoArchivo

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