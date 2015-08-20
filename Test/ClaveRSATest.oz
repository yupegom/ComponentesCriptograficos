%declare [ServicioGeneradorClaves]={Module.link ['/home/seven4n/Dropbox/Proyecto/FuncionesBasicas.ozf']}

declare[Clave]={Module.link ['../GeneradorClave/Clave.ozf']}
declare[ClavePrivada]={Module.link ['../GeneradorClave/ClavePrivadaRSA.ozf']}
declare[ClavePublica]={Module.link ['../GeneradorClave/ClavePublicaRSA.ozf']}
D
ClavePrivadaRSA = {New ClavePrivada.clavePrivadaRSA init(28 0)}
ClavePublicaRSA = {New ClavePublica.clavePublicaRSA init(28 0)}


ClaveRSA = {New Clave.clave init}
{ClaveRSA setTipoClave('RSA')}

{Browse {ClaveRSA getTipoClave($)}}