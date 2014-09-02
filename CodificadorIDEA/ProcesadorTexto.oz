functor
import
%Browser
export
   procesadorTexto:ProcesadorTexto
define
   class ProcesadorTexto
	 
      meth init
	     skip
      end

      %Cada bloque codificado debe tener el mismo tamaño
      meth addLeadingZeros( Bloque TamanoBloque ?BloqueWithLeadingZeros )
         BloqueWithLeadingZeros = {AddLeadingZeros Bloque TamanoBloque}
      end

      %Quitamos ceros a la derecha del valor en bits para poder convertirlo a entero
      meth deleteZeros( Bloque ?BloqueNoRightZeros )
         BloqueNoRightZeros = { List.dropWhile Bloque IsZero }
      end

      meth addZerosToCompleteBloqueSize( Bloque TamanoBloque ?BloqueRightSize)
         BloqueRightSize = {AddRightZeros Bloque TamanoBloque}
      end
      
   end

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

   %Antes de codificar se agregan ceros a la derecha a cada bloque para que todos queden del mismo tamaño
   fun {AddRightZeros Bloque TamanoBloque}
      if {List.length Bloque} < TamanoBloque then
         {AddRightZeros {Append Bloque "0"} TamanoBloque}
      else
         Bloque
      end
      
   end

end

