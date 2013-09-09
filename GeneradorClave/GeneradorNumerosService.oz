functor
import
   GestorNumeros at 'file:../../GestorNumeros/GestorNumeros.ozf'
export servicioGeneradorNumeros:GeneradorNumerosService
define 	 
   class GeneradorNumerosService

      meth init
	 skip
      end

      meth generarNumeroPrimo(Tamano ?ProbablePrimo)
	 PuertoGeneradorNumeros = {GestorNumeros.gestorNumero _ $}
      in
	 ProbablePrimo = {Send PuertoGeneradorNumeros generarNumeroPrimo(Tamano $)}
      end
   end
end
