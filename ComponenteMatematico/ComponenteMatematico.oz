  functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   FuncionesAvanzadas
export
   interfazMatematicaAvanzada:IMatematicaAvanzada
   interfazMatematicaBasica:IMatematicaBasica
define Servicio = {New FuncionesAvanzadas.matematicaAvanzada init}
   proc {IMatematicaBasica Flujo PuertoOpBasicas}

      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  try
	     {Servicio Mensaje}
	  catch X then {Browser.browse 'Error '#X#' No se logr� realizar la operaci�n.'} end

       end Flujo PuertoOpBasicas}
   end

   proc {IMatematicaAvanzada Flujo2 PuertoOpAvanzadas}
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  
	  try
	     {Servicio Mensaje}
	  catch X then {Browser.browse 'Error '#X#' No se logr� realizar la operaci�n.'} end
	  
	     

       end Flujo2 PuertoOpAvanzadas}
   end
end
