declare IBS = {BitString.make 32 [ 0 2  ]}
P = fun {$ X} {System.show X } X + 2 end


{Browse {List.map {BitString.toList IBS} P}}
{Browse {BitString.toList IBS}}