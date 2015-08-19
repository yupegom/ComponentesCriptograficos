declare[Dictionary]={Module.link ['x-oz://system/adt/Dictionary.ozf']}
declare[IntBitSupport]={Module.link ['C:/Users/Fernando/Documents/My Dropbox/ComponentesCriptograficos/BitOperations/IntWithBitSupport.ozf']}

fun {GenKeys Value}
   D={Dictionary.new} Key in
   {GetKeys Value D}
	   
end

fun{GetKeys Value D}
	    
   proc{Loop TextBlock}
      Temp Key = {List.length {D.keys}} in
      {Browse {StringToAtom TextBlock}}
      if Key < 51 then
	 if {List.length  TextBlock} > 0 then
	    {D.put Key {BitStringToInt {List.reverse {List.take TextBlock 16}}}}
	    {Loop {List.drop TextBlock 16}}
	 else
	    {Browse {Value getValue($)}}
	    {Loop {{Value shift(16 $)} asBinaryString($)}} 
	 end
      end

   end in
   {Loop {Value asBinaryString($)}} D
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

IntegerWhitBitSupport = {New IntBitSupport.intBitSupport init(128 10112613299966429639576403088473158970)}
{Browse {{GenKeys IntegerWhitBitSupport}.items}}