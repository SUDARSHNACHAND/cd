%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"%"         { return MOD; }
"("         { return OPEN; }
")"         { return CLOSE; }
[\t ]+      ;
\n          { return '\n'; }
.           { return yytext[0]; }
%%

int yywrap(void) { return 1; }
