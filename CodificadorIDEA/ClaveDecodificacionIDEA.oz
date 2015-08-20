functor
import
   ClaveIDEA
   CodificadorIDEA
export
   claveDecodificacionIDEA:ClaveDecodificacionIDEA
define
   class ClaveDecodificacionIDEA from ClaveIDEA.claveIDEA

      meth subclaves(?Subclaves)
         if(@subclaves == nil) then
            subclaves := {CodificadorIDEA.generacionClave generarSubclavesParaDecodificacion({StringToInt @clave} $)}
         end
         Subclaves = @subclaves
      end

   end
end