functor
import
   GeneradorClave at 'file:../../GeneradorClave/GeneradorClave.ozf'
   GestorArchivos at 'file:../../GestorArchivo/GestorArchivo.ozf'
   CodificadorRSA at 'file:../../CodificadorRSA/CodificadorRSA.ozf'
   CodificadorIDEA at 'file:../../CodificadorIDEA/CodificadorIDEA.ozf'
   ComponenteMatematico at 'file:../../ComponenteMatematico/ComponenteMatematico.ozf'
   GestorInformacion at 'file:../../GestorInformacion/GestorInformacion.ozf'
export
   interfacesDeSistema:LibreriaCriptografica
define
  %Flujos y puertos para el alambrado de componentes
   FlujoGeneradorClaves PuertoGeneradorClaves Flujo PuertoOperacionesArchivo PuertoCodificacionRSA PuertoCodificacionIDEA FlujoCodificacion FlujoCodificacionIDEA FlujoOpMatematicas PuertoOpMatematicas FlujoInformacion PuertoInformacion

   proc {AlambrarComponentes} 
      thread {GestorArchivos.operacionesArchivo Flujo PuertoOperacionesArchivo} end
      thread {GestorInformacion.infoAlgoritmo PuertoOperacionesArchivo FlujoInformacion PuertoInformacion} end
      thread {ComponenteMatematico.interfazMatematicaAvanzada FlujoOpMatematicas PuertoOpMatematicas} end
      thread {GeneradorClave.generadorClave PuertoOpMatematicas PuertoOperacionesArchivo FlujoGeneradorClaves PuertoGeneradorClaves} end
      thread {CodificadorRSA.codificadorRSA PuertoOpMatematicas FlujoCodificacion PuertoCodificacionRSA} end
      thread {CodificadorIDEA.codificadorIDEA PuertoOpMatematicas PuertoGeneradorClaves FlujoCodificacionIDEA PuertoCodificacionIDEA} end
      
   end

   class LibreriaCriptografica

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

      meth cargarInformacionRSA(?Contenido)
         {Send PuertoInformacion cargarInformacion('RSA' Contenido)}
      end

      meth cargarInformacionIDEA(?Contenido)
         {Send PuertoInformacion cargarInformacion('IDEA' Contenido)}
      end

      meth cargarAyuda(?Contenido)
         {Send PuertoInformacion cargarAyuda(Contenido)}
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
   
   fun {IsEnter A}
      A \= 10
   end
end

      
   