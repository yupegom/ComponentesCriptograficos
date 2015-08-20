declare

fun{CalcularInversaModular Valor1 Valor2}
   Inversa  in
   {Euclide Valor1 Valor2 Inversa _}
   if {Int.isNat Inversa} then
      Inversa
   else
      Inversa + Valor2
   end
end

proc {Euclide A B ?X ?Y} % Algoritmo extendido de euclides
   if B==0 then X=1 Y=0
   else
      local X1 Y1 {Euclide B (A mod B) X1 Y1}
      in X=Y1 Y=X1-Y1*(A div B)
      end
   end
end

proc {ProdModulo Factor1 Factor2 ?Prod}
	 
   fun{Loop Res}
      if Res >= 65537 then
	 {Loop {Int.'mod' Res 65537}}
      else Res
      end	
   end in
   Prod = {Loop Factor1*Factor2}
end

proc {SumModulo  Sumando1 Sumando2 ?Sum}
      
   fun{Loop Res}
      if Res >= 65536 then
      	   
	 {Loop {Int.'mod' Res 65536}}
      else Res
      end	
   end in

   Sum = {Loop Sumando1+Sumando2}
end

proc {InvAditiva Sumando ?Sum}
   Sum = 65536 - Sumando
end

declare A B C
A = {ProdModulo 5453435 564645345}
B = {CalcularInversaModular A 65537}
C = {ProdModulo A B}
{Browse C}

declare X Y Z
X = {SumModulo 3452326 7682329}
Y = {InvAditiva X}
Z = {SumModulo X Y}
{Browse Z}

declare L = 1947 N R
N = {CalcularInversaModular L 65537}
R = {ProdModulo 1947 20028}
{Browse 'Valor de la inversa de 1947' #N}
{Browse 'Es 20028 la inversa de 1947??' #R}
