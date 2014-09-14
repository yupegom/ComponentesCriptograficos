functor
import
   CodificadorRSA
export
   opMatService:OperacionesMatematicas
define
   class OperacionesMatematicas
	 
      meth init
         skip
      end

      meth exponenciacionModular(Base Potencia Modulo ?Resultado)
         Resultado = {CodificadorRSA.opMatematicas exponenciacionModular(Base Potencia Modulo $)}
      end
   end
end