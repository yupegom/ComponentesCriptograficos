functor
import
   CodificadorIDEA
export
   opMatService:OperacionesMatematicas
define
   class OperacionesMatematicas
	 
      meth init
         skip
      end

      meth productoModulo(Multiplicando Multiplicador ?Producto)
         Producto = {CodificadorIDEA.opMatematicas productoModulo(Multiplicando Multiplicador $)}
      end

      meth sumaModulo(Operador1 Operador2 ?Suma)
         Suma = {CodificadorIDEA.opMatematicas sumaModulo(Operador1 Operador2 $)}
      end

      meth xor(Operador1 Operador2 ?Resultado)
         Resultado = {CodificadorIDEA.opMatematicas xor(Operador1 Operador2 $)}
      end

      meth toInt(Binario Length ?Int)
         Int = {CodificadorIDEA.opMatematicas toInt(Binario Length $)}
      end

   end
end