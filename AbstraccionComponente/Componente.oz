functor
import
   Browser
export
   nuevoPuertoReq:NuevoPuertoReq
   proveerServ:ProveerServ
define
   proc {NuevoPuertoReq Proc Fin ?Rin}
      try
	 thread for Msg in Fin do {Proc Msg} end end
	 {NewPort Fin Rin}
      catch X then
	 {Browser.browse 'Excepción ' #X# ' .No se pudo crear el puerto de requerimiento de servicio'}
      end
   end
      

   proc{ProveerServ Puerto Dato}
      try
	 {Send Puerto Dato}
      catch X then
	 {Browser.browse 'Excepción ' #X# ' .No se pudo activar ensamble para envío de dato a: '#Puerto}
      end
   end
end

   
        