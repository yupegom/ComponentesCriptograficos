functor  
import 
   IntBitSupport at 'file:../../BitOperations/IntWithBitSupport.ozf'
   Dictionary at 'x-oz://system/adt/Dictionary.ozf'
   TextoCodificado
   TextoDecodificado
export 
   codificador:CodificadorIDEA
define 	 
   class CodificadorIDEA

      attr opMatematicas textoCodificado textoDecodificado
      meth init(Matematicas)
         opMatematicas := Matematicas
      end
         
      meth codificar(TextoACodificar Subclaves ?TextoObtenido)
         Bloque BloqueA BloqueB BloqueC BloqueD L L1 L2  ResCodificacion in
         %Tomamos el texto a codificar y lo convertimos a un binario de 64 bits para sacar los cuatro bloques de 16
         Bloque = {{New IntBitSupport.intBitSupport init(64 {StringToInt TextoACodificar})} asBinaryString($)}
         BloqueA = {New IntBitSupport.intBitSupport init(16 {@opMatematicas toInt({List.take Bloque 16} 16 $)})}
         {List.drop Bloque 16 L}
         BloqueB = {New IntBitSupport.intBitSupport init(16 {@opMatematicas toInt({List.take L 16} 16 $)})}
         {List.drop L 16 L1}
         BloqueC = {New IntBitSupport.intBitSupport init(16 {@opMatematicas toInt({List.take L1 16} 16 $)})}
         {List.drop L1 16 L2}
         BloqueD = {New IntBitSupport.intBitSupport init(16 {@opMatematicas toInt({List.take L2 16} 16 $)})}
         %Subclaves = {LlaveIdea subclaves($)}

         ResCodificacion = {Codificar BloqueA BloqueB BloqueC BloqueD {Dictionary.new}  Subclaves 0 @opMatematicas}
         TextoObtenido = {New TextoCodificado.textoCodificado init(ResCodificacion)}
      end

      %Al decodificar lo que cambia son las claves generadas a partir de la clave inicial, el proceso es igual al de codificación
      meth decodificar(TextoADecodificar LlaveIdea ?TextoObtenido)
         ResDecodificacion Subclaves in
         Subclaves = {LlaveIdea subclaves($)}
         ResDecodificacion = {self codificar(TextoADecodificar Subclaves $)}
         TextoObtenido = {New TextoDecodificado.textoDecodificado init({ResDecodificacion texto($)})}
      end

   end

   fun{Codificar BloqueA BloqueB BloqueC BloqueD Results Subclaves Ronda OpMatematicas}
      L1 L2 Result in
      if Ronda < 8 then 
         {Results.put 1 {New IntBitSupport.intBitSupport init(16 {OpMatematicas productoModulo({BloqueA getValue($)} {Subclaves.get 0+(6*Ronda)} $)})}}
         {Results.put 2 {New IntBitSupport.intBitSupport init(16 {OpMatematicas sumaModulo({BloqueB getValue($)} {Subclaves.get 1+(6*Ronda)} $)})}}
         {Results.put 3 {New IntBitSupport.intBitSupport init(16 {OpMatematicas sumaModulo({BloqueC getValue($)} {Subclaves.get 2+(6*Ronda)} $)})}}
         {Results.put 4 {New IntBitSupport.intBitSupport init(16 {OpMatematicas productoModulo({BloqueD getValue($)} {Subclaves.get 3+(6*Ronda)} $)})}}
         
         {Results.put 5 {{Results.get 1} xor({Results.get 3} 16 $)}}
         {Results.put 6 {{Results.get 2} xor({Results.get 4} 16 $)}}

         {Results.put 7 {New IntBitSupport.intBitSupport init(16 {OpMatematicas productoModulo({{Results.get 5} getValue($)} {Subclaves.get 4+(6*Ronda)} $)})}}
         {Results.put 8 {New IntBitSupport.intBitSupport init(16 {OpMatematicas sumaModulo({{Results.get 7} getValue($)} {{Results.get 6} getValue($)} $)})}}

         {Results.put 9 {New IntBitSupport.intBitSupport init(16 {OpMatematicas productoModulo({{Results.get 8} getValue($)} {Subclaves.get 5+(6*Ronda)} $)})}}
         {Results.put 10 {New IntBitSupport.intBitSupport init(16 {OpMatematicas sumaModulo({{Results.get 9} getValue($)} {{Results.get 7} getValue($)} $)})}}

         {Results.put 11 {{Results.get 1} xor({Results.get 9} 16 $)}}
         {Results.put 12 {{Results.get 3} xor({Results.get 9} 16 $)}}
         {Results.put 13 {{Results.get 2} xor({Results.get 10} 16 $)}}
         {Results.put 14 {{Results.get 4} xor({Results.get 10} 16 $)}}
         
         {Codificar  {Results.get 11} {Results.get 13} {Results.get 12} {Results.get 14} Results Subclaves Ronda+1 OpMatematicas}
      else
         {Results.put 15 {New IntBitSupport.intBitSupport init(16 {OpMatematicas productoModulo({BloqueA getValue($)} {Subclaves.get 48} $)})}}
         {Results.put 16 {New IntBitSupport.intBitSupport init(16 {OpMatematicas sumaModulo({BloqueB getValue($)} {Subclaves.get 49} $)})}}
         {Results.put 17 {New IntBitSupport.intBitSupport init(16 {OpMatematicas sumaModulo({BloqueC getValue($)} {Subclaves.get 50} $)})}}
         {Results.put 18 {New IntBitSupport.intBitSupport init(16 {OpMatematicas productoModulo({BloqueD getValue($)} {Subclaves.get 51} $)})}}
         L1={List.append  {{Results.get 15} asBinaryString($)} {{Results.get 16} asBinaryString($)}}
         L2={List.append  {{Results.get 17} asBinaryString($)} {{Results.get 18} asBinaryString($)}}
         Result = {List.append L1 L2}
         {IntToString {{New IntBitSupport.intBitSupport init(64 {OpMatematicas toInt(Result 64 $)})} getValue($)}}

      end
   end
   %fun {GetValue IntValue}
    %  {StringToAtom {IntValue asBinaryString($)}}
   %end

end
