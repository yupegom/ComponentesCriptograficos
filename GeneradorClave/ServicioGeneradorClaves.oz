functor
import
   ClaveRSA
   ClavePrivadaRSA
   ClavePublicaRSA
   GestorNumeros at 'file:../../GestorNumeros/GestorNumeros.ozf'
   ComponenteMatematico at 'file:../../ComponenteMatematico/ComponenteMatematico.ozf'
   OperacionesMatematicasService
   Browser
export servicioGeneradorClaves:ServicioGeneradorClaves
define 	 
   class ServicioGeneradorClaves

      attr operacionesService generadorNumsService
      meth init
	 operacionesService := {New OperacionesMatematicasService.servicioOperacionesMatematicas init}
	 generadorNumsService := {New GeneradorNumerosService.servicioGeneradorNumeros init}
      end

      meth generarClave(TipoClaveAGenerar ?Clave)
	 if TipoClaveAGenerar == 'RSA' then
	    Clave = {self GenerarClavesRSA($)}
	 else
	    {Browser.browse 'Not yet implemented'}
	 end
      end
      
      meth GenerarClavesRSA(?LlaveRSA)
	 ClavePrivada ClavePublica in
	 
	 ClavePrivada = {self GenerarClavePrivadaRSA($)}
	 ClavePublica = {self GenerarClavePublicaRSA({ClavePrivada getE($)} {ClavePrivada getPhiN($)} {ClavePrivada getN($)} $)}
	 LlaveRSA = {New ClaveRSA.claveRSA init(ClavePrivada ClavePublica)}
	 
      end

      meth GenerarClavePrivadaRSA(?LlavePrivadaRSA)
	 N E PhiN P = {NewCell 0} Q = {NewCell 0} PrimosRelativos = {NewCell false}
	 proc{Loop PrimosRelativos}
	    if @PrimosRelativos == false then
	       P := {self ObtenerPrimo($)}
	       Q := {self ObtenerPrimo($)}
	       PrimosRelativos := {@operacionesService verificarCoprimalidad(P Q $)}
	       {Loop PrimosRelativos}
	    end
	 
	 end
	 
      in
	 {Loop PrimosRelativos}
	 LlavePrivadaRSA = {New ClavePrivadaRSA.clavePrivadaRSA init}
	 N = @P * @Q
	 PhiN = {self ObtenerValorDePhi(@P @Q $)}
	 E = {self ObtenerValorDeE(PhiN $)}
	 {LlavePrivadaRSA setE(E)}
	 {LlavePrivadaRSA setN(N)}
	 {LlavePrivadaRSA setPhiN(PhiN)}
      end

      meth GenerarClavePublicaRSA(E PhiN N ?LlavePublicaRSA)
	 D  in
	 
	 LlavePublicaRSA = {New ClavePublicaRSA.clavePublicaRSA init}
	 D = {self ObtenerValorDeD(E PhiN $)}
	 {LlavePublicaRSA setD(D)}
	 {LlavePublicaRSA setN(N)}
      end

      meth ObtenerPrimo(?Primo)
	 Primo = {@generadorNumsService generarNumeroPrimo(100 $)}
      end

      meth ObtenerValorDeE(PhiN ?E)

	 PrimosRelativos
	 Eaux = {NewCell 0}
	 PuertoGeneradorNumeros = {GestorNumeros.gestorNumero _ $}
	 PuertoOpMatematicas = {ComponenteMatematico.interfazMatematicaAvanzada _ $}
      in

	 Eaux := {Send PuertoGeneradorNumeros generarAleatorioDentroDeRangoEspecifico(1 PhiN $)}
	 PrimosRelativos = {Send PuertoOpMatematicas verificarCoprimalidad(@Eaux PhiN $)}
	 if PrimosRelativos == true then
	    E = @Eaux
	 else
 	    %{Browser.browse 'No son primos relativos'}
	    {self ObtenerValorDeE(PhiN E)}
	 end
	 	 
      end

      meth ObtenerValorDePhi(P Q ?PhiN)

	 PhiN = (P - 1) * (Q - 1) 
	 
      end

      meth ObtenerValorDeD(E PhiN ?D)
	 PuertoOpMatematicas = {ComponenteMatematico.interfazMatematicaAvanzada _ $}
      in
	 
	 D = {Send PuertoOpMatematicas calcularInversaModular(E PhiN $)}
      end
      
             
   end
  
end