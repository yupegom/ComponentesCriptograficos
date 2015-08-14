functor
export
   procesadorTexto:ProcesadorTexto
define
   class ProcesadorTexto
	 
      meth init
	     skip
      end

      meth textToASCIICode(Texto ?AsciiCode)
         AsciiCode = {TextToAscii Texto}
      end

      meth addZerosToCompleteBloqueSize( Bloque TamanoBloque ?BloqueRightSize)
         BloqueRightSize = {AddRightZeros Bloque TamanoBloque}
      end

      %Cada bloque codificado debe tener el mismo tamaño
      meth addLeadingZeros( Bloque TamanoBloque ?BloqueWithLeadingZeros )
         BloqueWithLeadingZeros = {AddLeadingZeros Bloque TamanoBloque}
      end

      meth asciiTextToClearText( AsciiText ?ClearText )
         ClearText = {AsciiToText AsciiText}
      end

   end

   %fun{TextToAscci Texto}
   %   case
   %      Texto of H|nil then {IntToString H}
   %      [] H|T then {Append {IntToString H} {TextToAscci T}}
   %   end
   %end

   fun{TextToAscii Texto}
      
      case
         Texto of H|nil then {AddLeadingZeros {IntToString H} 3}
      [] H|T then {Append {AddLeadingZeros {IntToString H} 3} {TextToAscii T}}
        
      end
   end

   %Después de decodificar el texto debe volver a su valor original. Se usa 3 como el tamaño de cada caracter
   fun{AsciiToText Value}
      
      if {And {List.length Value}>0 {List.dropWhile Value IsZero}\=nil}  then
         if {List.dropWhile {List.take Value 3} IsZero}\=nil then
            {Append [{StringToInt {List.dropWhile {List.take Value 3} IsZero}}] {AsciiToText {List.drop Value 3}}}
         else 
            {AsciiToText {List.drop Value 3}}
         end
        
      else
       nil
      end
      
   end

   %Al codificicar agregamos ceros a la izquierda para al decodificar conocer el tamaño del caracter (Siempre será de 3)
   fun {AddZeros Value}
      if {List.length Value} < 3 then
         {AddZeros {Append "0" Value}}
      else
         Value
      end
      
   end

   %Antes de codificar se agregan ceros a la derecha a cada bloque para que todos queden del mismo tamaño
   fun {AddRightZeros Bloque TamanoBloque}
      if {List.length Bloque} < TamanoBloque then
         {AddRightZeros {Append Bloque "0"} TamanoBloque}
      else
         Bloque
      end
      
   end

   %Antes de codificar se agregan ceros a la izquierda para que todos los bloques queden del mismo tamaño
   %Se usa también al decodificar, agregamos ceros a la izquierda para conocer el tamaño del caracter (Siempre será de 3)
   fun {AddLeadingZeros Bloque TamanoBloque}
      if {List.length Bloque} < TamanoBloque then
         {AddLeadingZeros {Append "0" Bloque} TamanoBloque}
      else
         Bloque
      end
      
   end

   fun {IsZero A}
      A == 48
   end

end

