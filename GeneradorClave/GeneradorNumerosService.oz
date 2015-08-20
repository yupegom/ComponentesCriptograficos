functor
import
   GeneradorClave 
export servicioGeneradorNumeros:GeneradorNumerosService
define 	 
   class GeneradorNumerosService

      meth init
	 skip
      end

      meth generarNumeroPrimo(Tamano ?ProbablePrimo)
   	 ProbablePrimo = {GeneradorClave.generadorNumeros generarNumeroPrimo(Tamano $)}
      
      end


      meth generarAleatorioDentroDeRango(RangoInf RangoSuperior ?Aleatorio)
         Aleatorio = {GeneradorClave.generadorNumeros generarAleatorioDentroDeRangoEspecifico(RangoInf RangoSuperior $)}
      end
   end
end
