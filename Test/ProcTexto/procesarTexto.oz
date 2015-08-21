declare
fun{TextToAscii Texto}
      
   case
      Texto of H|nil then {AddZeros {IntToString H}}
   [] H|T then {Append {AddZeros {IntToString H}} {TextToAscii T}}
        
   end
end

fun{TextToAscii2 Texto}
      
   case
      Texto of H|nil then  {IntToString H}
   [] H|T then {Append  {IntToString H} {TextToAscii T}}
        
   end
end

fun {AddZeros Value}
   if {List.length Value} < 3 then
      {AddZeros {Append "0" Value}}
   else
      Value
   end
      
end

fun{AsciiToText Value}
   if {List.length Value} > 0 then
      {Append [{StringToInt {List.dropWhile {List.take Value 3} IsZero}}] {AsciiToText {List.drop Value 3}}}
   else
    nil
   end
   
end

fun {Test Value}
  %  case Value of H|T then {Append  {IntToString H} T}
%    [] _ then nil
%    end
   
   {List.append [{StringToInt Value}] ""  }
end


fun {IsZero A}
   A == 48
end


{Browse "H"}
%{Browse {Append "H" {Char.toAtom 72}}}
%{Browse {TextToAscii "H"}}
{Browse {StringToAtom {AsciiToText {TextToAscii "H"}}}}
%{Browse   {Test {TextToAscii2 "H"}}}
%{Browse {Map ["1" "3" "3" ] StringToInt}}

declare L = "000"
{Browse {And true "0"\=0}}
{Browse {And {List.length "0"}>0 {List.dropWhile "00001" IsZero}\=nil}}
{Browse L}
{Browse {List.take L 3}=="00"}
