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
      
   end

   fun {AddLeadingZeros Bloque TamanoBloque}
      if {List.length Bloque} < TamanoBloque then
         {AddLeadingZeros {Append "0" Bloque} TamanoBloque}
      else
         Bloque
      end
      
   end

end

