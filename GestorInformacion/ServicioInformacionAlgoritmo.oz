functor
import
  GestorInformacion
  InformacionAlgoritmo
export
   servicioInformacionAlgoritmo:ServicioInformacionAlgoritmo
define

   class ServicioInformacionAlgoritmo

   meth init
	  skip
   end

   meth cargarInformacion(RutaArchivo ?Informacion)
      Contenido in
      {GestorInformacion.servicioArchivos cargarArchivo(RutaArchivo Contenido)}
      Informacion= {New InformacionAlgoritmo.informacion init({Contenido contenido($)})}
   end

   meth cargarAyuda(RutaArchivo ?Informacion)
      Contenido in
      {GestorInformacion.servicioArchivos cargarArchivo(RutaArchivo Contenido)}
      Informacion= {New InformacionAlgoritmo.informacion init({Contenido contenido($)})}
   end
      
   end
end