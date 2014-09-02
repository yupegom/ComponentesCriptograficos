declare[IntBitSupport]={Module.link ['../../BitOperations/IntWithBitSupport.ozf']}

declare L = [[1 2] [3 4]]
L1 = [1234]
%{Browse L.1.1}

fun {GenKeys Value Ronda}
   KeyRonda IntegerWhitBitSupport ValueToShift in
   ValueToShift = {Value shift(16 $)}
   if Ronda < 8 then
      KeyRonda = {GetKeys {Value asBinaryString($)}}
      KeyRonda | {GenKeys ValueToShift Ronda+1 }
   else
      
      [ {GetKeys {ValueToShift asBinaryString($)}} ]
   end
end

fun{GetKeys Value}
   Temp in
   if {List.length  Value} =< 16 then
      [ {IntToString {BitStringToInt {List.reverse Value}}} ]
   else
      Temp = {List.take Value 16}
      {IntToString {BitStringToInt {List.reverse Temp}}} | {GetKeys {List.drop Value 16}}
   end
end

fun {BL2I Bin}
      P = fun {$ X Y} Y + {Number.pow 2 X} end
      in
      {List.foldR Bin P 0}
end

fun {BitStringToInt Bin}
   IndexOfBin = {ToList Bin 0} in
   {BL2I {BitString.toList {BitString.make 16 IndexOfBin}}}
end

fun{ToList List Indice}
   
   case List of H|T then
      if H == 49 then  Indice | {ToList T Indice+1}
      else {ToList T Indice+1}
      end
   [] nil then nil
   end
end


declare

IntegerWhitBitSupport = {New IntBitSupport.intBitSupport init(128 10112613299966429639576403088473158970)}
{Browse {StringToAtom {IntegerWhitBitSupport asBinaryString($)}}}
{Browse {IntegerWhitBitSupport getValue($)}}
{Browse {GenKeys IntegerWhitBitSupport 1}}

