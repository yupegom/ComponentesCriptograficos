functor

export
   clavePublicaRSA:ClavePublicaRSA
define
   class ClavePublicaRSA
      attr e n
	 
      meth init(E N)
	 e := E
	 n := N
      end

      meth getE(?E)
	 E = @e
      end

      meth getN(?N)
	 N = @n
      end

   end
end