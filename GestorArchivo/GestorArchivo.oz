functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   ServicioOperacionesArchivo
   Browser
export
   operacionesArchivo:IGestorArchivo
define

	proc {IGestorArchivo Flujo PuertoCarga}
	   	{Componente.nuevoPuertoReq
	      proc{$Mensaje}
		  	ServicioCarga ServicioAlmacenamiento ArchivoCargado in
			case Mensaje of cargarArchivo(RutaArchivo ?Contenido) then
				ServicioCarga = {New  ServicioOperacionesArchivo.gestorArchivo init} 
			    try
					ArchivoCargado = {ServicioCarga cargarArchivo(RutaArchivo $)}
					Contenido = {ArchivoCargado contenido($)}
			    catch X then  {Browser.browse 'Excepción al Cargar ' #X# ' No se pudo abrir el archivo deseado.' }
			    end
			[] almacenarArchivo(Contenido RutaArchivo) then
				ServicioAlmacenamiento = {New ServicioOperacionesArchivo.gestorArchivo init}
				try
					{ServicioAlmacenamiento almacenarArchivo(Contenido RutaArchivo)}
				catch X then  {Browser.browse 'Excepción al almacenar ' #X# ' No se pudo almacenar el archivo deseado.' }
				end
			[] _ then skip
			    
			end
	    end Flujo PuertoCarga}
	end

end

      
		     