functor

export intBitSupport:IntegerWithBitSupport
define
   class IntegerWithBitSupport

      attr value ibs

      meth init( Value )
         value := Value
         ibs := {IntToBitString @value }
      end

      meth getValue( ?Value )
         Value = @value
      end

      meth asBitString( ?IBS )
         IBS = @ibs
      end

      meth asBinaryString( ?BinaryString )
         BinaryString = {IntToBinaryString @value}
      end

      %Recibe el número de rotaciones que deben hacerse
      meth shift( N ?IntegerAfterShiftRotation )
         IntegerAfterShiftRotation = {Shift N @ibs}
      end

   end

   fun {Shift N IBS}
        P = fun {$ X} if( X + N ) >= 128 then (X + N - 128) else X + N end  end
      in
        {New IntegerWithBitSupport init({BitListToInt {List.map {BitString.toList IBS} P}})}
       
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

   fun {IntToBitString I}
        {BitString.make 128 {MakeIndexList {List.reverse {I2BL I ""}} 0}}
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
   

   
end