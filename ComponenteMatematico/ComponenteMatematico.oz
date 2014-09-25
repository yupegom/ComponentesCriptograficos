  functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   Browser
   FuncionesAvanzadas
export
   interfazMatematicaAvanzada:IMatematicaAvanzada
   interfazMatematicaBasica:IMatematicaBasica
   generacionNumeros: ServicioRequGeneracionNumeros
define Servicio = {New FuncionesAvanzadas.matematicaAvanzada init} PuertoGenNumeros
   proc {IMatematicaBasica Flujo PuertoOpBasicas}

      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  try
	     {Servicio Mensaje}
	  catch X then {Browser.browse 'Error '#X#' No se logró realizar la operación.'} end

       end Flujo PuertoOpBasicas}
   end

   proc {IMatematicaAvanzada PuertoGeneradorNumeros Flujo2 PuertoOpAvanzadas}
      PuertoGenNumeros = PuertoGeneradorNumeros
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  
	  try
	     {Servicio Mensaje}
	  catch X then {Browser.browse 'Error '#X#' No se logró realizar la operación.'} end
	  
	     

       end Flujo2 PuertoOpAvanzadas}
   end

  proc {ServicioRequGeneracionNumeros Msg}
       {Componente.proveerServ PuertoGenNumeros Msg}
  end
end
