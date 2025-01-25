# lab01- sumador 
## nombres
Juan Andrés Villanueva Garzon

## informe de laoratorio 
### sumador 1b 
```
module sum1bcc (A, B, Ci,Cout,S); // Se define el modulo
 //El modulo cuenta con 5 puertos
 // 3 entradas  
  input  A;
  input  B;
  input  Ci; //bit de carry in 
// 2 salidas 
  output Cout;//bit de carry out 
  output S;//bit de suma 

  reg [1:0] st;   // REGISTRO QEU GUARDA LA SUMA 
  assign S = st[0]; // asignación de salidas
  assign Cout = st[1]; 

  always @ ( * ) begin //Este bloque siempre se ejecuta cuando cualquiera de las entradas (A, B, Ci) cambia.
  	st  = 	A+B+Ci;
  end
  
endmodule
```

Este módulo Verilog implementa un sumador completo de un bit, donde las tres entradas (A, B y el acarreo de entrada Ci) se suman y el resultado se almacena en un registro de dos bits (st), cuyo bit menos significativo (st[0]) se asigna a la salida de suma S y cuyo bit más significativo (st[1]) se asigna al acarreo de salida Cout; al usar always @(*), cualquier cambio en A, B o Ci desencadena la actualización de st, y por lo tanto de S y Cout, lo que permite obtener en tiempo real el bit de suma y el bit de acarreo que resultan de la operación aritmética.

Simulación 




Sumador de 1 bit primitivo
```
module sum1bcc_primitive (A, B, Ci, Cout, S); 
// Módulo Verilog llamado "sum1bcc_primitive", que implementa un sumador completo de 1 bit (full adder) usando puertas lógicas primitivas.
// Entradas: A, B (bits a sumar), Ci (carry in o acarreo de entrada).
// Salidas: Cout (carry out o acarreo de salida) y S (resultado de la suma).

  input  A;   // Entrada A (primer bit a sumar).
  input  B;   // Entrada B (segundo bit a sumar).
  input  Ci;  // Entrada Ci (carry in o acarreo de entrada).
  output Cout; // Salida Cout (carry out o acarreo de salida).
  output S;   // Salida S (resultado de la suma).

  // Señales internas (wires) para realizar las operaciones intermedias.
  wire a_ab;    // Resultado de la operación AND entre A y B.
  wire x_ab;    // Resultado de la operación XOR entre A y B.
  wire cout_t;  // Resultado intermedio del carry (carry temporal).

  // Operación AND para calcular el acarreo generado directamente por A y B.
  and(a_ab, A, B); 
  // Esta puerta AND genera un bit '1' si tanto A como B son '1'. Representa el acarreo directo de A y B.

  // Operación XOR para calcular la suma parcial entre A y B.
  xor(x_ab, A, B); 
  // Esta puerta XOR calcula la suma entre A y B sin tener en cuenta el acarreo de entrada (Ci).

  // Operación XOR para calcular el bit de suma final (S) utilizando la suma parcial (x_ab) y el acarreo de entrada (Ci).
  xor(S, x_ab, Ci); 
  // La suma final incluye el bit de acarreo de entrada (Ci) para determinar el bit de salida (S).

  // Operación AND para calcular el acarreo temporal generado por la suma parcial (x_ab) y el acarreo de entrada (Ci).
  and(cout_t, x_ab, Ci); 
  // Este acarreo temporal se produce si la suma parcial entre A y B (x_ab) y el acarreo de entrada (Ci) son '1'.

  // Operación OR para calcular el acarreo de salida final (Cout).
  or(Cout, cout_t, a_ab); 
  // El acarreo de salida final (Cout) es el resultado de combinar el acarreo generado directamente por A y B (a_ab) 
  // y el acarreo temporal producido por la suma parcial y Ci (cout_t).

endmodule
```

Este código implementa un sumador completo de un bit (full adder) utilizando puertas lógicas primitivas (and, xor y or). Toma como entradas dos bits (A y B) y un bit de acarreo de entrada (Ci), y genera dos salidas: el bit de suma (S) y el acarreo de salida (Cout). Primero, calcula la suma parcial de A y B mediante una puerta XOR (x_ab) y el acarreo directo mediante una puerta AND (a_ab). Luego, la suma final (S) se obtiene combinando la suma parcial (x_ab) con el acarreo de entrada (Ci) mediante otra XOR. Por último, el acarreo de salida (Cout) se calcula como la combinación del acarreo generado por la suma parcial y Ci (cout_t) y el acarreo directo de A y B (a_ab) mediante una puerta OR. Este diseño permite obtener la suma y el acarreo de salida con lógica combinacional eficiente.

Simulación

En esta simulación, se observa el comportamiento de otro circuito digital, probablemente relacionado con la operación de un sumador completo. Las señales de entrada (A, B, y Ci) cambian a lo largo del tiempo, y las salidas (S, a_ab, cout_t, y x_ab) responden de acuerdo a la lógica esperada. La salida S representa la suma binaria de las entradas (A, B, y Ci), mientras que cout_t parece reflejar el acarreo de salida. Todas las señales cambian de manera sincronizada, sin glitches ni transiciones inesperadas, lo que muestra un funcionamiento estable del diseño. La simulación confirmar que el circuito responde correctamente a las combinaciones de entrada y que está implementado con una lógica consistente y confiable.


Analisis 

Ambos códigos implementan un sumador completo de un bit (full adder), pero lo hacen utilizando enfoques diferentes que reflejan distintos niveles de abstracción en el diseño.

El primer código (sum1bcc) utiliza operaciones aritméticas básicas de Verilog para realizar la suma de las entradas A, B y el acarreo de entrada Ci. En este diseño, un registro de 2 bits (reg [1:0] st) almacena el resultado completo de la suma, donde el bit menos significativo (st[0]) representa la salida de la suma S, y el bit más significativo (st[1]) corresponde al acarreo de salida Cout. La operación de suma se realiza en un bloque always @(*) que se ejecuta cada vez que cualquiera de las entradas cambia. Este enfoque es más abstracto y compacto, delegando el trabajo al simulador para que maneje la suma internamente. Sin embargo, debido a su nivel de abstracción, no refleja de manera explícita cómo se implementaría la lógica combinacional en hardware.

El segundo código (sum1bcc_primitive) se basa en el uso exclusivo de puertas lógicas primitivas (and, xor, or) para implementar la lógica de un sumador completo. Este diseño utiliza señales intermedias (wire) para realizar cálculos paso a paso: primero calcula la suma parcial de A y B con una XOR (x_ab), luego calcula el acarreo directo de A y B con una AND (a_ab), y el acarreo generado por la suma parcial y el acarreo de entrada (cout_t). Finalmente, las salidas S y Cout se determinan combinando estas señales intermedias con otras operaciones XOR y OR, respectivamente. Este enfoque es más detallado y representa exactamente cómo se implementaría el sumador en hardware, haciéndolo ideal para análisis lógico a nivel de puertas.

La principal diferencia entre ambos códigos radica en su nivel de abstracción. Mientras que el primer código es más sencillo y adecuado para simulaciones rápidas o diseño general, el segundo es más detallado y refleja fielmente el diseño lógico a nivel de hardware, lo que lo hace más útil para implementaciones específicas como en FPGAs o ASICs. El primer enfoque prioriza simplicidad y rapidez, mientras que el segundo proporciona un mayor control y precisión sobre la implementación de la lógica combinacional.





