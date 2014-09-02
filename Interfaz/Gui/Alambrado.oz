declare X R F1 R1 F2 R2 F3 R3 Flujo FlujoAlmacenamiento PuertoCargaArchivo PuertoAlmacenamientoArchivo Flujo3
[LibreriaCriptografica]={Module.link ['../../LibreriaCriptografica/LibreriaCriptografica.ozf']}
[GeneradorClave]={Module.link['../../GeneradorClave/GeneradorClave.ozf']}
[GestorArchivos] = {Module.link[ '../../GestorArchivo/GestorArchivo.ozf' ]}
{GestorArchivos.cargarArchivo Flujo PuertoCargaArchivo}
{GestorArchivos.almacenarArchivo FlujoAlmacenamiento PuertoAlmacenamientoArchivo}
proc {AlambrarComponentes}
   thread {GeneradorClave.generadorClave Flujo3 R2} end
   thread {LibreriaCriptografica.generarLlaves R2 F3 R3} end
end

{AlambrarComponentes}