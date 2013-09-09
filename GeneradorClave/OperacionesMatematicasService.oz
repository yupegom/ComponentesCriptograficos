functor
import
   %GestorNumeros at 'file:../../GestorNumeros/GestorNumeros.ozf'
   ComponenteMatematico at 'file:../../ComponenteMatematico/ComponenteMatematico.ozf'
export servicioOperacionesMatematicas:OperacionesMatematicasService
define 	 
   class OperacionesMatematicasService

       meth init
	 skip
      end

      meth verificarCoprimalidad(P Q ?PrimosRelativos)

	 PuertoOpMatematicas = {ComponenteMatematico.interfazMatematicaAvanzada _ $} in
	 PrimosRelativos = {Send PuertoOpMatematicas verificarCoprimalidad(@P @Q $)}
      end
   end
end