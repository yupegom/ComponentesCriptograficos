functor
import
   ClaveIDEA
   CodificadorIDEA
export
   claveCodificacionIDEA:ClaveCodificacionIDEA
define
   class ClaveCodificacionIDEA from ClaveIDEA.claveIDEA

      meth subclaves(?Subclaves)
         if(@subclaves == nil) then
            subclaves := {CodificadorIDEA.generacionClave generarSubclavesParaCodificacion({StringToInt @clave} $)}
         end
         Subclaves = @subclaves
      end

   end
end