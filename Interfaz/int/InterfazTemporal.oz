declare X R F1 R1 F2 R2 F3 R3 Flujo FlujoAlmacenamiento PuertoCargaArchivo PuertoAlmacenamientoArchivo
[QTk]={Module.link ["x-oz://system/wp/QTk.ozf"]}
[LibreriaCriptografica]={Module.link ['../../LibreriaCriptografica/LibreriaCriptografica.ozf']}
[GestorArchivos] = {Module.link[ '../../GestorArchivo/GestorArchivo.ozf' ]}
{LibreriaCriptografica.generarLlaves F3 R3}
{GestorArchivos.cargarArchivo Flujo PuertoCargaArchivo}
{GestorArchivos.almacenarArchivo FlujoAlmacenamiento PuertoAlmacenamientoArchivo}

proc{AlmacenarTexto}
   RutaArchivo={QTk.dialogbox save($)} Contenido
in  
   if RutaArchivo \= nil then
      Contenido={TextHandle get($)}
      {Send PuertoAlmacenamientoArchivo almacenarArchivo(Contenido RutaArchivo)}
   end
end  
 
proc{CargarArchivo} 
   %Name={QTk.dialogbox load($)}
   Contenido
   RutaArchivo={QTk.dialogbox load(defaultextension:"txt" 
				   initialdir:"." 
				   title:"Cargar Archivo de texto..." 
				   initialfile:"" 
				   filetypes:q(q("Archivos de texto" q(".txt"))
					      ) $)}
in  
   if RutaArchivo \= nil then
      Contenido = {Send PuertoCargaArchivo cargarArchivo(RutaArchivo $) }     
      % Ruta={String.toAtom Name}
      {TextHandle set( Contenido )}
      %X={String.toAtom Contents}
   end
end

proc{GenerarLlaves}
   Clave ClavePrivadaRSA ClavePublicaRSA E N D GenerarClaveRSA TipoLlaveAGenerar in
   {Handle get(1:GenerarClaveRSA)}
   if(GenerarClaveRSA) then TipoLlaveAGenerar= 'RSA' else TipoLlaveAGenerar = 'IDEA' end
   {Send R3 generarLlave(TipoLlaveAGenerar)}
   {TextHandle set("Clave Generada correctamente!")}

   %{TextHandle set('N = ')}
end

%proc {ReadEntry}
   
Toolbar=lr(glue:we
	   tbbutton(text:"Cargar" glue:w action:CargarArchivo)
	   tbbutton(text:"Guardar" glue:w action:AlmacenarTexto)
	   tbbutton(text:"Cerrar" glue:w action:toplevel#close))

TipoLlaves=td(radiobutton(text:'RSA' 
		    init:true 
		    group:radio1 handle:Handle )
	radiobutton(text:"IDEA"
		    group:radio1) )
 
TextHandle EntryHandle Text Handle
 
Window={QTk.build td(Toolbar
		     text(glue:nswe handle:TextHandle bg:white tdscrollbar:true)
		     lr( entry(glue:w init:"Texto a encriptar"
			       relief:solid
			       handle:EntryHandle
			       return:Text)
			 tbbutton(text:"Generar Claves"
				  glue:w  action:GenerarLlaves	)
		     TipoLlaves)
		    )}
                    
{Window show}
