%{

// Group members: Caleb McCoy and Avery Hauser
// File: tree.l
// Purpose: break down contents of C & C++ files to unique tokens.
// This is in preporation for static analyzing of our tree program.




// ISSUES TO FIX:
// Currently keeps newlines in ouput for readability, add newline character to whitespace catch when done



// declarations

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
#define TKSYM 13



#define TKUNMATCHED 255

char *yylval;

%}

D[0-9]
C[a-zA-Z]			
O[!=/<>*%-]

%%


"buildnode"(" "|\t|\r|\f)*                            {return TKBUILD;}
"name"(" "|\t|\r|\f)*                                 {return TKNAME;}
"weight"(" "|\t|\r|\f)*                               {return TKWEIGHT;}
\".*\"		                                          {return TKSTR;}
{D}*                                                  {return TKDIGT;}
"isachildof"(" "|\t|\r|\f)*                           {return TKCHILD;}
"for"(" "|\n|\t|\r|\f)+                               {return TKFOR;}
"in"(" "|\n|\t|\r|\f)+                                {return TKIN;}
({C}|"_")+({C}|{D}|"_")*(" "|\n|\t|\r|\f)+            {return TKLOOPVAR;}
"["{D}*":"{D}*"]"                                     {return TKRANGE;}
"print"                                               {return TKPRINT;}
({C}|"_")+({C}|{D}|"_")*                              {return TKVAR;}

("="|"+"|";"|"{"|"}"|","|"("|")")                     { yylval = strdup(yytext); return TKSYM; }
(" "|\t|\r|\f)+                                       ; 
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
        if (token == TKSYM)
        {
            fprintf(yyout, "%s ", yylval);
        }
        else
        {
            fprintf(yyout, "%d ", token);	
        }	

		token = yylex();
	}

    fclose(yyout);
    return 0;
}
