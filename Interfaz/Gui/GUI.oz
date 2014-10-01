functor
import
   QTk at 'x-oz://system/wp/QTk.ozf'
   GeneradorClave at 'file:../../GeneradorClave/GeneradorClave.ozf'
   GestorArchivos at 'file:../../GestorArchivo/GestorArchivo.ozf'
   CodificadorRSA at 'file:../../CodificadorRSA/CodificadorRSA.ozf'
   CodificadorIDEA at 'file:../../CodificadorIDEA/CodificadorIDEA.ozf'
   ComponenteMatematico at 'file:../../ComponenteMatematico/ComponenteMatematico.ozf'
   GestorNumeros at 'file:../../GestorNumeros/GestorNumeros.ozf'
   Application(exit)
   %Browser

define

%Flujos y puertos para el alambrado de componentes
   FlujoGeneradorClaves PuertoGeneradorClaves Flujo PuertoOperacionesArchivo PuertoCodificacionRSA PuertoCodificacionIDEA FlujoCodificacion FlujoCodificacionIDEA FlujoOpMatematicas PuertoOpMatematicas
   FlujoNumeros PuertoGeneradorNumeros

   proc {AlambrarComponentes} 
      thread {GestorArchivos.operacionesArchivo Flujo PuertoOperacionesArchivo} end
      thread {ComponenteMatematico.interfazMatematicaAvanzada PuertoGeneradorNumeros FlujoOpMatematicas PuertoOpMatematicas} end
      thread {GestorNumeros.gestorNumero PuertoOpMatematicas FlujoNumeros PuertoGeneradorNumeros} end
      thread {GeneradorClave.generadorClave PuertoOpMatematicas PuertoGeneradorNumeros PuertoOperacionesArchivo FlujoGeneradorClaves PuertoGeneradorClaves} end
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
         {Archivo contenido($)}
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
   TextHandle Handle in

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
	     {TextHandle set( {Archivo contenido($)} )}
      end
   end

   proc{GenerarLlaves}
      GenerarClaveRSA TipoLlaveAGenerar in
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then TipoLlaveAGenerar= 'RSA' else TipoLlaveAGenerar = 'IDEA' end
         {InterfaceController generarLlave(TipoLlaveAGenerar)}
      {TextHandle set("Clave Generada correctamente!")}
   end

   fun {IsEnter A}
      A \= 10
   end

   proc{CodificarTexto}
      GenerarClaveRSA TipoCodificacionAGenerar ResultadoCodificacion TextoACodificar
      RutaClave
      in
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then 
         RutaClave = {RutaArchivoACargar ".rsak" "Archivo de clave" "rsak"}
         TipoCodificacionAGenerar = 'RSA'
      else 
         TipoCodificacionAGenerar = 'IDEA'
         RutaClave = {RutaArchivoACargar ".ideak" "Clave IDEA para codificar" "ideak"}
         
      end
      if RutaClave \= nil then
         TextoACodificar = {TextHandle get($)}
         ResultadoCodificacion = {InterfaceController codificar(TipoCodificacionAGenerar RutaClave TextoACodificar $)}
         {TextHandle set(ResultadoCodificacion)}  
      end
   end

   proc{DecodificarTexto}
      GenerarClaveRSA TipoDecodificacionAGenerar ResultadoDecodificacion TextoADecodificar
      RutaClave
      in
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then 
         RutaClave =  {RutaArchivoACargar ".rsak" "Archivo de clave" "rsak"} 
         TipoDecodificacionAGenerar= 'RSA'
      else
         TipoDecodificacionAGenerar = 'IDEA'
         RutaClave = {RutaArchivoACargar ".ideak" "Clave IDEA para codificar" "ideak"}
      end
      if RutaClave \= nil then
         TextoADecodificar = {TextHandle get($)}
         ResultadoDecodificacion = {InterfaceController decodificar(TipoDecodificacionAGenerar RutaClave TextoADecodificar $)}
         {TextHandle set(ResultadoDecodificacion)}  
      end
   end

   proc{RutaArchivoACargar Tipo Desc DefaultExtension ?RutaArchivo} 
      
      RutaArchivo={QTk.dialogbox load(defaultextension:DefaultExtension 
                  initialdir:"." 
                  title:"Cargar Archivo ..." 
                  initialfile:"" 
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
	      tbbutton(text:"Codificar" glue:w action:CodificarTexto)
         tbbutton(text:"Decodificar" glue:w action:DecodificarTexto)
	      tbbutton(text:"Cerrar" glue:w action:CerrarAplicacion))

   TipoLlaves=td(radiobutton(text:'RSA' 
			     init:true 
			     group:radio1 handle:Handle )
		 radiobutton(text:"IDEA"
			     group:radio1) )
 
   
 
   Window={QTk.build td(Toolbar
			text(glue:nswe handle:TextHandle bg:white tdscrollbar:true)
			lr( 
			    tbbutton(text:"Generar Claves"
				     glue:w  action:GenerarLlaves	)
			    TipoLlaves)
		       )}
   
   %{AlambrarComponentes}                  
   {Window show}
   end
end

