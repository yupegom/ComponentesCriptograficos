functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   ServicioGeneradorClaves
export
   generadorClave:IGeneradorClave
define Servicio = {New  ServicioGeneradorClaves.servicioGeneradorClaves init}
   proc {IGeneradorClave Flujo PuertoGenerador}
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  case Mensaje of generarLlave(TipoClaveAGenerar ?Clave) then
	     try
		if TipoClaveAGenerar == 'RSA' then
		   {Servicio generarClavesRSA(?Clave)}
		else
		   {Servicio generarClavesIDEA(?Clave)}
		end
	       
	     catch X then  {Browser.browse 'Excepción al Generar ' #X# ' No se pudo crear la clave solicitada.' }
	     end
	  
	  [] _ then skip
	    
	  end
       end Flujo PuertoGenerador}
   end
end