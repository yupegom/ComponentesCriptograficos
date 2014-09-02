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
   FlujoGeneradorClaves PuertoGeneradorClaves Flujo FlujoAlmacenamiento PuertoCargaArchivo PuertoAlmacenamientoArchivo PuertoCodificacionRSA PuertoCodificacionIDEA FlujoCodificacion FlujoCodificacionIDEA FlujoOpMatematicas PuertoOpMatematicas

   proc {AlambrarComponentes} 
      thread {GestorArchivos.cargarArchivo Flujo PuertoCargaArchivo} end
      thread {GestorArchivos.almacenarArchivo FlujoAlmacenamiento PuertoAlmacenamientoArchivo} end
      thread {GeneradorClave.generadorClave PuertoAlmacenamientoArchivo FlujoGeneradorClaves PuertoGeneradorClaves} end
      thread {ComponenteMatematico.interfazMatematicaBasica FlujoOpMatematicas PuertoOpMatematicas} end
      thread {CodificadorRSA.codificadorRSA PuertoOpMatematicas FlujoCodificacion PuertoCodificacionRSA} end
      thread {CodificadorIDEA.codificadorIDEA PuertoOpMatematicas PuertoGeneradorClaves FlujoCodificacionIDEA PuertoCodificacionIDEA} end
      
   end

   proc{AlmacenarTexto}
      RutaArchivo={QTk.dialogbox save($)} Contenido
   in  
      if RutaArchivo \= nil then
	 Contenido={TextHandle get($)}
	 {Send PuertoAlmacenamientoArchivo almacenarArchivo(Contenido RutaArchivo)}
      end
   end  
 
   proc{CargarArchivo} 
      Contenido
      RutaArchivo={RutaArchivoACargar ".txt" "Archivo de texto" "txt"}
   in  
      if RutaArchivo \= nil then
	 Contenido = {Send PuertoCargaArchivo cargarArchivo(RutaArchivo $) }    
      % Ruta={String.toAtom Name}
	 {TextHandle set( Contenido )}
      %X={String.toAtom Contents}
      end
   end

   proc{GenerarLlaves}
      GenerarClaveRSA TipoLlaveAGenerar in
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then TipoLlaveAGenerar= 'RSA' else TipoLlaveAGenerar = 'IDEA' end
      {Send PuertoGeneradorClaves generarLlave(TipoLlaveAGenerar)}
      {TextHandle set("Clave Generada correctamente!")}

   %{TextHandle set('N = ')}
   end

   fun {IsEnter A}
      A \= 10
   end

   proc{CodificarTexto}
      GenerarClaveRSA TipoCodificacionAGenerar ResultadoCodificacion ClavePublica E N TextoACodificar
      RutaClavePublica RutaClaveIDEA ClaveIDEA Zs
      in
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then 
         RutaClavePublica = {RutaArchivoACargar ".rsak" "Archivo de clave" "rsak"}
         TipoCodificacionAGenerar= 'RSA' 
         if RutaClavePublica \= nil then
            ClavePublica = {Send PuertoCargaArchivo cargarArchivo(RutaClavePublica $) }
            {List.takeDropWhile ClavePublica IsEnter N Zs}
            {List.subtract Zs 10 E}
            TextoACodificar = {TextHandle get($)}
            ResultadoCodificacion = {Send PuertoCodificacionRSA codificar(TextoACodificar {String.toInt N} {String.toInt E} ({List.length N}-1) $)}
            {TextHandle set(ResultadoCodificacion)}
         end
      else 
         TipoCodificacionAGenerar = 'IDEA'
         RutaClaveIDEA = {RutaArchivoACargar ".ideak" "Clave IDEA para codificar" "ideak"}
         if RutaClaveIDEA \= nil then
            ClaveIDEA = {Send PuertoCargaArchivo cargarArchivo(RutaClaveIDEA $) }
            TextoACodificar = {TextHandle get($)}
            ResultadoCodificacion = {Send PuertoCodificacionIDEA codificar(TextoACodificar ClaveIDEA $)}
            {TextHandle set(ResultadoCodificacion)}
         end
      end
  
   end

   proc{DecodificarTexto}
      GenerarClaveRSA TipoDecodificacionAGenerar ResultadoDecodificacion ClavePrivada D N TextoADecodificar
      RutaClavePrivada RutaClaveIDEA ClaveIDEA Zs
      in
      
      {Handle get(1:GenerarClaveRSA)}
      if(GenerarClaveRSA) then 
         RutaClavePrivada =  {RutaArchivoACargar ".rsak" "Archivo de clave" "rsak"} 
         TipoDecodificacionAGenerar= 'RSA'
         if RutaClavePrivada \= nil then
            ClavePrivada = {Send PuertoCargaArchivo cargarArchivo(RutaClavePrivada $) }
            {List.takeDropWhile ClavePrivada IsEnter N Zs}
            {List.subtract Zs 10 D}
            TextoADecodificar = {TextHandle get($)}
            ResultadoDecodificacion = {Send PuertoCodificacionRSA decodificar(TextoADecodificar {String.toInt N} {String.toInt D } {List.length N} $)}
            {TextHandle set(ResultadoDecodificacion)}
         end
      else 
         TipoDecodificacionAGenerar = 'IDEA' 
         RutaClaveIDEA = {RutaArchivoACargar ".ideak" "Clave IDEA para codificar" "ideak"}
         if RutaClaveIDEA \= nil then
            ClaveIDEA = {Send PuertoCargaArchivo cargarArchivo(RutaClaveIDEA $) }
            TextoADecodificar = {TextHandle get($)}
            ResultadoDecodificacion = {Send PuertoCodificacionIDEA decodificar(TextoADecodificar ClaveIDEA $)}
            {TextHandle set(ResultadoDecodificacion)}
         end
      end
      

      %{TextHandle set('N = ')}
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
	      tbbutton(text:"Guardar" glue:w action:AlmacenarTexto)
	      tbbutton(text:"Codificar" glue:w action:CodificarTexto)
         tbbutton(text:"Decodificar" glue:w action:DecodificarTexto)
	      tbbutton(text:"Cerrar" glue:w action:CerrarAplicacion))

   TipoLlaves=td(radiobutton(text:'RSA' 
			     init:true 
			     group:radio1 handle:Handle )
		 radiobutton(text:"IDEA"
			     group:radio1) )
 
   TextHandle EntryHandle Handle
 
   Window={QTk.build td(Toolbar
			text(glue:nswe handle:TextHandle bg:white tdscrollbar:true)
			lr( 
			    tbbutton(text:"Generar Claves"
				     glue:w  action:GenerarLlaves	)
			    TipoLlaves)
		       )}
   
   {AlambrarComponentes}                  
   {Window show}
end

