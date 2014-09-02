declare 
fun {BL2I Bin}
      P = fun {$ X Y} Y + {Number.pow 2 X} end
      in
      {List.foldR Bin P 0}
end

fun {BitStringToInt Bin}
   IndexOfBin = {ToList Bin 0} in
   {BL2I {BitString.toList {BitString.make 16 IndexOfBin}}}
end

fun {BinToInt Bin Sum}
   case Bin of H|T then {BinToInt T Sum+{Number.pow 2 H}}
   [] nil then Sum
   end
end 

fun{ToList List Indice}
   
   case List of H|T then
      if H == 49 then  Indice | {ToList T Indice+1}
      else {ToList T Indice+1}
      end
   [] nil then nil
   end
end

%{Browse {ToList "11111" 0}}
%{Browse {BL2I 01 }}
%{Browse {StringToAtom "001"}}
%{Browse {List.map "00010" fun {$ X } {IsInt X} end }}
%{Browse {BinToInt "01" 0}}
{Browse {BitStringToInt {List.reverse "0111"}}}