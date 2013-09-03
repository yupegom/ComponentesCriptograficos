declare
   class ServicioGeneradorNumero
     
      meth init
	 skip
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
  

declare Al={NewCell 0} Object={New ServicioGeneradorNumero init}
for I in 1..10 do
{Object generarAleatorioDentroDeRango(1 11 Al)}
{Browse @Al}
end

% fun{GenerarAleatorioDentroDeRango Min Max}
%    MaxRand = {OS.randLimits 0}
 	 
%  	 %Aleatorio = {NewCell 0}
% in
	 
%  	    %{Browser.browse Aleatorio}
%    {Int.'div' ({OS.rand} * (Max - Min)) MaxRand} + Min
%  	 %{Browser.browse @Aleatorio}
   
	 
% end
% declare
% Al={NewCell 0}
% for I in 1.. 20 do
% %   Al = I + I
%    Al:={GenerarAleatorioDentroDeRango 1 10}
%    {Browse @Al}
% end



	
   