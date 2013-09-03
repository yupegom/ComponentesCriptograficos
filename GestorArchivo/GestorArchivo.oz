functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   CargarArchivo
   AlmacenarArchivo
   Browser
export
   gestorArchivo:IGestorArchivo
define 
   
   proc {IGestorArchivo Flujo PuertoGestor}
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  Servicio = {New  CargarArchivo.gestorArchivo init} ArchivoCargado ServicioAlmacenamiento = {New AlmacenarArchivo.gestorArchivo init} in
	  case Mensaje of cargarArchivo(RutaArchivo ?Contenido) then
	     try
		ArchivoCargado = {Servicio cargarArchivo(RutaArchivo $)}
%	      {Browser.browse {ArchivoCargado nombreArchivo($)}}
		Contenido = {ArchivoCargado contenido($)}
	     catch X then  {Browser.browse 'Excepción al Cargar ' #X# ' No se pudo abrir el archivo deseado.' }
	     end
	   
	  [] almacenarArchivo(Contenido RutaArchivo) then
	     try
		{ServicioAlmacenamiento almacenarArchivo(Contenido RutaArchivo)}
	     catch X then  {Browser.browse 'Excepción al almacenar ' #X# ' No se pudo abrir el archivo deseado.' }
	     end
	  [] _ then skip
	    
	  end
       end Flujo PuertoGestor}
   end
end

      
		     