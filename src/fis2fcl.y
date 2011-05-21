%{
#include <stdio.h>
#include <string.h>

void yyerror(const char* err)
{
    fprintf(stderr,"ERROR: %s\n", err);
}

int yywrap()
{
    return 1;
}

int main()
{
    yyparse();
}
%}

%token TOKEN

%%

rule : /* пусто */

%%
