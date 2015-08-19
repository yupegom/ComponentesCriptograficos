
declare[ProcesadorText]={Module.link ['../CodificadorRSA/ProcesadorTexto.ozf']}
T O
PTexto = {New ProcesadorText.procesadorTexto init}

{PTexto textToASCIICode("RS2" T)}
{PTexto asciiTextToClearText(T O)}
{Browse {StringToAtom T}}
{Browse {StringToAtom O}}
{Browse {StringToInt T}}