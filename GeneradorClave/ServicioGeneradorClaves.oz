functor
import
   Dictionary at 'x-oz://system/adt/Dictionary.ozf'
   ClaveRSA
   ClavePrivadaRSA
   ClavePublicaRSA
   ClaveIDEA
   OperacionesMatematicasService
   GeneradorNumerosService
   IntBitSupport at 'file:../../BitOperations/IntWithBitSupport.ozf'
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
	    	Clave = {self GenerarClaveIDEA($)}
	 		end
      	end

	    %Al finalizar Subclaves es un map que contiene cada una de las 51 claves
	    meth generarSubclavesParaCodificacion(Clave ?Subclaves)
	    IntWhitBitSupport in
	    	IntWhitBitSupport = {New IntBitSupport.intBitSupport init(128 Clave)}
	    	Subclaves = {GenKeys IntWhitBitSupport}
	    end

	    meth generarSubclavesParaDecodificacion(Clave ?SubclavesDec)
	    Subclaves in
	    	Subclaves = {self generarSubclavesParaCodificacion(Clave $)}
	    	SubclavesDec = {GenDecodificacionKeys Subclaves @operacionesService}
	    end

      %Métodos privados
 
    meth GenerarClavesRSA(?LlaveRSA)
		N E PhiN P = {NewCell 0} Q = {NewCell 0} PrimosRelativos = {NewCell false} D LlavePrivadaRSA LlavePublicaRSA
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
		 N = @P * @Q
		 PhiN = {self ObtenerValorDePhi(@P @Q $)}
		 E = {self ObtenerValorDeE(PhiN $)}
		 D = {self ObtenerValorDeD(E PhiN $)}
		 LlavePrivadaRSA = {New ClavePrivadaRSA.clavePrivadaRSA init(D N)}
		 LlavePublicaRSA = {New ClavePublicaRSA.clavePublicaRSA init(E N)}
		 LlaveRSA = {New ClaveRSA.claveRSA init(LlavePrivadaRSA LlavePublicaRSA)}
    end
      
    meth ObtenerPrimo(?Primo)
		Primo = {@generadorNumsService generarNumeroPrimo(50 $)}
    end
		
	meth GenerarClaveIDEA(?LlaveIDEA)
		AleatorioClave
	 	in
	 	AleatorioClave = {@generadorNumsService generarAleatorioDentroDeRango(10000000000000000000000000000000000000 100000000000000000000000000000000000000 $)}
	 	LlaveIDEA = {New ClaveIDEA.claveIDEA init( AleatorioClave )}
	end

    meth ObtenerValorDeE(PhiN ?E)
		PrimosRelativos	Eaux = {NewCell 0}
		in
		Eaux := {@operacionesService generarAleatorioDentroDeRango(1 PhiN $)}
		PrimosRelativos = {@operacionesService verificarCoprimalidad(@Eaux PhiN $)}
		if PrimosRelativos == true then
		   E = @Eaux
		else
		   {self ObtenerValorDeE(PhiN E)}
		end 
    end

    meth ObtenerValorDePhi(P Q ?PhiN)
		PhiN = (P - 1) * (Q - 1)
	end

    meth ObtenerValorDeD(E PhiN ?D)
		D = {@operacionesService calcularInversaModular(E PhiN $)}
    end
      
             
   end

   %Funciones auxiliares para obtener las subclaves para la codificación con IDEA

    %Obtiene a partir de un valor decimal, las subclaves para IDEA
    fun {GenKeys Value}
	   	D={Dictionary.new} in
	   	{GetKeys Value D}
	end

	%Agrupa las claves en valores de 16 bits
	fun{GetKeys Value D}
	    proc{Loop TextBlock} V
	    	Key = {List.length {D.keys}} in
		    if Key =< 51 then
			   if {List.length  TextBlock} > 0 then
			   	  {D.put Key {BitStringToInt 16 {List.reverse {List.take TextBlock 16}}}}
			      {Loop {List.drop TextBlock 16}}
			   else
			   	  V = {GetKeys {Value shift(25 $)} D}
			   end
			end

	    end in
	    {Loop {Value asBinaryString($)}}
	    D
	end	

	%Auxiliar para convertir un binario a decimal
	fun {BL2I Bin}
	      P = fun {$ X Y} Y + {Number.pow 2 X} end
	      in
	      {List.foldR Bin P 0}
	end

	%Convierte un string un decimal
	fun {BitStringToInt Length Bin}
	   IndexOfBin = {ToList Bin 0} in
	   {BL2I {BitString.toList {BitString.make Length IndexOfBin}}}
	end

	%Auxiliar para obtener los índices en los que un string de bits tiene un valor = 1 (Ascii = 49)
	fun{ToList List Indice}
	   
	   case List of H|T then
	      if H == 49 then  Indice | {ToList T Indice+1}
	      else {ToList T Indice+1}
	      end
	   [] nil then nil
	   end
	end

	%Función que toma las claves con las que se codificó un archivo y genera las claves para decodificar
	fun {GenDecodificacionKeys Subclaves Servicio}
		SubclavesDeco = {Dictionary.new}

		{SubclavesDeco.put 0 {Servicio inversaMultiplicativa({Subclaves.get 48} $)}}
		{SubclavesDeco.put 1 {Servicio inversaAditiva({Subclaves.get 49} $)}}
		{SubclavesDeco.put 2 {Servicio inversaAditiva({Subclaves.get 50} $)}}
		{SubclavesDeco.put 3 {Servicio inversaMultiplicativa({Subclaves.get 51} $)}}

		proc{Loop Ronda} R in
			if Ronda < 8 then
				{SubclavesDeco.put 4+(6*Ronda) {Subclaves.get 46-(6*Ronda)}}
				{SubclavesDeco.put 5+(6*Ronda) {Subclaves.get 47-(6*Ronda)}}
				{SubclavesDeco.put 6+(6*Ronda) {Servicio inversaMultiplicativa({Subclaves.get 42-(6*Ronda)} $)}}
				{SubclavesDeco.put 7+(6*Ronda) {Servicio inversaAditiva({Subclaves.get 43-(6*Ronda)} $)}}
				{SubclavesDeco.put 8+(6*Ronda) {Servicio inversaAditiva({Subclaves.get 44-(6*Ronda)} $)}}
				{SubclavesDeco.put 9+(6*Ronda) {Servicio inversaMultiplicativa({Subclaves.get 45-(6*Ronda)} $)}}
				{Loop Ronda+1}
			else
				R = SubclavesDeco
			end
		end in
		
		{Loop 0}
		SubclavesDeco
	end
  
end