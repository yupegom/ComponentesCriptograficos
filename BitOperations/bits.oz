functor

import
  System(show showInfo print printInfo) Application(exit)

define
  fun {NewInteger Value}

    local

      %% Helpers

      fun {I2BS I Bin}
        if I =< 0 then
          Bin
        else D = I div 2 M = I mod 2 in
          {I2BS D (M + &0)|Bin}
        end
      end

      fun {I2BL I Bin}
        if I =< 0 then
          Bin
        else D = I div 2 M = I mod 2 in
          {I2BL D M|Bin}
        end
      end

      fun {BL2I Bin}
        P = fun {$ X Y} Y + {Number.pow 2 X} end
      in
        {List.foldR Bin P 0}
      end

      fun {MakeIndexList L AC}
        case L of nil then nil
        elseof H|T then
          if H == 1 then
            AC|{MakeIndexList T (AC + 1)}
          else
            {MakeIndexList T (AC + 1)}
          end
        end
      end

      fun {IntToBitString I}
        {BitString.make 8 {MakeIndexList {List.reverse {I2BL I ""}} 0}}
      end

      fun {BitStringToInt Bin}
        {BL2I {BitString.toList Bin}}
      end

      fun {BitListToInt Bin}
        {BL2I Bin}
      end

      fun {IntToBinaryString I}
        {I2BS I ""}
      end

      fun {BinaryStringToInt Bin}
        P = fun {$ I X Y} Y + (X - 48) * {Number.pow 2 (I - 1)} end
      in
        {List.foldRInd {List.reverse Bin} P 0}
      end

      %% Private Data

      Integer = {NewCell Value}

      IBS = {NewCell {IntToBitString Value}}

    in

      %% Interface

      fun {GetValue}
        @Integer
      end

      proc {SetValue I}
        Integer := I
        IBS := {IntToBitString I}
      end

      fun {AsBitString}
        @IBS
      end

      fun {AsBinaryString}
        {IntToBinaryString @Integer}
      end

      fun {Shift N}
        P = fun {$ X} if( X + N ) >= 8 then (X + N -8) else X + N end  end
        Q = fun {$ X} X >= 0 end
      in
        if N == 0 then
          % Clone current
          {NewInteger @Integer}
        elseif N > 0 then
          % Right Shift
%	   {System.show @IBS}
          {NewInteger {BitListToInt {List.map {BitString.toList @IBS} P}}}
        else
          % Left Shift
          {NewInteger {BitListToInt {List.filter {List.map {BitString.toList
@IBS} P} Q}}}
        end
      end


      %% ... incomplete ...
      fun {Rotate N}
        @Integer
      end

      fun {AND I}
        @Integer
      end

      fun {OR I}
        @Integer
      end

      fun {XOR I}
        @Integer
      end

      fun {NEG I}
        @Integer
      end

      fun {CMPL2 I}
        @Integer
      end

    end
  in
    ops(getValue:GetValue setValue:SetValue asBitString:AsBitString
        asBinaryString:AsBinaryString shift:Shift rotate:Rotate
        bitAND:AND bitOR:OR bitXOR:XOR neg:NEG cmpl2:CMPL2)
  end

  %% Quick Demonstration Harness

  I A B C D
in
  I = {NewInteger 127}

  {System.show {I.getValue}}
  {System.showInfo {IntToString {I.getValue}}}

   {System.showInfo {I.asBinaryString}}
   A = {{I.shift 8}.getValue}
   {System.showInfo A}
   B = {NewInteger A}
   {System.showInfo {B.asBinaryString}}
   %{I.setValue 50}
   {System.show {B.asBitString}}
   %{I.setValue 200}
   %{System.show {I.asBitString}}

   {I.setValue 127}
   {System.showInfo {IntToString {I.getValue}}}
   {System.showInfo {I.asBinaryString}}
   C = {{I.shift ~1}.getValue}
   D = {NewInteger C}
   {System.showInfo  C}
   {System.showInfo {D.asBinaryString}}

  {System.show {I.asBitString}}

  %{Application.exit 0}
end