%declare [ServicioGeneradorClaves]={Module.link ['/home/seven4n/Dropbox/Proyecto/FuncionesBasicas.ozf']}

declare[Clave]={Module.link ['C:/Users/Fernando/Documents/My Dropbox/Proyecto/Clave.ozf']}
declare[ClavePrivada]={Module.link ['C:/Users/Fernando/Documents/My Dropbox/Proyecto/ClavePrivadaRSA.ozf']}
D
ClavePrivadaRSA = {New ClavePrivada.clavePrivadaRSA init}
{ClavePrivadaRSA setD(28)}


ClaveRSA = {New Clave.clave init}
{ClaveRSA setClavePrivada(ClavePrivadaRSA)}
{ClaveRSA setTipoClave('RSA')}

ClavePruebaRSA = {ClaveRSA getClavePrivada($)}
D = {ClavePruebaRSA getD($)}
{Browse D}
{Browse {ClaveRSA getTipoClave($)}}