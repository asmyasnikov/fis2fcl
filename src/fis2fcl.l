%{
/**
 * @brief  Scaner of fis-files
 * @author Myasnikov Aleksey Sergeevich
 * @date   20.05.2011
 **/
#include <stdio.h>
#include <math.h>

#define YYSTYPE int

extern YYSTYPE yylval;
%}

inumber					-?[0-9]+
fnumber					-?[0-9]+(\.([0-9]+)?)?(E[+-]?[0-9]+)?
word					[a-zA-Z0-9_]+
name					\'[^\']+\'
header					\[[a-zA-Z][a-z0-9]+\]

%%
{inumber}				/*yylval=atoi(yytext);*/ 	printf("INUMBER ");
{fnumber}				/*yylval=atof(yytext);*/ 	printf("FNUMBER ");
{header}				/*yylval=strdup(yytext);*/ 	printf("HEADER ");
{name}					printf("NAME ");
{word}					printf("WORD ");
\'					printf("\"\'\" ");
:					printf("\":\" ");
=					printf("\"=\" ");
,					printf("\",\" ");
\[					printf("\"[\" ");
\]					printf("\"]\" ");
\(					printf("\"(\" ");
\)					printf("\")\" ");
\n					printf("\n");
\{[\^{}}\n]*\}				/*Skip one-line comments*/;
[ \t]+					/*Skip whitespaces*/;
%%

main( int argc, const char * argv[])
{
	++argv, --argc;  /* skip over program name */
	if ( argc > 0 )
	{
		yyin = fopen( argv[0], "r" );
		if(yyin == NULL)
		{
			printf("ERROR: File %s not opened to read fis-structure\n", argv[0]);
			return 0;
		}
	}else{
		printf("Usage \"./fis2fcl input_file output_file\"\n");
		printf("   or \"./fis2fcl input_file\"\n");
		return 0;
	}
	++argv, --argc;  /* skip over input file */
	if ( argc > 0 )
	{
		yyout = fopen( argv[0], "w" );
		if(yyout == NULL)
		{
			printf("ERROR: File %s not opened to write fcl-structure\n", argv[0]);
			return 0;
		}
	}else{
		yyout = stdout;
	}
	yylex();
}

