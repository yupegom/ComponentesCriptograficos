functor

export
   clavePublicaRSA:ClavePublicaRSA
define
   class ClavePublicaRSA
      puerto
	 
      meth init(PuertoOperacionesMatematicas)
      	puerto := PuertoOperacionesMatematicas
      end

      meth productoModulo(Multiplicando Multiplicador ?E)
         {Servicio @puerto productoModulo(Multiplicando Multiplicador)}
      end

      meth sumaModulo(?N)
         N = @n
      end

      meth xor(?N)
         N = @n
      end

   end
end