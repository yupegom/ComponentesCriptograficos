functor

export
   clavePrivadaRSA:ClavePrivadaRSA
define
   class ClavePrivadaRSA
      attr d n
	 
      meth init(D N)
	 d := D
	 n := N
      end

      meth getD(?D)
	 D = @d
      end

      meth getN(?N)
	 N = @n
      end
   end
end