functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   IDEA
   ClaveCodificacionIDEA
   ClaveDecodificacionIDEA
   OperacionesMatematicas
export
   codificadorIDEA:ICodificadorIDEA
   generacionClave: ServicioRequGeneradorClave
   opMatematicas: ServicioRequOpMatematicas
define
	PuertoClaves PuertoOpMatematicas
    proc {ICodificadorIDEA PuertoOperacionesMatematicas PuertoGeneradorClaves Flujo PuertoCodificador}
      PuertoClaves = PuertoGeneradorClaves
      PuertoOpMatematicas = PuertoOperacionesMatematicas
      {Componente.nuevoPuertoReq
       proc{$Mensaje} CodificadorIDEA = {New IDEA.codificador init({New OperacionesMatematicas.opMatService init})} Clave Codificacion Decodificacion Subclaves
       in
	  case Mensaje of codificar(TextoACodificar IdeaKey ?TextoCodificado) then
	     try
	     	Clave = {New ClaveCodificacionIDEA.claveCodificacionIDEA init(IdeaKey)}
	     	Subclaves = {Clave subclaves($)}
	     	Codificacion = {CodificadorIDEA codificar(TextoACodificar Subclaves $)}
			TextoCodificado = {Codificacion texto($)}
		 catch X then  {Browser.browse 'Excepción al Codificar con IDEA' #X# ' No se logró realizar la codificación.' }
	     end

	  [] decodificar(TextoADecodificar IdeaKey ?TextoDecodificado) then
	     try
			Clave = {New ClaveDecodificacionIDEA.claveDecodificacionIDEA init(IdeaKey)}
			Decodificacion = {CodificadorIDEA decodificar(TextoADecodificar Clave $)}
			TextoDecodificado = {Decodificacion texto($)}
		 catch X then  {Browser.browse 'Excepción al Decodificar con IDEA ' #X# ' No se logró realizar la decodificación.' }
	     end
	  
	  [] _ then {Browser.browse "No encontró la operación"}
	    
	  end
       end Flujo PuertoCodificador}
    end
   
	proc {ServicioRequGeneradorClave Msg}
	   {Componente.proveerServ PuertoClaves Msg}
	end
	
	proc {ServicioRequOpMatematicas Msg}
	   {Componente.proveerServ PuertoOpMatematicas Msg}
	end
end