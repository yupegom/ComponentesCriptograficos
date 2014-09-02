functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   IDEA
   ClaveIDEA
export
   codificadorIDEA:ICodificadorIDEA
define
	PuertoClaves
    proc {ICodificadorIDEA PuertoOpMatematicas PuertoGeneradorClaves Flujo PuertoCodificador}
      {Componente.nuevoPuertoReq
       proc{$Mensaje} CodificadorIDEA = {New IDEA.codificador init(PuertoOpMatematicas ServicioExterno)} Clave Subclaves
       PuertoClaves = PuertoGeneradorClaves
       in
	  case Mensaje of codificar(TextoACodificar IdeaKey ?TextoCodificado) then
	     try
			Subclaves = {ServicioExterno generarSubclavesParaCodificacion({StringToInt IdeaKey} $)}
			Clave = {New ClaveIDEA.claveIDEA init(Subclaves)}
			TextoCodificado = {CodificadorIDEA codificar(TextoACodificar Clave $)}
		 catch X then  {Browser.browse 'Excepción al Codificar con IDEA' #X# ' No se logró realizar la codificación.' }
	     end

	  [] decodificar(TextoADecodificar IdeaKey ?TextoDecodificado) then
	     try
			Subclaves = {ServicioExterno generarSubclavesParaDecodificacion({StringToInt IdeaKey} $)}
			Clave = {New ClaveIDEA.claveIDEA init(Subclaves)}
			TextoDecodificado = {CodificadorIDEA decodificar(TextoADecodificar Clave $)}
		 catch X then  {Browser.browse 'Excepción al Decodificar con IDEA ' #X# ' No se logró realizar la decodificación.' }
	     end
	  
	  [] _ then {Browser.browse "No encontró la operación"}
	    
	  end
       end Flujo PuertoCodificador}
    end
   
	proc {ServicioExterno Msg}
	   {Componente.proveerServ PuertoClaves Msg}
	end
end