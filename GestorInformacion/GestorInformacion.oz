functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   ServicioInformacionAlgoritmo
export
   infoAlgoritmo: InformacionAlgoritmo
   servicioArchivos: CargarArchivo
define PuertoCarga
   proc {InformacionAlgoritmo PuertoCargaArchivo Flujo PuertoInformacion}
   	  PuertoCarga = PuertoCargaArchivo
      {Componente.nuevoPuertoReq
       proc{$Mensaje} ServicioInformacion = {New ServicioInformacionAlgoritmo.servicioInformacionAlgoritmo init} InformacionAlg AyudaSist in
	  case Mensaje of cargarInformacion(Algoritmo ?Informacion) then
	     try
			if Algoritmo =='RSA' then 
				{ServicioInformacion cargarInformacion("../../GestorInformacion/RSA.txt" InformacionAlg)}
				Informacion = {InformacionAlg contenido($)}
			else 
				{ServicioInformacion cargarInformacion("../../GestorInformacion/IDEA.txt" InformacionAlg)}
				Informacion = {InformacionAlg contenido($)}
			end
		
	     catch X then  {Browser.browse 'Excepción al obtener la información del algoritmo ' #X}
	     end
	  [] cargarAyuda(?Ayuda) then
	  	try
			{ServicioInformacion cargarAyuda("../../GestorInformacion/ayuda.txt" AyudaSist)}
			Ayuda = {AyudaSist contenido($)}
		
	     catch X then  {Browser.browse 'Excepción al obtener el archivo de ayuda' #X}
	     end
	  [] _ then {Browser.browse 'Mensaje no implementado'}
	    
	  end
       end Flujo PuertoInformacion}
   end

   proc {CargarArchivo Msg}	
      {Componente.proveerServ PuertoCarga Msg}
   end

end
