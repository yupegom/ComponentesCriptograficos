functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   GeneradorClave at 'file:../../GeneradorClave/GeneradorClave.ozf'
export
   generarLlaves:IGenerarLlaves
define  R2
   proc {IGenerarLlaves Flujo3 PuertoGeneracionLlaves}

      {Componente.nuevoPuertoReq
       proc{$Msg}
	  try
	     {GeneradorClave.generadorClave Flujo3 R2}
	     {Send R2 Msg}
	  catch X then {Browser.browse 'Se presentó la excepción ' #X# ' No se pueden generar las llaves.' } end

       end Flujo3 PuertoGeneracionLlaves}
   end
   
end

      
   