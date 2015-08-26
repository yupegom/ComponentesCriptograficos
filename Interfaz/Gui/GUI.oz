functor
import
   QTk at 'x-oz://system/wp/QTk.ozf'
   LibreriaCriptografica at 'file:../../LibreriaCriptografica/LibreriaCriptografica.ozf'
   Application(exit)
   
define

   local InterfaceController = {New LibreriaCriptografica.interfacesDeSistema init} 
   TextHandle Handle HandleSelectionCod in

   proc{AlmacenarArchivo}
      RutaArchivo={QTk.dialogbox save($)} Contenido
   in  
      if RutaArchivo \= nil then
       Contenido={TextHandle get($)}
       {InterfaceController almacenarArchivo(Contenido RutaArchivo)}
      end
   end  
 
   proc{CargarArchivo}
      Contenido
      RutaArchivo={RutaArchivoACargar ".txt" "Archivo de texto" "txt"}
   in  
      if RutaArchivo \= nil then
         Contenido = {InterfaceController cargarArchivo(RutaArchivo $)}  
        {TextHandle set( Contenido )}
      end
   end

   proc{CargarInformacionRSA}
      Contenido
   in  
        Contenido = {InterfaceController cargarInformacionRSA($)}  
        {TextHandle set( Contenido )}
   end

   proc{CargarInformacionIDEA}
      Contenido
   in  
        Contenido = {InterfaceController cargarInformacionIDEA($)}  
        {TextHandle set( Contenido )}
   end

   proc{Ayuda}
      Contenido
   in  
        Contenido = {InterfaceController cargarAyuda($)}  
        {TextHandle set( Contenido )}
   end

   proc{GenerarLlaves}
      GenerarClaveRSA TipoLlaveAGenerar in
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then TipoLlaveAGenerar= 'RSA' else TipoLlaveAGenerar = 'IDEA' end
         {InterfaceController generarLlave(TipoLlaveAGenerar)}
      {TextHandle set("Clave Generada correctamente!")}
   end

   proc{SelCodificar}
      IsCodificarRSA in
      {HandleSelectionCod get(1:IsCodificarRSA)}
      if(IsCodificarRSA) then 
         {Codificar 'RSA' ".rsak"}
      else
         {Codificar 'IDEA' ".ideak"}
      end
   end

   proc{SelDecodificar}
      IsDecodificarRSA in
      {HandleSelectionCod get(1:IsDecodificarRSA)}
      if(IsDecodificarRSA) then 
         {Decodificar 'RSA' ".rsak"}
      else
         {Decodificar 'IDEA' ".ideak"}
      end
   end

   proc{Decodificar TipoDecodificacionAGenerar ExtClave}
      RutaClave
      in
         RutaClave =  {RutaArchivoACargar ExtClave "Archivo de clave" ExtClave}
      if RutaClave \= nil then
         ResultadoDecodificacion TextoADecodificar in
         TextoADecodificar = {TextHandle get($)}
         ResultadoDecodificacion = {InterfaceController decodificar(TipoDecodificacionAGenerar RutaClave TextoADecodificar $)}
         {TextHandle set(ResultadoDecodificacion)} 
      end 
   end

   proc{Codificar TipoCodificacionAGenerar ExtClave}
      RutaClave
      in
         RutaClave =  {RutaArchivoACargar ExtClave "Archivo de clave" ExtClave}
      if RutaClave \= nil then 
         ResultadoCodificacion TextoACodificar in
         TextoACodificar = {TextHandle get($)}
         ResultadoCodificacion = {InterfaceController codificar(TipoCodificacionAGenerar RutaClave TextoACodificar $)}
         {TextHandle set(ResultadoCodificacion)}
      end
   end

   proc{RutaArchivoACargar Tipo Desc DefaultExtension ?RutaArchivo} 
      
      RutaArchivo={QTk.dialogbox load(defaultextension:DefaultExtension 
                  initialdir:"/home/yuliban" 
                  title:"Cargar Archivo ..."  
                  filetypes:q(q(Desc q(Tipo))
                   ) $)}
   end

   proc {CerrarAplicacion}
      %toplevel#close
      {Application.exit 0}
   end

   Toolbar=lr(glue:we
         tbbutton(text:"Cargar" glue:w action:CargarArchivo)
         tbbutton(text:"Guardar" glue:w action:AlmacenarArchivo)
         tbbutton(text:"RSA Funcionamiento" glue:w action:CargarInformacionRSA)
         tbbutton(text:"IDEA Funcionamiento" glue:w action:CargarInformacionIDEA)
         tbbutton(text:"Ayuda" glue:w action:Ayuda)
         tbbutton(text:"Cerrar" glue:w action:CerrarAplicacion))

   TipoLlaves=lr(
            tbbutton(text:"Generar Claves"
                 glue:w  action:GenerarLlaves   )
            td(
              radiobutton(text:'RSA' 
              init:true 
              group:radio1 handle:Handle )
       radiobutton(text:"IDEA"
              group:radio1) ))

   OpcionesCodificacion=lr(
            td(tbbutton(text:"Codificar"
                 glue:w  action:SelCodificar   )
               tbbutton(text:"Decodificar"
                 glue:w  action:SelDecodificar   )
                 )
            td(
              radiobutton(text:'RSA' 
              init:true 
              group:radio2 handle:HandleSelectionCod )
       radiobutton(text:"IDEA"
              group:radio2) ))
 
   
 
   Window={QTk.build td(Toolbar
         text(glue:nswe handle:TextHandle bg:white tdscrollbar:true)
         lr( 
             OpcionesCodificacion
             TipoLlaves)
             )}
   
   %{AlambrarComponentes}     
               
   {Window show}
   
   end
end
