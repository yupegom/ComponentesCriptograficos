%{Browse {String.toInt "hola"}}

%declare X

%fun{Test M L}
%   case L of nil then M
%   [] H|T then {Test {Append H M} T}
%   end
%end

%X= {Test "" "Hola"}
%{Browse X}

declare
X = "abc"
Y = [1 2 3] 
{Browse Y}

declare Y
fun {Map Xs F}
   case Xs
   of nil then nil
   [] X|Xr then {F X}|{Map Xr F}
   end 
end

{Browse {Map "hola" fun {$ X} X+0 end}}
{Browse "A"}