declare[IntBitSupport]={Module.link ['../../BitOperations/IntWithBitSupport.ozf']}
declare[PT]={Module.link ['../../CodificadorIDEA/ProcesadorTexto.ozf']}
declare[M]={Module.link ['../../ComponenteMatematico/FuncionesAvanzadas.ozf']}
Int = 1234567812345678
Bloque BloqueOriginal L

ProcesadorTextoACodificar = {New PT.procesadorTexto init}
Integer = {New IntBitSupport.intBitSupport init(64 Int)}
Matematico = {New M.matematicaAvanzada init}

%{Browse {List.length {IntToString {Integer getValue($)}}}}
%{Browse {Integer asBitString($)}}
L L1 L2
Clave=10112613299966429639576403088473158970

{Browse 'Bloque original'}
BloqueOriginal = {Integer asBinaryString($)}
{Browse {StringToAtom BloqueOriginal}}
Bloque = {ProcesadorTextoACodificar addLeadingZeros( BloqueOriginal 64 $)}
{Browse 'Bloque 64 bits'}
{Browse {StringToAtom Bloque}}

{Browse 'BloqueA to int'}
{Browse {Matematico toInt({List.take Bloque 16} 16 $)}}

{Browse 'BloqueA'}
BloqueA = {New IntBitSupport.intBitSupport init(16 {Matematico toInt({List.take Bloque 16} 16 $)})}
BloqueAFinal = {ProcesadorTextoACodificar addLeadingZeros( {BloqueA asBinaryString($)} 16 $)}
{Browser.browse {StringToAtom BloqueAFinal }}
%{List.drop Bloque 16 L}
%BloqueB = {New IntBitSupport.intBitSupport init(16 {Matematico toInt({List.take L 16} 16 $)})}
%{Browser.browse {StringToAtom {BloqueB asBinaryString($)}}}
%{List.drop L 16 L1}
%BloqueC = {New IntBitSupport.intBitSupport init(16 {Matematico toInt({List.take L1 16} 16 $)})}
%{Browser.browse {StringToAtom {BloqueC asBinaryString($)}}}
%{List.drop L1 16 L2}
%BloqueD = {New IntBitSupport.intBitSupport init(16 {Matematico toInt({List.take L2 16} 16 $)})}
%{Browser.browse {StringToAtom {BloqueD asBinaryString($)}}}
{Browser.browse 'Sublclaves Claveinicial'}
IntWhitBitSupport = {New IntBitSupport.intBitSupport init(128 Clave)}
{Browser.browse 'Binary String ClaveIDEA'}
{Browser.browse {IntWhitBitSupport asBitString($)}}
{Browser.browse {BitString.width  {IntWhitBitSupport asBitString($)}}}
{Browser.browse {StringToAtom {IntWhitBitSupport asBinaryString($)}}}
{Browser.browse {List.length {IntWhitBitSupport asBinaryString($)}}}
{Browser.browse {List.length {ProcesadorTextoACodificar addLeadingZeros({IntWhitBitSupport asBinaryString($)} 128 $)}}}

{GenKeys IntWhitBitSupport}

fun {GenKeys Value}
   D={Dictionary.new} in
   {Browser.browse 'Empieza'}
	   	{GetKeys Value D}
end

fun{ToList List Indice}
	   
	   case List of H|T then
	      if H == 49 then  Indice | {ToList T Indice+1}
	      else {ToList T Indice+1}
	      end
	   [] nil then nil
	   end
end

fun {BL2I Bin}
	      P = fun {$ X Y} Y + {Number.pow 2 X} end
	      in
	      {List.foldR Bin P 0}
end

fun {AddRightZeros Bloque TamanoBloque}
      if {List.length Bloque} < TamanoBloque then
         {AddRightZeros {Append Bloque "0"} TamanoBloque}
      else
         Bloque
      end
      
   end

fun {BitStringToInt Bin}
	   IndexOfBin = {ToList Bin 0} in
	   {BL2I {BitString.toList {BitString.make 16 IndexOfBin}}}
end

fun{GetKeys Value D}
	    proc{Loop TextBlock} ValueShifted
	    	Key = {List.length {D.keys}} in
		    if Key =< 51 then
			   if {List.length  TextBlock} > 0 then
			   	  {D.put Key {BitStringToInt {List.reverse {List.take TextBlock 16}}}}
			      {Loop {List.drop TextBlock 16}}
			   else
			   	  ValueShifted = {GetKeys {Value shift(25 $)} D}
			   end
			end

	    end in
   {Browser.browse {Value getValue($)}}
	    {Loop {AddRightZeros {Value asBinaryString($)} 128} } D
end



	