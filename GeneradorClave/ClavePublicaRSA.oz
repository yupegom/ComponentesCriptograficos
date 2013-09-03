functor

export
   clavePublicaRSA:ClavePublicaRSA
define
   class ClavePublicaRSA
      attr d n 
      meth init
	 skip
      end

      meth getD(?D)
	 D = @d
      end

      meth setD(D)
	 d := D
      end

      meth getN(?N)
	 N = @n
      end

      meth setN(N)
	 n := N
      end

   end
end