functor
import
   QTk at 'x-oz://system/wp/QTk.ozf'
   GeneradorClave at 'file:../../GeneradorClave/GeneradorClave.ozf'
   GestorArchivos at 'file:../../GestorArchivo/GestorArchivo.ozf'
   CodificadorRSA at 'file:../../CodificadorRSA/CodificadorRSA.ozf'
   CodificadorIDEA at 'file:../../CodificadorIDEA/CodificadorIDEA.ozf'
   ComponenteMatematico at 'file:../../ComponenteMatematico/ComponenteMatematico.ozf'
   Application(exit)
   %Browser
   
define

%Flujos y puertos para el alambrado de componentes
   FlujoGeneradorClaves PuertoGeneradorClaves Flujo PuertoOperacionesArchivo PuertoCodificacionRSA PuertoCodificacionIDEA FlujoCodificacion FlujoCodificacionIDEA FlujoOpMatematicas PuertoOpMatematicas

   proc {AlambrarComponentes} 
      thread {GestorArchivos.operacionesArchivo Flujo PuertoOperacionesArchivo} end
      thread {ComponenteMatematico.interfazMatematicaAvanzada FlujoOpMatematicas PuertoOpMatematicas} end
      thread {GeneradorClave.generadorClave PuertoOpMatematicas PuertoOperacionesArchivo FlujoGeneradorClaves PuertoGeneradorClaves} end
      thread {CodificadorRSA.codificadorRSA PuertoOpMatematicas FlujoCodificacion PuertoCodificacionRSA} end
      thread {CodificadorIDEA.codificadorIDEA PuertoOpMatematicas PuertoGeneradorClaves FlujoCodificacionIDEA PuertoCodificacionIDEA} end
      
   end

   class GUI

      meth init
         {AlambrarComponentes}
      end

      meth almacenarArchivo(Contenido Ruta)
         {Send PuertoOperacionesArchivo almacenarArchivo(Contenido Ruta)}
      end

      meth generarLlave(TipoLlaveAGenerar)
         {Send PuertoGeneradorClaves generarLlave(TipoLlaveAGenerar)}
      end

      meth cargarArchivo(RutaArchivo ?Contenido)
         Archivo in
         Archivo = {Send PuertoOperacionesArchivo cargarArchivo(RutaArchivo $) } 
         Contenido = {Archivo contenido($)}
      end

      meth codificar(TipoCodificacion RutaClave TextoACodificar ?TextoCodificado)
         Clave E N Zs in
         Clave = {self cargarArchivo(RutaClave $) }
         if TipoCodificacion == 'RSA' then
            {List.takeDropWhile Clave IsEnter N Zs}
            {List.subtract Zs 10 E}
            {Send PuertoCodificacionRSA codificar(TextoACodificar {String.toInt N} {String.toInt E} ({List.length N}-1) TextoCodificado)}
         else
            {Send PuertoCodificacionIDEA codificar(TextoACodificar Clave ?TextoCodificado)}
         end
      end

      meth decodificar(TipoDecodificacion RutaClave TextoADecodificar ?TextoDecodificado)
         Clave N D Zs in
         Clave = {self cargarArchivo(RutaClave $) }
         if TipoDecodificacion == 'RSA' then
            {List.takeDropWhile Clave IsEnter N Zs}
            {List.subtract Zs 10 D}
            {Send PuertoCodificacionRSA decodificar(TextoADecodificar {String.toInt N} {String.toInt D} ({List.length N}) TextoDecodificado)}
         else
            {Send PuertoCodificacionIDEA decodificar(TextoADecodificar Clave TextoDecodificado)}
         end
      end
   end


   local InterfaceController = {New GUI init} 
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

   fun {IsEnter A}
      A \= 10
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
