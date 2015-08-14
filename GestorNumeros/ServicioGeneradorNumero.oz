functor
import
   String at 'x-oz://system/String.ozf'
   OS
   GestorNumeros
export generadorNumero:ServicioGeneradorNumero
define
   
	class ServicioGeneradorNumero

	    meth init
			skip
	    end

	    meth generarNumeroAleatorio(TamanoClave AleatorioAGenerar ?Aleatorio)
			AleatorioRango
			T = {NewCell 0}
		   
	    	in
			T := {String.length @AleatorioAGenerar}
		 
			if ( @T  == TamanoClave ) then Aleatorio = @AleatorioAGenerar
			else
			   {self generarAleatorioDentroDeRango(1111111111 10000000000 AleatorioRango)}
			   AleatorioAGenerar := { Append @AleatorioAGenerar { IntToString AleatorioRango } }
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