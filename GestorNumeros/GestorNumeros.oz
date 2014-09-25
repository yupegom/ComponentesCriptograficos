functor
import
   Componente at 'file:../../AbstraccionComponente/Componente.ozf'
   ServicioGeneradorNumero
   Browser
export
   gestorNumero:IGestorNumero
   operacionesMatematicas: ServicioOpMatematicas
define Servicio = {New ServicioGeneradorNumero.generadorNumero init} PuertoMatematico

   proc {IGestorNumero PuertoOperacioinesMatematicas FlujoNumero PuertoGeneradorNumero}
   		PuertoMatematico = PuertoOperacioinesMatematicas
      {Componente.nuevoPuertoReq
       proc{$Mensaje}
	  case Mensaje of generarNumero(Tamano AleatorioAGenerar Aleatorio) then
	     try
	
		{Servicio generarNumeroAleatorio(Tamano AleatorioAGenerar Aleatorio)}
	     catch X then {Browser.browse 'Excepción al generar el número'#X#''}
	     end
	   [] generarAleatorioDentroDeRangoEspecifico(RangoInferior RangoSuperior Aleatorio) then
 	     try
		
 		{Servicio generarAleatorioDentroDeRango(RangoInferior RangoSuperior Aleatorio)}
 		
 	     catch X then {Browser.browse 'Excepción al generar el número Aleatorio dentro de rango'#X#''}
	     end
	     
	     [] generarNumeroPrimo(Tamano ValorPrimo) then
 	     try
		
 		{Servicio generarNumeroPrimo(Tamano ValorPrimo)}
 		
 	     catch X then {Browser.browse 'Excepción al generar el número Primo '#X#''}
 	     end
	  % [] temp(T Retorno) then
% 	     try
% 		{Servicio temp(T Retorno)}
% 	     catch _ then skip
% 	     end
	     
	  [] _ then skip
	  end
       end FlujoNumero PuertoGeneradorNumero}
   end

  	proc {ServicioOpMatematicas Msg}
       {Componente.proveerServ PuertoMatematico Msg}
 	end
end
