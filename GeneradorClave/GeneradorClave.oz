functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   ClaveCodificacionIDEA
   ClaveDecodificacionIDEA
   ServicioGeneradorClaves
export
   generadorClave:IGeneradorClave
   realizarOperacion: RealizarOperacion
   generadorNumeros: GenerarNumeros
define PuertoOpMatematicas PuertoGenNumeros
   proc {IGeneradorClave PuertoOperacionesMatematicas PuertoGeneradorNumeros PuertoAlmacenamiento Flujo PuertoGenerador}
   	  PuertoOpMatematicas = PuertoOperacionesMatematicas
   	  PuertoGenNumeros = PuertoGeneradorNumeros
      {Componente.nuevoPuertoReq
       proc{$Mensaje} GeneradorClave = {New ServicioGeneradorClaves.servicioGeneradorClaves init} ClavePrivadaRSA ClavePublicaRSA Clave ClaveIDEA ClaveCodIDEA ClaveDecodIDEA in
	  case Mensaje of generarLlave(TipoClaveAGenerar) then
	     try
	     	Clave = {GeneradorClave generarClave(TipoClaveAGenerar $)}
			if TipoClaveAGenerar =='RSA' then 
				
				ClavePrivadaRSA = {Clave getClavePrivada($)}
				ClavePublicaRSA = {Clave getClavePublica($)}
				{AlmacenarArchivo PuertoAlmacenamiento almacenarArchivo( {ClavePrivadaRSA getN($)}#'\n'#{ClavePrivadaRSA getD($)} '../../GeneradorClave/ClavePrivadaRSA.rsak')}
				{AlmacenarArchivo PuertoAlmacenamiento almacenarArchivo( {ClavePublicaRSA getN($)}#'\n'#{ClavePublicaRSA getE($)} '../../GeneradorClave/ClavePublicaRSA.rsak')}
			else 
				ClaveIDEA = Clave
				{AlmacenarArchivo PuertoAlmacenamiento almacenarArchivo(  {ClaveIDEA getClave($)} '../../GeneradorClave/ClaveIDEA.ideak')}
				
			end
		
	     catch X then  {Browser.browse 'Excepción al Generar ' #X# ' No se pudo crear la clave solicitada.' }
	     end
	  [] generarSubclavesParaCodificacion(Clave ?Subclaves) then
	  	try
			ClaveCodIDEA = {New ClaveCodificacionIDEA.claveCodificacionIDEA init(Clave)}
	  		Subclaves = {ClaveCodIDEA subclaves($)}
	  	catch X then {Browser.browse 'Excepción al Generar las subclaves para IDEA' #X# ' No se pudo crear la clave solicitada.' }
	  	end

	  [] generarSubclavesParaDecodificacion(Clave ?Subclaves) then
	  	try
	  		ClaveDecodIDEA = {New ClaveDecodificacionIDEA.claveDecodificacionIDEA init( Clave )}
	  		Subclaves = {ClaveDecodIDEA subclaves($)}
	  	catch X then {Browser.browse 'Excepción al Generar las subclaves para IDEA' #X# ' No se pudo crear la clave solicitada.' }
	  	end
	  [] _ then {Browser.browse 'Mensaje no implementado'}
	    
	  end
       end Flujo PuertoGenerador}
   end

   proc {AlmacenarArchivo Puerto Msg}
      {Componente.proveerServ Puerto Msg}
   end

   proc {RealizarOperacion Msg}
      {Componente.proveerServ PuertoOpMatematicas Msg}
   end

   proc {GenerarNumeros Msg}
      {Componente.proveerServ PuertoGenNumeros Msg}
   end

end
