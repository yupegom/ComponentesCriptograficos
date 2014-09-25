functor
import
   GeneradorClave
export servicioOperacionesMatematicas:OperacionesMatematicasService
define 	 
   class OperacionesMatematicasService

       meth init
	 skip
      end

      meth verificarCoprimalidad(P Q ?PrimosRelativos)
	       PrimosRelativos = {GeneradorClave.realizarOperacion verificarCoprimalidad(@P @Q $)}
      end


      meth inversaMultiplicativa(Input ?Output)
        Output = {GeneradorClave.realizarOperacion calcularInversaModular(Input 65537 $)}
      end

      meth calcularInversaModular(Input Input2 ?Output)
        Output = {GeneradorClave.realizarOperacion calcularInversaModular(Input Input2 $)}
      end
   

      meth inversaAditiva(Input ?Output)
        Output = {GeneradorClave.realizarOperacion inversaAditivaModular(Input $)}
      end


   end
end