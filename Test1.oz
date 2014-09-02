declare A='a' L="bola" X
D = {NewDictionary}

{Dictionary.put D 'a' 1}
{Dictionary.put D 'b' 2}
{Dictionary.put D 'c' 3}
%{Browse {Dictionary.get D 'b'}}

% declare
% fun {Lists L1 L2}
%    case L1 of H1|T1 then
%       %{Browse {Dictionary.get D H1}}
%       {Lists T1 {Append L2 H1}}
%    end
%    case L1 of H1|nil then
%       {Append H1 L2}
%       L2
%    end
   
% end

%X={Lists "hola" "df"}
%{Browse X }


%{Browse {String.toInt {Map "hola" fun {$ X} X end} }}
% {Browse {Map "hola" fun {$ X} X end}}
% Z = {Map "hola" fun {$ X} {Int.toString X} end}
% {Browse {String.isInt Z}}
      
%{D.put A 1}
%{Browse {D.get a}}

declare
% turns [1,2,3] into 321
fun {Unlistify L}
   case
      L of nil then {Browse ""} ""
   [] H|T then {Browse H} {Append {Int.toString H} {Unlistify T}}%{List.append H {Unlistify T}}%H + 10 * {Unlistify T}
   end
end

fun {Unlistify2 L}
   case
      L of nil then 0
   [] H|T then H + 10 * {Unlistify T}
   end
end

%{Browse {String.toInt {Unlistify "hola"}}}
%{Browse {String.toAtom {Int.toString 104}} }
%{Browse {Append {Int.toString 1} {Int.toString 2}}}
