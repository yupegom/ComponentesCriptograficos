functor
import
   Open
   Archivo
export
   gestorArchivo:ServicioOperacionesArchivo
define

   class ServicioOperacionesArchivo

   meth init
	  skip
   end

   meth almacenarArchivo(Contenido RutaArchivo)
      ArchivoAAlmacenar = {New Archivo.archivo init(RutaArchivo Contenido 'txt')}
   in
     {ArchivoAAlmacenar almacenar}
   end

   meth cargarArchivo(RutaArchivo ?ArchivoCargado)
      File Contenido in
      try
          File = {New Open.file init(name:RutaArchivo)}
          Contenido = {File read(list:$ size:all)}
          {File close}
          ArchivoCargado = {New Archivo.archivo init(RutaArchivo Contenido 'txt')}
      catch X then raise X end end
          
    end
      
   end
end