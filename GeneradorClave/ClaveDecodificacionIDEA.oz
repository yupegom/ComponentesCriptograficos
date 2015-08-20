functor
import
   ClaveIDEA
   ServicioGeneradorClaves
export
   claveDecodificacionIDEA:ClaveDecodificacionIDEA
define
   class ClaveDecodificacionIDEA from ClaveIDEA.claveIDEA

      meth subclaves(?Subclaves)
        GeneradorClave = {New ServicioGeneradorClaves.servicioGeneradorClaves init} in
         if(@subclaves == nil) then
            subclaves := {GeneradorClave generarSubclavesParaDecodificacion(@clave $)}
         end
         Subclaves = @subclaves
      end
      
   end
end