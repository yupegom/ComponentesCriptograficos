functor
export
   textoDecodificado:TextoDecodificado
define
   class TextoDecodificado
      attr texto

      meth init(TextoDecodificado)
         texto := TextoDecodificado
      end

      meth texto(?TextoDecodificado)
         TextoDecodificado = @texto
      end

   end
end