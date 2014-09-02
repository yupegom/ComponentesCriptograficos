functor
import
   Clave
export
   claveRSA:ClaveRSA
define
   class ClaveRSA from Clave.clave
      attr clavePrivada clavePublica
      meth init(ClavePrivada ClavePublica)
	 clavePrivada := ClavePrivada
	 clavePublica := ClavePublica
      end

      meth getClavePrivada(?ClavePrivada)
	 ClavePrivada = @clavePrivada
      end

      meth setClavePrivada(ClavePrivada)
	 clavePrivada := ClavePrivada
      end

      meth getClavePublica(?ClavePublica)
	 ClavePublica = @clavePublica
      end

      meth setClavePublica(ClavePublica)
	 clavePublica := ClavePublica
      end

   end
end