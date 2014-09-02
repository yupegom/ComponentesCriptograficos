functor  
import 
   ProcesadorTexto
   Browser
export 
   codificador:CodificadorRSA
define 	 
   class CodificadorRSA

      meth init
   	   skip
      end
         
      meth codificar(TextoACodificar ClavePublica PuertoOpMatematicas Operacion TamanoBloque ?TextoCodificado)
      	ProcesadorTextoACodificar TextoAscii in
         ProcesadorTextoACodificar = {New ProcesadorTexto.procesadorTexto init}
         TextoAscii = {ProcesadorTextoACodificar textToASCIICode(TextoACodificar $)}
         {Browser.browse TamanoBloque}
         TextoCodificado ={self codificarBloques(TextoAscii ClavePublica Operacion PuertoOpMatematicas TamanoBloque $)}
      end

      meth decodificar(TextoADecodificar ClavePrivada PuertoOpMatematicas Operacion TamanoBloque ?ClearText)
         ProcesadorTextoADecodificar TextoDecodificado in
         ProcesadorTextoADecodificar = {New ProcesadorTexto.procesadorTexto init}
         {Browser.browse TamanoBloque}
         TextoDecodificado ={self decodificarBloques(TextoADecodificar ClavePrivada Operacion PuertoOpMatematicas TamanoBloque $)}
         ClearText = {ProcesadorTextoADecodificar asciiTextToClearText( TextoDecodificado $)} 
      end
      
      meth codificarBloques(TextoACodificar ClavePublica Operacion PuertoOpMatematicas TamanoBloque ?TextoCodificado)
         E={ClavePublica getE($)} N={ClavePublica getN($)} ProcesadorTextoACodificar = {New ProcesadorTexto.procesadorTexto init} 

         fun{CodificarBloquesAux TextToEncrypt ResultadoCodificacion}

            if {List.length TextToEncrypt} > 0 then
               
               {CodificarBloquesAux {List.drop TextToEncrypt TamanoBloque} {List.append ResultadoCodificacion {self codificarBloque( {List.take TextToEncrypt TamanoBloque} N E Operacion PuertoOpMatematicas TamanoBloque ProcesadorTextoACodificar $ ) } } }
            else
               ResultadoCodificacion 
               
            end
         end in TextoCodificado = {CodificarBloquesAux TextoACodificar ""}
      end

      meth codificarBloque( Bloque N E Operacion PuertoOpMatematicas TamanoBloque ProcesadorTextoACodificar ?BloqueCodificadoWithLeadingZeros )
         BloqueProcessedWithRightZeros BloqueCodificado in

         BloqueProcessedWithRightZeros = {ProcesadorTextoACodificar addZerosToCompleteBloqueSize(Bloque TamanoBloque $)}
         BloqueCodificado={IntToString {Operacion PuertoOpMatematicas exponenciacionModular({StringToInt { List.dropWhile BloqueProcessedWithRightZeros IsZero } } E N $)} }
         BloqueCodificadoWithLeadingZeros = {ProcesadorTextoACodificar addLeadingZeros(BloqueCodificado TamanoBloque+1 $)}

      end

      meth decodificarBloques(TextoADecodificar ClavePrivada Operacion PuertoOpMatematicas TamanoBloque ?TextoDecodificado)
         D={ClavePrivada getD($)} N={ClavePrivada getN($)} ProcesadorTextoADecodificar = {New ProcesadorTexto.procesadorTexto init} 

         fun{DecodificarBloquesAux TextToDecrypt ResultadoDecodificacion}

            if {List.length TextToDecrypt} > 0 then
               
               {DecodificarBloquesAux {List.drop TextToDecrypt TamanoBloque} {List.append ResultadoDecodificacion {self decodificarBloque( {List.take TextToDecrypt TamanoBloque} N D Operacion PuertoOpMatematicas TamanoBloque ProcesadorTextoADecodificar $ ) } } }
            else
               ResultadoDecodificacion 
               
            end
         end in TextoDecodificado = {DecodificarBloquesAux TextoADecodificar ""}
      end

      meth decodificarBloque( Bloque N D Operacion PuertoOpMatematicas TamanoBloque ProcesadorTextoADecodificar ?BloqueDecodificadoWithLeadingZeros ) BloqueDecodificado in

         BloqueDecodificado={IntToString {Operacion PuertoOpMatematicas exponenciacionModular({StringToInt { List.dropWhile Bloque IsZero } } D N $)} }
         BloqueDecodificadoWithLeadingZeros = {ProcesadorTextoADecodificar addLeadingZeros(BloqueDecodificado TamanoBloque-1 $)}
      end


   end
   
   fun {IsZero A}
      A == 48
   end
  
end
