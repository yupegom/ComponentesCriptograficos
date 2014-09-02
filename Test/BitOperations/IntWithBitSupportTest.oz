declare[IntBitSupport]={Module.link ['../../BitOperations/IntWithBitSupport.ozf']}
Int = 101126132999664296395764030884731589700
%Int = 10010002000300040005000600070008

Integer = {New IntBitSupport.intBitSupport init(128 Int)}
{Browse {List.length {IntToString {Integer getValue($)}}}}
{Browse {Integer getValue($)}}
{Browse {StringToAtom {Integer asBinaryString($)}}}
{Browse {List.length {Integer asBinaryString($)}}}
Integer2= {Integer shift(25 $)}
{Browse {Integer2 getValue($)}}
{Browse {List.length {IntToString {Integer2 getValue($)}}}}
{Browse {StringToAtom {Integer2 asBinaryString($)}}}
{Browse {List.length {Integer2 asBinaryString($)}}}
{Browse {Integer2 asBitString($)}}
IntegerX = {New IntBitSupport.intBitSupport init(128 3)}
IntegerY = {New IntBitSupport.intBitSupport init(128 4)}
{Browse {StringToAtom {IntegerX asBinaryString($)}}}
{Browse {StringToAtom {IntegerY asBinaryString($)}}}
Result = {IntegerX xor(IntegerY 128 $)}
{Browse {StringToAtom {Result asBinaryString($)}}}
{Browse {Result getValue($)}}
Inverse = {IntegerY xor(Result 128 $)}
{Browse {IntegerX getValue($)}}
{Browse {Inverse getValue($)}}
