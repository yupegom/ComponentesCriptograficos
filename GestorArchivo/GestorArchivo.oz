functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   CargarArchivo
   AlmacenarArchivo
   %Browser
export
   cargarArchivo:ICargarArchivo
   almacenarArchivo:IAlmacenarArchivo
define 
   
   proc {ICargarArchivo Flujo PuertoCarga}
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  Servicio = {New  CargarArchivo.gestorArchivo init} ArchivoCargado in
	  case Mensaje of cargarArchivo(RutaArchivo ?Contenido) then
	     %try
		ArchivoCargado = {Servicio cargarArchivo(RutaArchivo $)}
%	      {Browser.browse {ArchivoCargado nombreArchivo($)}}
		Contenido = {ArchivoCargado contenido($)}
	     %catch X then  {Browser.browse 'Excepción al Cargar ' #X# ' No se pudo abrir el archivo deseado.' }
	     %end
	  [] _ then skip
	    
	  end
       end Flujo PuertoCarga}
   end

   proc {IAlmacenarArchivo Flujo PuertoAlmacenamiento}
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  ServicioAlmacenamiento = {New AlmacenarArchivo.gestorArchivo init} in
	  %try
	     {ServicioAlmacenamiento Mensaje}
	  %catch X then  {Browser.browse 'Excepción al almacenar ' #X# ' No se pudo abrir el archivo deseado.' }
	  %end
       end Flujo PuertoAlmacenamiento}
   end
end

      
		     