functor
import
   Open
   Browser
export
  gestorArchivo:AlmacenarArchivo
define
   class AlmacenarArchivo

      meth init
	 skip
      end
      
      meth almacenarArchivo(Contenido RutaArchivo)
	 try
	    File={New Open.file init(name:RutaArchivo flags:[write create truncate])} in
	    {File write(vs:Contenido)}
	    
	    {File close}
	 catch X then {Browser.browse 'Excepción: ' #X# ' No se pudo almacenar el archivo deseado.' } end
      end
      
   end
end