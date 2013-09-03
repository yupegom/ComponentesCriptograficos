%declare [MatBasica]={Module.link ['/home/seven4n/Dropbox/Proyecto/FuncionesBasicas.ozf']}

declare[MatBasica]={Module.link ['C:/Users/Fernando/Documents/My Dropbox/Proyecto/FuncionesBasicas.ozf']}

Servicio = {New MatBasica.matematicaBasica init}
%SonPrimos = {NewCell false}
SonPrimos := {Servicio verificarPrimalidadRelativa(3 2 $)}
{Browse @SonPrimos}