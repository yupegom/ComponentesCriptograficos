%declare [MatAvanzada]={Module.link ['/home/seven4n/Dropbox/Proyecto/ServicioGeneradorNumero.ozf']}

%declare [MatAvanzada]={Module.link ['/home/seven4n/Dropbox/Proyecto/FuncionesAvanzadas.ozf']}

declare[MatAvanzada]={Module.link ['../../ComponenteMatematico/FuncionesAvanzadas.ozf']}
PotenciaModulo
Mcd SonPrimos

Servicio = {New MatAvanzada.matematicaAvanzada init}
% Mcd = {Servicio calcularFuncionDeEuclides(99720930713792136711893398807118793972539787163499815266954748696299302139079 96642143513025090447720156774474626259144348429505860962661123942802193326421 $)}

% SonPrimos = {Servicio verificarCoprimalidad(99720930713792136711893398807118793972539787163499815266954748696299302139079 96642143513025090447720156774474626259144348429505860962661123942802193326421 $)}
% PotenciaModulo = {Servicio calcularPotenciaModulo(15 61 $)}
% {Browse SonPrimos}
% {Browse PotenciaModulo}

 %Prueba del test de fermat%
  IsP 
 % IsP = {Servicio realizarTestDeFermat(99720930713792136711893398807118793972539787163499815266954748696299302139079 $)}
  IsP = {Servicio realizarTestDeFermat(1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890 $)}
  {Browse IsP}

% Producto = {NewCell 0}
% Producto := {Servicio productoModulo(2 2 $)}
% {Browse @Producto}

% Inversa
% {Servicio calcularInversaModular(61517 3096031588 Inversa)}
% {Browse Inversa}

proc{GenerarPrimoTest}
   Primo = {NewCell 0} in
   for I in 1..10 do
      Primo := {Servicio generarNumeroPrimo(100 $)}
      {Browse @Primo}
   end
   
end

%{GenerarPrimoTest}
