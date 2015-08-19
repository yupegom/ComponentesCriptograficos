functor
import
   Clave
export
   claveIDEA:ClaveIDEA
define
   class ClaveIDEA from Clave.clave
      attr clave subclaves: nil

      meth init(Clave)
        clave := Clave
      end

      meth getClave(?Clave)
        Clave = @clave
      end
   end
end