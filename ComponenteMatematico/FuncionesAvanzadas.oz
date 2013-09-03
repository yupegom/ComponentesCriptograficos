functor
import
   %Browser
   GestorNumeros at 'file:../../GestorNumeros/GestorNumeros.ozf'
export
   matematicaAvanzada:FuncionesAvanzadas
define
   class FuncionesAvanzadas
       
      meth init
	 skip
      end

     %  meth getInstance(?Instance)
% 	 lock L then
% 	    if{Not{IsDet Instance}} then
% 	       Instance = {New FuncionesAvanzadas init}
	    
% 	    end
% 	 end
%       end
      
      meth calcularFuncionDeEuclides(Valor1 Valor2 ?Mcd)
	
	 Residuo = {NewCell 0} in
	 Residuo := {Int.'mod' Valor1 Valor2}

	 if @Residuo  == 0 then Mcd = Valor2
    	 
	 else
	    {self calcularFuncionDeEuclides(Valor2 @Residuo Mcd)}
	 end
	
      end

      meth realizarTestDeFermat(Valor ?EsProbablePrimo)

	 RangoInferior = 1 RangoSuperior = Valor - 1
	 Aleatorio={NewCell 0} K = 40 MCD = {NewCell 0} Res = {NewCell 0}
	 EsPrimo = {NewCell true}
	 PuertoGenNumero = {GestorNumeros.gestorNumero _ $}
      in
 	 for I in 1..K break:B do
	   
	    Aleatorio := {Send PuertoGenNumero generarAleatorioDentroDeRangoEspecifico(RangoInferior RangoSuperior $)}
	    MCD := {self calcularFuncionDeEuclides(@Aleatorio Valor $)}

	    if @MCD \= 1 then
	       EsPrimo := false
	       {B}
	    end

	    Res := {self calcularPotenciaModulo(@Aleatorio Valor $)}
	    if @Res \= 1 then
	       EsPrimo := false
	       {B}
	    end
	    
	    %{Browser.browse @Aleatorio}
	 end
	 EsProbablePrimo = @EsPrimo
	 
	
      end

      meth sumaModulo(Sumando1 Sumando2 ?Resultado)
	 ?Resultado = Sumando1 + Sumando2
      end

      meth productoModulo(Factor1 Factor2 ?Res)
	 Resultado={NewCell 0} in
	
	 Resultado := Factor1 * Factor2
	 if @Resultado > 65537 then
	    Res = {Int.'mod' @Resultado 65537}
	 else Res = @Resultado	    
	 end
      end

      meth calcularInversaModular(Valor1 Valor2 ?InversaModular)
	 Inversa  in
	 {Euclide Valor1 Valor2 Inversa _}
	 if {Int.isNat Inversa} then
	    InversaModular = Inversa
	 else
	    InversaModular = Inversa + Valor2
	 end
	 
      end
      
      meth calcularPotenciaModulo(A N ?Resultado)
	 Resultado = {ModExp A N}
      end

      meth verificarCoprimalidad(Valor1 Valor2 ?EsPrimoRelativo)
	 Mcd in
	 Mcd = {self calcularFuncionDeEuclides(Valor1 Valor2 $)}
	 if Mcd == 1 then
	    EsPrimoRelativo = true
	 else
	    EsPrimoRelativo = false
	 end
	 
      end

       meth generarNumeroPrimo(Tamano ?Primo)
  
	 EsPrimo = {NewCell true}
	  Aleatorio={NewCell ""} AleatorioAGenerar = {NewCell ""}
	  PuertoGenNumero = {GestorNumeros.gestorNumero _ $}
	 
      in
	 
	 Aleatorio := {Send PuertoGenNumero generarNumero(Tamano AleatorioAGenerar $)}
	 EsPrimo := {self realizarTestDeFermat({StringToInt @Aleatorio} $)}

	 if @EsPrimo == true then
 	    Primo = {StringToInt @Aleatorio}
	 else
 	    Primo = {self generarNumeroPrimo(Tamano $)}
 	 end
	 	  
      end
             
   end


   fun {ModExp B M} % exponenciación módulo
      A={NewCell 1} CB={NewCell B} E = M - 1
      proc {Loop E}
	 if E>0 then
	    if (E mod 2)==1 then A:=(@A * @CB) mod M end
	    CB:=(@CB * @CB) mod M
	    {Loop (E div 2)}
	 end
      end
   in {Loop E} @A end
   
   proc {Euclide A B ?X ?Y} % Algoritmo extendido de euclides
      if B==0 then X=1 Y=0 else
	 local X1 Y1 {Euclide B (A mod B) X1 Y1}
	 in X=Y1 Y=X1-Y1*(A div B) end
      end
   end

end

	 






   
%    proc {GenAleatorio ?Al}
%       PuertoGenNumero
%       Flujo
%       RangoInferior = 1
%       RangoSuperior = 10
	 
%    in

%       thread
% 	 {GestorNumeros.gestorNumero Flujo PuertoGenNumero}
%       end

  
%       {Send PuertoGenNumero  generarAleatorioDentroDeRangoEspecifico(RangoInferior RangoSuperior Al)}
%       {Browser.browse 'Al' Al}
   
%    end


% La suma en módulo 2^16 implica que el resultado de la suma no puede ser mayor a 2^16 (65536). Esta restricción no será tenida en cuenta ya que los resultados que obtendremos no serán mayores a dicho valor, es decir usaremos enteros de 16 bits y realizaremos sumas normales