functor
import 
	Module
define
	[GUI]={Module.link['../../Interfaz/Gui/GUI.ozf']}
	[LibreriaCriptografica]={Module.link ['../../LibreriaCriptografica/LibreriaCriptografica.ozf']}
	[GeneradorClave]={Module.link['../../GeneradorClave/GeneradorClave.ozf']}
	[GestorArchivos] = {Module.link['../../GestorArchivo/GestorArchivo.ozf' ]}
	[CodificadorRSA] = {Module.link['../../CodificadorRSA/CodificadorRSA.ozf']}
	[CodificadorIDEA] = {Module.link['../../CodificadorIDEA/CodificadorIDEA.ozf']}
	[ComponenteMatematico] = {Module.link['../../ComponenteMatematico/ComponenteMatematico.ozf']}
	[GestorNumeros] = {Module.link['../../GestorNumeros/GestorNumeros.ozf']}


	%Flujos y puertos para el alambrado de componentes
	FlujoGeneradorClaves PuertoGeneradorClaves Flujo PuertoOperacionesArchivo PuertoCodificacionRSA PuertoCodificacionIDEA FlujoCodificacion FlujoCodificacionIDEA FlujoOpMatematicas PuertoOpMatematicas
	FlujoNumeros PuertoGeneradorNumeros

	proc {AlambrarComponentes} 
		thread 
			{GestorArchivos.operacionesArchivo Flujo PuertoOperacionesArchivo} 
			{ComponenteMatematico.interfazMatematicaAvanzada PuertoGeneradorNumeros FlujoOpMatematicas PuertoOpMatematicas} 
			{GestorNumeros.gestorNumero PuertoOpMatematicas FlujoNumeros PuertoGeneradorNumeros} 
			{GeneradorClave.generadorClave PuertoOpMatematicas PuertoGeneradorNumeros PuertoOperacionesArchivo FlujoGeneradorClaves PuertoGeneradorClaves} 
			{CodificadorRSA.codificadorRSA PuertoOpMatematicas FlujoCodificacion PuertoCodificacionRSA} 
			{CodificadorIDEA.codificadorIDEA PuertoOpMatematicas PuertoGeneradorClaves FlujoCodificacionIDEA PuertoCodificacionIDEA} 
		end
	end

	{AlambrarComponentes}
	{GUI.init}

end