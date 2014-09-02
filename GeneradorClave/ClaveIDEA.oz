functor
import
   Clave
export
   claveIDEA:ClaveIDEA
define
   class ClaveIDEA from Clave.clave
      attr subclaves
      meth init(Subclaves)
	     subclaves := Subclaves
	   end

      meth getSubclaves(?Subclaves)
	     Subclaves = @subclaves
      end

   end
end