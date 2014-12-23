functor
import
   CodificadorRSA
export
   opMatService:OperacionesMatematicas
define
   class OperacionesMatematicas
	   attr puertoOpMatematicas
      meth init(PuertoOperacionesMatematicas)
         puertoOpMatematicas := PuertoOperacionesMatematicas
      end

      meth exponenciacionModular(Base Potencia Modulo ?Resultado)
         Resultado = {Send @puertoOpMatematicas exponenciacionModular(Base Potencia Modulo $)}
      end
   end
end