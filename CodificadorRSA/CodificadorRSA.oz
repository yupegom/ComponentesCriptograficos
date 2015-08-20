functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   RSA
   ClavePrivadaRSA
   ClavePublicaRSA
export
   codificadorRSA: ICodificadorRSA
   opMatematicas: ServicioRequOpMatematicas
define
	PuertoOpMatematicas
    proc {ICodificadorRSA PuertoOperacionesMatematicas Flujo PuertoCodificador}
    	PuertoOpMatematicas = PuertoOperacionesMatematicas
    	{Componente.nuevoPuertoReq
    	proc{$Mensaje} CodificadorRSA = {New RSA.codificador init(PuertoOpMatematicas)} Clave in
		   	case Mensaje of codificar(TextoACodificar N E TamanoBloque ?TextoCodificado) then
		   		try
					Clave = {New ClavePublicaRSA.clavePublicaRSA init(E N)}
					TextoCodificado = {{CodificadorRSA codificar(TextoACodificar Clave TamanoBloque $)} texto($)}
			 	catch X then  {Browser.browse 'Excepción al Codificar ' #X# ' No se logró realizar la codificación.' }
		    	end

			[] decodificar(TextoADecodificar N D TamanoBloque ?TextoDecodificado) then
		    	try
					Clave = {New ClavePrivadaRSA.clavePrivadaRSA init(D N)}
					TextoDecodificado = {{CodificadorRSA decodificar(TextoADecodificar Clave TamanoBloque $)} texto($)}
			 	catch X then  {Browser.browse 'Excepción al Decodificar ' #X# ' No se logró realizar la decodificación.' }
		    	end
		  
			[] _ then {Browser.browse "No encontró la operación"}
		    
		end
	       end Flujo PuertoCodificador}
    end
   
	proc {ServicioRequOpMatematicas Msg}
		   {Componente.proveerServ PuertoOpMatematicas Msg}
	end
end