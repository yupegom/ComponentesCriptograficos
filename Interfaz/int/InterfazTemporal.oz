declare X R F1 R1 F2 R2 F3 R3 Flujo PuertoGestorArchivo
[QTk]={Module.link ["x-oz://system/wp/QTk.ozf"]}
[LibreriaCriptografica]={Module.link ['../../LibreriaCriptografica/LibreriaCriptografica.ozf']}
[GestorArchivos] = {Module.link[ '../../GestorArchivo/GestorArchivo.ozf' ]}
{LibreriaCriptografica.generarLlaves F3 R3}
{GestorArchivos.gestorArchivo Flujo PuertoGestorArchivo}

proc{AlmacenarTexto}
   RutaArchivo={QTk.dialogbox save($)} Contenido
in  
   if RutaArchivo \= nil then
      Contenido={TextHandle get($)}
      {Send PuertoGestorArchivo almacenarArchivo(Contenido RutaArchivo)}
   end
end  
 
proc{CargarArchivo} 
   %Name={QTk.dialogbox load($)}
   RutaArchivo={QTk.dialogbox load(defaultextension:"txt" 
			      initialdir:"." 
			      title:"Cargar Archivo de texto..." 
			      initialfile:"" 
			      filetypes:q(q("Archivos de texto" q(".txt"))
					 ) $)}
in  
   if RutaArchivo \= nil then
      try
	 ContenidoArchivo = {Send PuertoGestorArchivo cargarArchivo(RutaArchivo $) }     
      in
     % Ruta={String.toAtom Name}
	 %Content = {Archivo getContenido($)}
	 {TextHandle set( ContenidoArchivo )}
      %X={String.toAtom Contents}
      %{Browse Archivo}
      catch _ then {Browse 'Error'} end  
   end
end

proc{GenerarLlaves}
   Clave ClavePrivadaRSA ClavePublicaRSA E N D in

   Clave = {Send R3 generarLlave('RSA' $)}
   ClavePrivadaRSA = {Clave getClavePrivada($)}
   ClavePublicaRSA = {Clave getClavePublica($)}
   E = {ClavePrivadaRSA getE($)}
   %{Browse E}
   N = {ClavePrivadaRSA getN($)}
   D = {ClavePublicaRSA getD($)}
   {TextHandle set(D)}

   %{TextHandle set('N = ')}
end

   

%proc {ReadEntry}
   
Toolbar=lr(glue:we
	   tbbutton(text:"Cargar" glue:w action:CargarArchivo)
	   tbbutton(text:"Guardar" glue:w action:AlmacenarTexto)
	   tbbutton(text:"Cerrar" glue:w action:toplevel#close))
 
TextHandle EntryHandle Text
 
Window={QTk.build td(Toolbar
		     text(glue:nswe handle:TextHandle bg:white tdscrollbar:true)
		     lr( entry(glue:w init:"Texto a encriptar"
			       relief:solid
			       handle:EntryHandle
			       return:Text)
			 tbbutton(text:"Generar Claves"
				  glue:w  action:GenerarLlaves	))
		    )}
                    
{Window show}
