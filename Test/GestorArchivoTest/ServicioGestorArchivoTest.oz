functor
import
   Open
   Browser
   Archivo
export
  gestorArchivo:ServicioGestorArchivo
define
   class ServicioGestorArchivo

      meth init
	 skip
      end
      
      meth cargarArchivo(NombreArchivo ?ArchivoCargado)
	 File Content in
	 try
	    File = {New Open.file init(name:NombreArchivo)}
	    Content = {File read(list:$ size:all)}
	    ArchivoCargado = {New Archivo.archivo init(NombreArchivo)}
	    {ArchivoCargado setContenido(Content)}
	    {File close}
	 catch X then {Browser.browse 'Excepción: ' #X# ' No se pudo abrir el archivo deseado.' } end
	 	 
      end

      meth almacenarArchivo(NombreArchivo Content)
	 try
	    Archivo={New Open.file init(name:NombreArchivo flags:[write create truncate])} in
	    {Archivo write(vs:Content)}
	    
	    {Archivo close}
	 catch X then {Browser.browse 'Excepción: ' #X# ' No se pudo almacenar el archivo deseado.' } end
      end
      
   end
end

      
	 