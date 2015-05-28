/* \file expressions.geo
   \author Gustavo Peixoto de Oliveira
   \email gustavo.oliveira@uerj.br

   \description Sample file to give an overview of Gmsh's General Tools.

   \remark Script uses the built-in function 'Printf' to produce outputs. 
    	   Since Gmsh uses only 'float' and 'string' as types, use of flags
	   like below make no sense:  
	  
	   Printf("Value is: %d",c); // integer format - make no sense!
	   Printf("Value is: %i",c); // integer format - make no sense! 
	
	   Instead, use:
	   Printf("Value is: %f",c); // float - OK
	   Printf("Value is: %g",c); // short representation of float - OK 
*/

/* ————————————————————————————— Comments */

// this line is ignored

/* a block comment like 
this is also ignored */

/* ————————————————————————————— General expressions */

// floats 
a = 1; 		 
b = 2.0; 	 

// strings
c = "my_string"; 
d = "my_another_string"; 

// "index-notation"
x~{1}= 0.1;               // same as 'x_1 = 0.1' 

// lists
ls1 = {1,2.0,3,4.0};      // a list of floats
ls1z = #ls1[];            // size of list 'ls1' 
n1ls1 = ls1[0];           // [] extracts a entry of a list from 0.
n2ls1 = ls1[1];           // returns 2.0

// string comparison: 
e = "water";
f = "salt";
res = StrCmp(e,f);        // returns an integer {>,=,<} 0 if e {>,=,<} f 
//Printf("%g",StrCmp(e,f) ); 

// checking
exs = Exists(a);          // checks if the variable was defined: true!;  
exs = Exists(aa);         // false! 
fexs = FileExists("/home/foo.bar");
//Printf("%g",exs);       // returns 0:false; 1:true;
//Printf("%g",fexs); 

// gets a value through a pop-up window. Deactivated if General.NoPopup = 1
//gv = GetValue("Give me a number", 43.21); // standard-value = 43.21.

// concatenate strings
scf = StrCat("file","/file2");
//Printf(scf);

/* ————————————————————————————— Char expressions */

// Current date-time
tdy = Today;
//Printf(tdy);

// ignoring file extension
fn = StrPrefix("/zoo/foo.bar"); 
//Printf(fn);

// gets filename
ffn = StrRelative("/zoo/foo.bar"); 
//Printf(ffn);

// 
sstr = Str("alfa","beta","gamma","delta"); 
//Printf(sstr);

// evaluates expression, then, chooses option
sctr = StrChoice(1 > 2,"beta","gamma"); // returns 'gamma'
//Printf(sctr); 

// C-style Sprintf  
sprf = Sprintf("epsilon");
//Printf(sprf); 

sprf2 = Sprintf("value%g,%g",a,b);
//Printf(sprf2); 


// get specified environment variable
genv = GetEnv("HOME"); // in my case, /Users/gustavo
//Printf(genv); 

// output window
//get = GetString("Tell me", "this is it");

// replaces substring inside a string
strpl = StrReplace("find_us","us","yourself");
//Printf(strpl);


// —————————————————————————————

/* Checkings

// print list contents 
For i In {0:ls1z-1}
Printf("%f",ls1[i]); 
EndFor


// checks equality of "index-notation"
A = Exists(x_1);
Printf("%g",A);
If (x~{1} == x_1 && a == 1)
Printf("yes");
EndIf
*/

