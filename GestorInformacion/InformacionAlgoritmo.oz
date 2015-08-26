functor
export
   informacion:InformacionAlgoritmo
define
   class InformacionAlgoritmo
      attr nombreAlgoritmo informacionAlgoritmo

      meth init(Informacion)
         informacionAlgoritmo := Informacion
      end

      meth contenido(?Contenido)
         Contenido = @informacionAlgoritmo
      end
      
   end
end