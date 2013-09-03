functor

export
   clavePrivadaRSA:ClavePrivadaRSA
define
   class ClavePrivadaRSA
      attr e n phiN
      meth init
	 skip
      end

      meth getE(?E)
	 E = @e
      end

      meth setE(E)
	 e := E
      end

      meth getN(?N)
	 N = @n
      end

      meth setN(N)
	 n := N
      end

      meth getPhiN(?PhiN)
	 PhiN = @phiN
      end

      meth setPhiN(PhiN)
	 phiN := PhiN
      end

   end
end