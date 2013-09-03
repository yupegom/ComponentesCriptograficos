declare Retorno Aleatorio={NewCell ""} F1 R1 
[GenNum]={Module.link ['../../GestorNumeros/GestorNumeros.ozf']}
{GenNum.gestorNumero F1 R1}


proc{GenerarNumeroAleatorioTest}
   Tamano = 100
   T = 3
   AleatorioAGenerar = {NewCell ""}
in
   for I in 1..50 do
	Aleatorio := {Send R1 generarNumero(Tamano AleatorioAGenerar $)}
	{Browse {StringToInt @Aleatorio}}
	AleatorioAGenerar := ""
   end
end

proc{GenerarPrimoTest}
   Primo = {NewCell 0} in
   for I in 1..10 do
      Primo := {Send R1 generarNumeroPrimo(100 $)}
      {Browse @Primo}
   end
   
end

{GenerarNumeroAleatorioTest}
%{GenerarPrimoTest}