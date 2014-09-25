functor
import
   String at 'x-oz://system/String.ozf'
   OS
   %Browser
   GestorNumeros
export generadorNumero:ServicioGeneradorNumero
define
   
	class ServicioGeneradorNumero

	    meth init
			skip
	    end

	    meth generarNumeroAleatorio(TamanoClave AleatorioAGenerar ?Aleatorio)
			Num
			T = {NewCell 0}
		   
	    	in
			T := {String.length @AleatorioAGenerar}
		 
			if ( @T  == TamanoClave ) then Aleatorio = @AleatorioAGenerar
			else
			   {self generarAleatorioDentroDeRango(1111111111 10000000000 Num)}
			   AleatorioAGenerar := { Append @AleatorioAGenerar { IntToString Num } }
			   {self generarNumeroAleatorio(TamanoClave AleatorioAGenerar Aleatorio)}
			end
		end

	    meth generarAleatorioDentroDeRango(Min Max ?Aleatorio)
			 MaxRand = {OS.randLimits 0}
	    	in
		 	Aleatorio = {Int.'div' ({OS.rand} * (Max - Min)) MaxRand} + Min
	    end

	    meth generarNumeroPrimo(Tamano ?Primo)
			EsPrimo = {NewCell true} Aleatorio={NewCell ""} AleatorioAGenerar = {NewCell ""}
	    	in
			Aleatorio := {self generarNumeroAleatorio(Tamano AleatorioAGenerar $)}
		 	EsPrimo := {GestorNumeros.operacionesMatematicas realizarTestDeFermat({StringToInt @Aleatorio} $)}

			if @EsPrimo == true then
		 	   Primo = {StringToInt @Aleatorio}
			else
		 	   Primo = {self generarNumeroPrimo(Tamano $)}
		 	end
		 	  
	    end
	 end
  
end








     %  meth temp(T ?Retorno)
% 	 %{Browser.browse Retorno}
	 
% 	 {Browser.browse 'Entra'}
% 	 Retorno = {NewCell ''}
	 
% 	 Retorno:={Ret T}
%       end

     %  meth generarNumeroAleatorio(Tamano ?Aleatorio)
% 	 Temp in
% 	 %{Browser.browse 'en el método ' #{Cell.is Aleatorio}#''}
% 	 Temp = {NewCell ""}
% 	 %Aleatorio = {NewCell ""}
% 	 Aleatorio = {GenerarAleatorio Tamano Temp}
	    
	 
%       end
      

  % fun{Ret T}
%       if T==2 then
% 	 '111'
%       else
% 	 '222'
%       end
%    end
%    MaxRand = {OS.randLimits 0}
%    fun{GenerarAleatorioDentroDeRango Min Max}
      
	
%       {Int.'div' ({OS.rand} * (Max - Min)) MaxRand} + Min

%    end

   
%    NumeroAleatorio = {NewCell ""} T={NewCell 0}
%    Valor={NewCell 0}
%    fun{GenerarAleatorio TamanoNumero Aleatorio}
      
%       T:={Length @Aleatorio} 
%       %{Browser.browse {IsString @Aleatorio}}
%       if ( @T  == TamanoNumero ) then @Aleatorio
%       else

% % 	 {Browser.browse Valor}
% 	 Valor := {GenerarAleatorioDentroDeRango 1111111111 10000000000}
% 	 NumeroAleatorio := { Append @Aleatorio { IntToString @Valor } }
% 	 %NumeroAleatorio := "1111"
% 	 %{Browser.browse {String.length @Aleatorio}}
% 	 {GenerarAleatorio TamanoNumero NumeroAleatorio}
	 
%       end
%   end

	
   