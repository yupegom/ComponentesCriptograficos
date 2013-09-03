declare
class ServicioGeneradorNumero
     
   meth init
      skip
	 %t := H
   end

      % meth obtEst(?E)
% 	 E = @t
%       end
      
   meth generarNumeroAleatorio(TamanoClave ?Aleatorio)
      Num
      T = {NewCell ""}
   in
	 
      T := 10
   
      if ( @T  == TamanoClave ) then {Browse @Aleatorio} Aleatorio := @Aleatorio

      else
	 {self generarAleatorioDentroDeRango(1111111111 10000000000 Num)}
	 Aleatorio := { Append @Aleatorio { IntToString Num } }
	    
	 {self generarNumeroAleatorio(TamanoClave Aleatorio)}
      end
   end

   meth generarAleatorioDentroDeRango(Min Max ?Aleatorio)
      MaxRand = {OS.randLimits 0}
	 %{Browser.browse Min}
	 %Aleatorio = {NewCell 0}
   in
	 
	    %{Browser.browse Aleatorio}
      Aleatorio := {Int.'div' ({OS.rand} * (Max - Min)) MaxRand} + Min
	 %{Browser.browse @Aleatorio}
	 
   end
     
end
   

declare Al={NewCell "77"} Object={New ServicioGeneradorNumero init} Temp={NewCell 0}
X

   {Object generarNumeroAleatorio(10 Al)}
{Browse {StringToInt @Al}}
Al:="88"
 {Object generarNumeroAleatorio(10 Al)}
   {Browse {StringToInt @Al}}
%X={StringToInt @Al}
%{Browse @Al}
