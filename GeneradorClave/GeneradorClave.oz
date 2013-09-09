functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   ServicioGeneradorClaves
export
   generadorClave:IGeneradorClave
define
   proc {IGeneradorClave Flujo PuertoGenerador}
      {Componente.nuevoPuertoReq
       proc{$Mensaje} GeneradorClave = {New ServicioGeneradorClaves.servicioGeneradorClaves init} in
	  case Mensaje of generarLlave(TipoClaveAGenerar ?Clave) then
	     try
		Clave = {GeneradorClave generarClave(TipoClaveAGenerar $)}
					       
	     catch X then  {Browser.browse 'Excepción al Generar ' #X# ' No se pudo crear la clave solicitada.' }
	     end
	  
	  [] _ then skip
	    
	  end
       end Flujo PuertoGenerador}
   end
end