functor  
import 
   Browser
   IntBitSupport at 'file:../../BitOperations/IntWithBitSupport.ozf'
   Dictionary at 'x-oz://system/adt/Dictionary.ozf'
   ProcesadorTexto
export 
   codificador:CodificadorIDEA
define 	 
   class CodificadorIDEA

      attr puertoOpMatematicas llamadaServicioExterno
      meth init(PuertoOpMatematicas LlamadaAServicio)
   	   puertoOpMatematicas := PuertoOpMatematicas
         llamadaServicioExterno := LlamadaAServicio
      end
         
      meth codificar(TextoACodificar LlaveIdea ?TextoCodificado)
         Bloque BloqueOriginal BloqueA BloqueB BloqueC BloqueD L L1 L2 ProcesadorTextoACodificar = {New ProcesadorTexto.procesadorTexto init} in
         %Tomamos el texto a codificar y lo convertimos a un binario de 64 bits para sacar los cuatro bloques de 16
         BloqueOriginal = {{New IntBitSupport.intBitSupport init(64 {StringToInt TextoACodificar})} asBinaryString($)}
         Bloque = {ProcesadorTextoACodificar addLeadingZeros( BloqueOriginal 64 $)} 
         %Bloque = BloqueOriginal
         {Browser.browse 'Tamaño del bloque'}
         {Browser.browse {List.length Bloque}}
         {Browser.browse 'Bloque'}
         {Browser.browse {StringToAtom Bloque}}
         {Browser.browse 'Valor INT del bloque'}
         {Browser.browse {{New IntBitSupport.intBitSupport init(64 {@llamadaServicioExterno @puertoOpMatematicas toInt(Bloque 64 $)})} getValue($)} }
         BloqueA = {New IntBitSupport.intBitSupport init(16 {@llamadaServicioExterno @puertoOpMatematicas toInt({List.take Bloque 16} 16 $)})}
         {Browser.browse {StringToAtom {BloqueA asBinaryString($)}}}
         {List.drop Bloque 16 L}
         BloqueB = {New IntBitSupport.intBitSupport init(16 {@llamadaServicioExterno @puertoOpMatematicas toInt({List.take L 16} 16 $)})}
         {Browser.browse {StringToAtom {BloqueB asBinaryString($)}}}
         {List.drop L 16 L1}
         BloqueC = {New IntBitSupport.intBitSupport init(16 {@llamadaServicioExterno @puertoOpMatematicas toInt({List.take L1 16} 16 $)})}
         {Browser.browse {StringToAtom {BloqueC asBinaryString($)}}}
         {List.drop L1 16 L2}
         BloqueD = {New IntBitSupport.intBitSupport init(16 {@llamadaServicioExterno @puertoOpMatematicas toInt({List.take L2 16} 16 $)})}
         {Browser.browse {StringToAtom {BloqueD asBinaryString($)}}}

         TextoCodificado ={Codificar  BloqueA BloqueB BloqueC BloqueD {Dictionary.new} {LlaveIdea getSubclaves($)} 0 @llamadaServicioExterno @puertoOpMatematicas}
      end

      %Al decodificar lo que cambia son las claves generadas a partir de la clave inicial, el proceso es igual al de codificación
      meth decodificar(TextoADecodificar LlaveIdea ?TextoDecodificado)
         TextoDecodificado = {self codificar(TextoADecodificar LlaveIdea $)}
      end

   end

   fun{Codificar BloqueA BloqueB BloqueC BloqueD Results Subclaves Ronda Servicio Puerto}
      L1 L2 in

      if Ronda < 1 then 
         {Results.put 1 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto productoModulo({BloqueA getValue($)} {Subclaves.get 0+(6*Ronda)} $)})}}
         {Results.put 2 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto sumaModulo({BloqueB getValue($)} {Subclaves.get 1+(6*Ronda)} $)})}}
         {Results.put 3 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto sumaModulo({BloqueC getValue($)} {Subclaves.get 2+(6*Ronda)} $)})}}
         {Results.put 4 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto productoModulo({BloqueD getValue($)} {Subclaves.get 3+(6*Ronda)} $)})}}
         
         {Results.put 5 {{Results.get 1} xor({Results.get 3} 16 $)}}
         {Results.put 6 {{Results.get 2} xor({Results.get 4} 16 $)}}

         {Results.put 7 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto productoModulo({{Results.get 5} getValue($)} {Subclaves.get 4+(6*Ronda)} $)})}}
         {Results.put 8 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto sumaModulo({{Results.get 7} getValue($)} {{Results.get 6} getValue($)} $)})}}

         {Results.put 9 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto productoModulo({{Results.get 8} getValue($)} {Subclaves.get 5+(6*Ronda)} $)})}}
         {Results.put 10 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto sumaModulo({{Results.get 9} getValue($)} {{Results.get 7} getValue($)} $)})}}

         {Results.put 11 {{Results.get 1} xor({Results.get 9} 16 $)}}
         {Results.put 12 {{Results.get 3} xor({Results.get 9} 16 $)}}
         {Results.put 13 {{Results.get 2} xor({Results.get 10} 16 $)}}
         {Results.put 14 {{Results.get 4} xor({Results.get 10} 16 $)}}

         {Browser.browse {List.map {Results.items} fun {$ X} {X getValue($)} end}}
         {Codificar  {Results.get 11} {Results.get 13} {Results.get 12} {Results.get 14} Results Subclaves Ronda+1 Servicio Puerto}
      else
         {Browser.browse {Subclaves.keys}}
         {Results.put 15 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto productoModulo({BloqueA getValue($)} {Subclaves.get 48} $)})}}
         {Results.put 16 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto sumaModulo({BloqueB getValue($)} {Subclaves.get 49} $)})}}
         {Results.put 17 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto sumaModulo({BloqueC getValue($)} {Subclaves.get 50} $)})}}
         {Results.put 18 {New IntBitSupport.intBitSupport init(16 {Servicio Puerto productoModulo({BloqueD getValue($)} {Subclaves.get 51} $)})}}

         {Browser.browse 'Bloques codificados'}
         {Browser.browse {StringToAtom {{Results.get 15} asBinaryString($)}}}
         {Browser.browse {List.length {{Results.get 15} asBinaryString($)}}}
         {Browser.browse {StringToAtom {{Results.get 16} asBinaryString($)}}}
         {Browser.browse {List.length {{Results.get 16} asBinaryString($)}}}
         {Browser.browse {StringToAtom {{Results.get 17} asBinaryString($)}}}
         {Browser.browse {List.length {{Results.get 17} asBinaryString($)}}}
         {Browser.browse {StringToAtom {{Results.get 18} asBinaryString($)}}}
         {Browser.browse {List.length {{Results.get 18} asBinaryString($)}}}

         %L1={List.append {IntToString {{Results.get 15} getValue($)}} {IntToString {{Results.get 16} getValue($)}}}
         %L2={List.append {IntToString {{Results.get 17} getValue($)}} {IntToString {{Results.get 18} getValue($)}}}
         L1={List.append {{Results.get 15} asBinaryString($)} {{Results.get 16} asBinaryString($)}}
         L2={List.append {{Results.get 17} asBinaryString($)} {{Results.get 18} asBinaryString($)}}

         {Browser.browse 'Result'}
         {Browser.browse {StringToAtom {List.append L1 L2}}}
         {Browser.browse  {Servicio Puerto toInt({List.append L1 L2} 64 $)}}

         {IntToString {Servicio Puerto toInt({List.append L1 L2} 64 $)}}

         %{List.append L1 L2}
      end
   end

end
