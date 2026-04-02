%{

// Group members: Caleb McCoy and Avery Hauser
// File: tree.l
// Purpose: 



// ISSUES TO FIX:
// Buildnode sometimes coutning as a variable (Line 6 of input)
// Return symbols themselves instead of ASCII values

// Need to add a Makefile
// Add newline character to whitespace catch when done


#define TKBUILD 1
#define TKNAME 2 
#define TKWEIGHT 3
#define TKSTR 4
#define TKDIGT 5
#define TKCHILD 6
#define TKFOR 7
#define TKLOOPVAR 8
#define TKIN 9
#define TKRANGE 10
#define TKPRINT 11
#define TKVAR 12



#define TKUNMATCHED 255

%}

D[0-9]
C[a-zA-Z]			
O[!=/<>*%-]

%%


"buildnode"                                           {return TKBUILD;}
"name"                                                {return TKNAME;}
"weight"                                              {return TKWEIGHT;}
\".*\"		                                          {return TKSTR;}
{D}*                                                  {return TKDIGT;}
"isachildof"                                          {return TKCHILD;}
"for"(" "|\n|\t|\r|\f)+                               {return TKFOR;}
"in"(" "|\n|\t|\r|\f)+                                {return TKIN;}
{D}*({C}|"_")+({C}|{D}|"_")*(" "|\n|\t|\r|\f)+        {return TKLOOPVAR;}
"["{D}*":"{D}*"]"                                     {return TKRANGE;}
"print"                                               {return TKPRINT;}
{D}*({C}|"_")+({C}|{D}|"_")*                          {return TKVAR;}



"="                                                   {return '=';}
"+"                                                   {return '+';}
";"                                                   {return ';';} 
"{"                                                   {return '{';}
"}"                                                   {return '}';} 
","                                                   {return ',';} 
"("                                                   {return '(';}
")"                                                   {return ')';} 


(" "|\t|\r|\f)+            ; 
.                                                     {return TKUNMATCHED;}


%%

int yywrap(){
	return true;
}

int main()
{
	yyout = fopen("output.txt", "w"); 
    if (!yyout) 
	{
		return 1;
	}

	int token = 0;
	token = yylex();

	while(token)
	{
		fprintf(yyout, "%d ", token);		
		token = yylex();
	}

    fclose(yyout);
    return 0;
}
