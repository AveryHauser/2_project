// File: tree.l
// Purpose: break down contents of C & C++ files to unique tokens.
// This is in preporation for static analyzing of our tree program.

// declarations

#define TKBUILD 1
#define TKNAME 2 
#define TKWEIGHT 3

D[0-9]
C[a-zA-Z]			
O[!=/<>*%-]