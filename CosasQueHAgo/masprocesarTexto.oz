
%Despu�s de decodificar el texto debe volver a su valor original. Se usa 3 como el tama�o de cada caracter
declare
fun{AsciiToText Value}
      %{Browser.browse {StringToAtom Value}}
   if {And {List.length Value}>0 {List.dropWhile Value IsZero}\=nil}  then
         
      if {List.take Value 3}\="000" then
	 {Append [{StringToInt {List.dropWhile {List.take Value 3} IsZero}}] {AsciiToText {List.drop Value 3}}}
      else 
	 {AsciiToText {List.drop Value 3}}
      end
   else
      nil
   end
      
end

fun {IsZero A}
      A == 48
end


{Browse {StringToAtom {AsciiToText "399"}}}
%{Browse {List.take "3" 3}=="0"}