declare[ServicioGeneradorClave]={Module.link ['../../GeneradorClave/ServicioGeneradorClaves.ozf']}
declare[ClaveCodificacionIDEA]={Module.link ['../../GeneradorClave/ClaveCodificacionIDEA.ozf']}
declare[IntBitSupport]={Module.link ['../../BitOperations/IntWithBitSupport.ozf']}
declare[PT]={Module.link ['../../CodificadorIDEA/ProcesadorTexto.ozf']}
declare[M]={Module.link ['../../ComponenteMatematico/FuncionesAvanzadas.ozf']}
declare[Codificador]={Module.link ['../../CodificadorIDEA/IDEA.ozf']}
declare[OM]={Module.link ['../../CodificadorIDEA/OperacionesMatematicas.ozf']}

declare
Int = 1234567812345678
Str = "1234567812345678"

Idea = {New Codificador.codificador init({New M.matematicaAvanzada init})}

ProcesadorTextoACodificar = {New PT.procesadorTexto init}
GenClaves = {New ServicioGeneradorClave.servicioGeneradorClaves init}
TextoACodificar = {New IntBitSupport.intBitSupport init(64 Int)}
Matematico = {New M.matematicaAvanzada init}
OtroVal = {Matematico productoModulo(0 3 $)}
{Browse 'prd mod' # OtroVal}
OtroBitSup={New IntBitSupport.intBitSupport init(4 OtroVal)}
{Browse 'valor' # {OtroBitSup getValue($)}}

%ClaveS="10112613299966429639576403088473158970"
%ClaveInt=10112613299966429639576403088473158970
%Clave = {New ClaveCodificacionIDEA.claveCodificacionIDEA init(ClaveInt)}
%Subclaves = {GenClaves generarSubclavesParaCodificacion({StringToInt ClaveS} $)}
%Codificacion = {Idea codificar(Str Clave $)}

%{Browser.browse {StringToAtom {Codificacion texto($)}}}
