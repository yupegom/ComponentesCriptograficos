functor
import
   ClaveIDEA
   ServicioGeneradorClaves
export
   claveCodificacionIDEA:ClaveCodificacionIDEA
define
   class ClaveCodificacionIDEA from ClaveIDEA.claveIDEA

      meth subclaves(?Subclaves)
        GeneradorClave = {New ServicioGeneradorClaves.servicioGeneradorClaves init} in
         if(@subclaves == nil) then
            subclaves := {GeneradorClave generarSubclavesParaCodificacion(@clave $)}
         end
         Subclaves = @subclaves
      end

   end
end