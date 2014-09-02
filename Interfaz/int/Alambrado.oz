functor
import
   LibreriaCriptografica at 'file:../../LibreriaCriptografica/LibreriaCriptografica.ozf'
   GeneradorClave at 'file:../../GeneradorClave/GeneradorClave.ozf'

declare Flujo3 R2 F3 R3
thread {GeneradorClave.generadorClave Flujo3 R2} end
thread {LibreriaCriptografica.generarLlaves R2 F3 R3} end