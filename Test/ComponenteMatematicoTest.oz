declare SonPrimos
[ComponenteMatematico]={Module.link ['../ComponenteMatematico/ComponenteMatematico.ozf']}
PuertoOpMatematicas = {ComponenteMatematico.interfazMatematicaAvanzada _ $}

SonPrimos = {Send PuertoOpMatematicas verificarCoprimalidad(99720930713792136711893398807118793972539787163499815266954748696299302139079 96642143513025090447720156774474626259144348429505860962661123942802193326421 $)}
{Browse SonPrimos}
