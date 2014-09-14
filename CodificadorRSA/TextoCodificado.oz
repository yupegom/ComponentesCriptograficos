functor
export
   textoCodificado:TextoCodificado
define
   class TextoCodificado
      attr texto

      meth init(TextoCodificado)
         texto := TextoCodificado
      end

      meth texto(?TextoCodificado)
         TextoCodificado = @texto
      end

   end
end