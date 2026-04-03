%{

// Group members: Caleb McCoy and Avery Hauser
// File: tree.l
// Purpose: Tokenize tree language ints, string, key words and pass them through to our static analyzer.
// This is in preporation for static analyzing of our tree program using BISON.
// We print out any symobles since there is no need to tokenize.

// declarations

#define TKBUILD 1
#define TKNAME 2 
#define TKWEIGHT 3
#define TKSTR 4
#define TKDIGT 5
#define TKCHILD 6
#define TKFOR 7
#define TKVAR 8
#define TKIN 9

#define TKPRINT 10

#define TKSYM 11

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
\".*\"		                                          {yylval = strdup(yytext); return TKSTR;}
{D}+                                                  {yylval = strdup(yytext); return TKDIGT;}
"isachildof"(" "|\t|\r|\f)*                           {return TKCHILD;}
"for"(" "|\n|\t|\r|\f)+                               {return TKFOR;}
"in"(" "|\n|\t|\r|\f)+                                {return TKIN;}
"print"                                               {return TKPRINT;}
({C}|"_")+({C}|{D}|"_")*                              {yylval = strdup(yytext); return TKVAR;}

("="|"+"|";"|"{"|"}"|","|"("|")"|":"|"["|"]")         { yylval = strdup(yytext); return TKSYM; }
(" "|\n|\t|\r|\f)+                                       ; 
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
	{   if (token == TKSYM)
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