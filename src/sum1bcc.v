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

