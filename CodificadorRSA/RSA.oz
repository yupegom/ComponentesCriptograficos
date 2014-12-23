functor  
import 
   ProcesadorTexto
   OperacionesMatematicas
   TextoCodificado
   TextoDecodificado 
export 
   codificador:RSA
define 	 
   class RSA

      attr opMatematicas procesadorTexto

      meth init(PuertoOperacionesMatematicas)
   	   opMatematicas := {New OperacionesMatematicas.opMatService init(PuertoOperacionesMatematicas)}
         procesadorTexto := {New ProcesadorTexto.procesadorTexto init}
      end

         
      meth codificar(TextoACodificar ClavePublica TamanoBloque ?TextCodificaco)
      	TextoAscii Codificacion in
         TextoAscii = {@procesadorTexto textToASCIICode(TextoACodificar $)}
         Codificacion = {self CodificarBloques(TextoAscii {ClavePublica getN($)} {ClavePublica getE($)} TamanoBloque $)}
         TextCodificaco = {New TextoCodificado.textoCodificado init( Codificacion )}
      end

      meth decodificar(TextoADecodificar ClavePrivada TamanoBloque ?ClearText)
         Decodificacion in
         Decodificacion = {self DecodificarBloques(TextoADecodificar {ClavePrivada getN($)} {ClavePrivada getD($)} TamanoBloque $)}
         ClearText = {New TextoDecodificado.textoDecodificado init( {@procesadorTexto asciiTextToClearText(Decodificacion $)} )}
      end
      
      meth CodificarBloques(TextoACodificar N E TamanoBloque ?TextoCodificado)

         fun{CodificarBloquesAux TextToEncrypt ResultadoCodificacion}

            if {List.length TextToEncrypt} > 0 then
               
               {CodificarBloquesAux {List.drop TextToEncrypt TamanoBloque} {List.append ResultadoCodificacion {self CodificarBloque( {List.take TextToEncrypt TamanoBloque} N E TamanoBloque $ ) } } }
            else
               ResultadoCodificacion 
               
            end
         end in TextoCodificado = {CodificarBloquesAux TextoACodificar ""}
      end

      meth CodificarBloque( Bloque N E TamanoBloque ?BloqueCodificadoWithLeadingZeros )
         BloqueProcessedWithRightZeros BloqueCodificado in

         BloqueProcessedWithRightZeros = {@procesadorTexto addZerosToCompleteBloqueSize(Bloque TamanoBloque $)}
         BloqueCodificado={IntToString {@opMatematicas exponenciacionModular({StringToInt { List.dropWhile BloqueProcessedWithRightZeros IsZero } } E N $)} }
         BloqueCodificadoWithLeadingZeros = {@procesadorTexto addLeadingZeros(BloqueCodificado TamanoBloque+1 $)}

      end

      meth DecodificarBloques(TextoADecodificar N D TamanoBloque ?TextoDecodificado)

         fun{DecodificarBloquesAux TextToDecrypt ResultadoDecodificacion}

            if {List.length TextToDecrypt} > 0 then
               
               {DecodificarBloquesAux {List.drop TextToDecrypt TamanoBloque} {List.append ResultadoDecodificacion {self DecodificarBloque( {List.take TextToDecrypt TamanoBloque} N D TamanoBloque $ ) } } }
            else
               ResultadoDecodificacion 
               
            end
         end in TextoDecodificado = {DecodificarBloquesAux TextoADecodificar ""}
      end

      meth DecodificarBloque( Bloque N D TamanoBloque ?BloqueDecodificadoWithLeadingZeros ) 
         BloqueDecodificado in
         BloqueDecodificado={IntToString {@opMatematicas exponenciacionModular({StringToInt { List.dropWhile Bloque IsZero } } D N $)} }
         BloqueDecodificadoWithLeadingZeros = {@procesadorTexto addLeadingZeros(BloqueDecodificado TamanoBloque-1 $)}
      end


   end
   
   fun {IsZero A}
      A == 48
   end
  
end
