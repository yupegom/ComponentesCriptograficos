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


      meth generarAleatorioDentroDeRango(RangoInf RangoSuperior ?Aleatorio)
         PuertoGeneradorNumeros = {GestorNumeros.gestorNumero _ $}
         in
         Aleatorio = {Send PuertoGeneradorNumeros generarAleatorioDentroDeRangoEspecifico(RangoInf RangoSuperior $)}
      end
   end
end
