declare A = "1" B ="chao"


   fun{TextToAscii Texto}
      
      case
         Texto of H|nil then {IntToString H}
      [] H|T then {Append {IntToString H} {TextToAscii T}}
        
      end
   end

   {Browse {List.take A 1000}}
{Browse {StringToInt {TextToAscii A}}}
    
