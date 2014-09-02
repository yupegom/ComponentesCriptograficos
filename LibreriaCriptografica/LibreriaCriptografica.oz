functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   %GeneradorClave at 'file:../../GeneradorClave/GeneradorClave.ozf'
   ClavePublicaRSA at 'file:../../GeneradorClave/ClavePublicaRSA.ozf'
export
   generarLlaves:IGenerarLlaves
   codificar:ICodificar
define
   proc {IGenerarLlaves R2 Flujo3 PuertoGeneracionLlaves}

      {Componente.nuevoPuertoReq
       proc{$Msg}
	  
	  try
	     {LlamarServicio R2 Msg}
	  catch X then {Browser.browse 'Se presentó la excepción ' #X# ' No se pueden generar las llaves.' } end
       end Flujo3 PuertoGeneracionLlaves}
   end

   proc {ICodificar PuertoCodificacion Flujo PuertoLibCodificacion}

      {Componente.nuevoPuertoReq
       proc{$Msg} Clave in
	  case Msg of codificar(Texto E N ?TextCodificado) then
	     try
		{Browser.browse Msg}
    Clave = {New ClavePublicaRSA.clavePublicaRSA init(E N)}
		{LlamarServicio PuertoCodificacion codificar(Texto Clave ?TextCodificado)}
	     catch X then {Browser.browse 'Se presentó la excepción ' #X# ' No se pueden generar las llaves.' } end
	  
	  [] _ then skip
	  end
       end Flujo PuertoLibCodificacion}
   end

   proc {LlamarServicio Puerto Msg}
      {Componente.proveerServ Puerto Msg}
   end
   
end

      
   