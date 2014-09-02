functor
import
   Dictionary at 'x-oz://system/adt/Dictionary.ozf'
   ClaveRSA
   ClavePrivadaRSA
   ClavePublicaRSA
   ClaveIDEA
   GestorNumeros at 'file:../../GestorNumeros/GestorNumeros.ozf'
   ComponenteMatematico at 'file:../../ComponenteMatematico/ComponenteMatematico.ozf'
   OperacionesMatematicasService
   GeneradorNumerosService
   IntBitSupport at 'file:../../BitOperations/IntWithBitSupport.ozf'
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

   %Funciones auxiliares para obtener las subclaves para la codificación con IDEA

   %Obtiene a partir de un valor decimal, las subclaves para IDEA
	fun {GenKeys Value}
	   D={Dictionary.new} Key in
	      {GetKeys Value D}
	   
	end

	%Agrupa las claves en valores de 16 bits
	fun{GetKeys Value D}
	    
	    proc{Loop TextBlock}
	    	Temp Key = {List.length {D.keys}} in
		    if Key =< 51 then
			   if {List.length  TextBlock} > 0 then
			   	  {D.put Key {BitStringToInt {List.reverse {List.take TextBlock 16}}}}
			      {Loop {List.drop TextBlock 16}}
			   else
			   {Loop {{Value shift(16 $)} asBinaryString($)}}
			   end
			end

	    end in
	    {Loop {AddRightZeros {Value asBinaryString($)} 128} } D
	end	

	%Auxiliar para convertir un binario a decimal
	fun {BL2I Bin}
	      P = fun {$ X Y} Y + {Number.pow 2 X} end
	      in
	      {List.foldR Bin P 0}
	end

	%Convierte un string un decimal
	fun {BitStringToInt Bin}
	   IndexOfBin = {ToList Bin 0} in
	   {BL2I {BitString.toList {BitString.make 16 IndexOfBin}}}
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
		SubclavesDeco = {Dictionary.new} in
		
		{SubclavesDeco.put 0 {Servicio inversaMultiplicativa({Subclaves.get 48} $)}}
		{SubclavesDeco.put 1 {Servicio inversaAditiva({Subclaves.get 49} $)}}
		{SubclavesDeco.put 2 {Servicio inversaAditiva({Subclaves.get 50} $)}}
		{SubclavesDeco.put 3 {Servicio inversaMultiplicativa({Subclaves.get 51} $)}}
		{SubclavesDeco.put 4 {Subclaves.get 46}}
		{SubclavesDeco.put 5 {Subclaves.get 47}}

		{SubclavesDeco.put 6 {Servicio inversaMultiplicativa({Subclaves.get 42} $)}}
		{SubclavesDeco.put 7 {Servicio inversaAditiva({Subclaves.get 44} $)}}
		{SubclavesDeco.put 8 {Servicio inversaAditiva({Subclaves.get 43} $)}}
		{SubclavesDeco.put 9 {Servicio inversaMultiplicativa({Subclaves.get 45} $)}}
		{SubclavesDeco.put 10 {Subclaves.get 40}}
		{SubclavesDeco.put 11 {Subclaves.get 41}}

		{SubclavesDeco.put 12 {Servicio inversaMultiplicativa({Subclaves.get 36} $)}}
		{SubclavesDeco.put 13 {Servicio inversaAditiva({Subclaves.get 38} $)}}
		{SubclavesDeco.put 14 {Servicio inversaAditiva({Subclaves.get 37} $)}}
		{SubclavesDeco.put 15 {Servicio inversaMultiplicativa({Subclaves.get 39} $)}}
		{SubclavesDeco.put 16 {Subclaves.get 34}}
		{SubclavesDeco.put 17 {Subclaves.get 35}}

		{SubclavesDeco.put 18 {Servicio inversaMultiplicativa({Subclaves.get 30} $)}}
		{SubclavesDeco.put 19 {Servicio inversaAditiva({Subclaves.get 32} $)}}
		{SubclavesDeco.put 20 {Servicio inversaAditiva({Subclaves.get 31} $)}}
		{SubclavesDeco.put 21 {Servicio inversaMultiplicativa({Subclaves.get 33} $)}}
		{SubclavesDeco.put 22 {Subclaves.get 28}}
		{SubclavesDeco.put 23 {Subclaves.get 29}}

		{SubclavesDeco.put 24 {Servicio inversaMultiplicativa({Subclaves.get 24} $)}}
		{SubclavesDeco.put 25 {Servicio inversaAditiva({Subclaves.get 26} $)}}
		{SubclavesDeco.put 26 {Servicio inversaAditiva({Subclaves.get 25} $)}}
		{SubclavesDeco.put 27 {Servicio inversaMultiplicativa({Subclaves.get 27} $)}}
		{SubclavesDeco.put 28 {Subclaves.get 22}}
		{SubclavesDeco.put 29 {Subclaves.get 23}}

		{SubclavesDeco.put 30 {Servicio inversaMultiplicativa({Subclaves.get 18} $)}}
		{SubclavesDeco.put 31 {Servicio inversaAditiva({Subclaves.get 20} $)}}
		{SubclavesDeco.put 32 {Servicio inversaAditiva({Subclaves.get 19} $)}}
		{SubclavesDeco.put 33 {Servicio inversaMultiplicativa({Subclaves.get 21} $)}}
		{SubclavesDeco.put 34 {Subclaves.get 16}}
		{SubclavesDeco.put 35 {Subclaves.get 17}}

		{SubclavesDeco.put 36 {Servicio inversaMultiplicativa({Subclaves.get 12} $)}}
		{SubclavesDeco.put 37 {Servicio inversaAditiva({Subclaves.get 14} $)}}
		{SubclavesDeco.put 38 {Servicio inversaAditiva({Subclaves.get 13} $)}}
		{SubclavesDeco.put 39 {Servicio inversaMultiplicativa({Subclaves.get 15} $)}}
		{SubclavesDeco.put 40 {Subclaves.get 10}}
		{SubclavesDeco.put 41 {Subclaves.get 11}}

		{SubclavesDeco.put 42 {Servicio inversaMultiplicativa({Subclaves.get 6} $)}}
		{SubclavesDeco.put 43 {Servicio inversaAditiva({Subclaves.get 8} $)}}
		{SubclavesDeco.put 44 {Servicio inversaAditiva({Subclaves.get 7} $)}}
		{SubclavesDeco.put 45 {Servicio inversaMultiplicativa({Subclaves.get 9} $)}}
		{SubclavesDeco.put 46 {Subclaves.get 4}}
		{SubclavesDeco.put 47 {Subclaves.get 5}}

		{SubclavesDeco.put 48 {Servicio inversaMultiplicativa({Subclaves.get 0} $)}}
		{SubclavesDeco.put 49 {Servicio inversaAditiva({Subclaves.get 1} $)}}
		{SubclavesDeco.put 50 {Servicio inversaAditiva({Subclaves.get 2} $)}}
		{SubclavesDeco.put 51 {Servicio inversaMultiplicativa({Subclaves.get 3} $)}}

		{Browser.browse 'Se generaron las sublcaves'}
		{Browser.browse {SubclavesDeco.keys}}
		
		SubclavesDeco
	end

%Quitar esto de acá!!
	fun {AddRightZeros Bloque TamanoBloque}
      if {List.length Bloque} < TamanoBloque then
         {AddRightZeros {Append Bloque "0"} TamanoBloque}
      else
         Bloque
      end
      
   end
  
end