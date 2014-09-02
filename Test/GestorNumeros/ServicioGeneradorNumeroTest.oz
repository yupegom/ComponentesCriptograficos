declare[GenNumeros]={Module.link ['../../GestorNumeros/ServicioGeneradorNumero.ozf']}

Servicio = {New GenNumeros.generadorNumero init}

proc{GenerarPrimoTest}
   Primo = {NewCell 0} in
   for I in 1..100 do
      Primo := {Servicio generarNumeroPrimo(100 $)}
      {Browse @Primo}
   end
   
end

{GenerarPrimoTest}