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

      meth sumaModulo(Sumando1 Sumando2 ?Sum)
      
      fun{Loop Res}
      	if Res >= 65536 then
      	   
		   {Loop {Int.'mod' Res 65536}}
		else Res
		end	
      end in

	 Sum = {Loop Sumando1+Sumando2}
     end

     meth inversaAditivaModular(Sumando ?Sum)
     	Sum = 65536 - Sumando
     end

      meth productoModulo(Factor1 Factor2 ?Prod)
	 
	 fun{Loop Res}
      	if Res >= 65537 then
      	   {Loop {Int.'mod' Res 65537}}
		else Res
		end	
     end in
	 Prod = {Loop Factor1*Factor2}
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

      meth modulo(Operador1 Operador2 ?Modulo)
	 Modulo = Operador1 mod Operador2
      end

      meth potencia(Operador Potencia ?Resultado)
	 Resultado = {Pow Operador Potencia}
      end

      meth exponenciacionModular(Base Potencia Modulo ?Resultado)
	 	Resultado = {ExponenciacionModulo Base Potencia Modulo}
      end

      %Convierte un string binario a decimal
      meth toInt(Binario Length ?Int)
      	Int = {BitStringToInt Length Binario}
      end

      meth inversaMultiplicativa(Input ?Inversa)
      	%{Euclide Valor1 Valor2 Inv _}
      	%Inversa = Inv
      	Inversa = 1 div Input
      end

      meth inversaAditiva(Input ?Inversa)
      	Inversa = Input * ~1
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

   fun {ExponenciacionModulo B E M} % exponenciación módular
	   A={NewCell 1} CB={NewCell (B mod M)} 
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

   %Auxiliar para convertir un binario a decimal
	fun {BL2I Bin}
	      P = fun {$ X Y} Y + {Number.pow 2 X} end
	      in
	      {List.foldR Bin P 0}
	end

	%Convierte un string un decimal
	fun {BitStringToInt Length Bin}
	   IndexOfBin = {ToList {List.reverse Bin} 0} in
	   {BL2I {BitString.toList {BitString.make Length IndexOfBin}}}
	end

	%Auxiliar para obtener los índices en los que un string de bits tiene un valor = 1 (Ascii = 49)
	fun{ToList List Indice}
	   
	   case List of H|T then
	      if H == 49 then  Indice | {ToList T Indice+1}
	      else {ToList T Indice+1}
	      end
	   [] nil then nil
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