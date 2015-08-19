functor
import
ProcesadorTexto at 'file:../../CodificadorIDEA/ProcesadorTexto.ozf'
export intBitSupport:IntegerWithBitSupport
define
   class IntegerWithBitSupport

      attr value ibs length procesadorTexto

      meth init( Length Value )
         value := Value
         length := Length
         procesadorTexto := {New ProcesadorTexto.procesadorTexto init}
         ibs := {IntToBitString Length @value }
      end

      meth getValue( ?Value )
         Value = @value
      end

      meth asBitString( ?IBS )
         IBS = @ibs
      end

      meth asBinaryString( ?BinaryString )
         BinaryString = {@procesadorTexto addLeadingZeros({IntToBinaryString @value} @length $)}
      end

      %Recibe el número de rotaciones que deben hacerse
      meth shift( N ?IntegerAfterShiftRotation )
         IntegerAfterShiftRotation = {Shift N @length @ibs}
      end

      meth xor(Integer Length ?IntegerXOR)
         IntAux in
         IntAux = {BitString.disj {BitString.conj {self asBitString($)} {BitString.nega {Integer asBitString($)}}} {BitString.conj {BitString.nega {self asBitString($)}} {Integer asBitString($)}}}
         IntegerXOR = {New IntegerWithBitSupport init(Length {BitStringToInt IntAux})}
      end


   end

   fun {Shift N Length IBS}
        P = fun {$ X} if( X + N ) >= Length then (X + N - Length) else X + N end  end
      in
        {New IntegerWithBitSupport init(Length {BitListToInt {List.map {BitString.toList IBS} P}})}
       
   end

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

   fun {IntToBitString Length I}
        {BitString.make Length {MakeIndexList {List.reverse {I2BL I ""}} 0}}
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
      
   %fun {BinaryStringToInt Bin}
   %   P = fun {$ I X Y} Y + (X - 48) * {Number.pow 2 (I - 1)} end
   %  in
   %   {List.foldRInd {List.reverse Bin} P 0}
   %end
   

   
end