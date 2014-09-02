functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   ServicioGeneradorClaves
export
   generadorClave:IGeneradorClave
define
   proc {IGeneradorClave PuertoAlmacenamiento Flujo PuertoGenerador}
      {Componente.nuevoPuertoReq
       proc{$Mensaje} GeneradorClave = {New ServicioGeneradorClaves.servicioGeneradorClaves init} ClavePrivadaRSA ClavePublicaRSA Clave ClaveIDEA in
	  case Mensaje of generarLlave(TipoClaveAGenerar) then
	     try
	     	Clave = {GeneradorClave generarClave(TipoClaveAGenerar $)}
			if TipoClaveAGenerar =='RSA' then 
				
				ClavePrivadaRSA = {Clave getClavePrivada($)}
				ClavePublicaRSA = {Clave getClavePublica($)}
				{AlmacenarArchivo PuertoAlmacenamiento almacenarArchivo( {ClavePrivadaRSA getN($)}#'\n'#{ClavePrivadaRSA getD($)} '../../GeneradorClave/ClavePrivadaRSA.rsak')}
				{AlmacenarArchivo PuertoAlmacenamiento almacenarArchivo( {ClavePublicaRSA getN($)}#'\n'#{ClavePublicaRSA getE($)} '../../GeneradorClave/ClavePublicaRSA.rsak')}
			else 
				ClaveIDEA = {Clave getClave($)}
				{AlmacenarArchivo PuertoAlmacenamiento almacenarArchivo( ClaveIDEA '../../GeneradorClave/ClaveIDEA.ideak')}
				
			end
		
	     catch X then  {Browser.browse 'Excepción al Generar ' #X# ' No se pudo crear la clave solicitada.' }
	     end
	  [] generarSubclavesParaCodificacion(Clave ?Subclave) then
	  	try
	  		Subclave = {GeneradorClave generarSubclavesParaCodificacion(Clave $)}
	  	catch X then {Browser.browse 'Excepción al Generar las subclaves para IDEA' #X# ' No se pudo crear la clave solicitada.' }
	  	end

	  [] generarSubclavesParaDecodificacion(Clave ?Subclave) then
	  	try
	  		Subclave = {GeneradorClave generarSubclavesParaDecodificacion(Clave $)}
	  	catch X then {Browser.browse 'Excepción al Generar las subclaves para IDEA' #X# ' No se pudo crear la clave solicitada.' }
	  	end
	  [] _ then {Browser.browse 'Mensaje no implementado'}
	    
	  end
       end Flujo PuertoGenerador}
   end
   proc {AlmacenarArchivo Puerto Msg}
      {Componente.proveerServ Puerto Msg}
   end
end
