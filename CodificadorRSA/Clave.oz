functor
export
   clave:Clave
define
   class Clave
      attr tipoClave 
      meth init
	 skip
      end

      meth getTipoClave(?TipoClave)
	 TipoClave=@tipoClave
      end

      meth setTipoClave(TipoClave)
	 tipoClave := TipoClave
      end

   end
end