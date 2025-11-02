%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%
[0-9]+"."[0-9]*     { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+              { yylval.ival = atoi(yytext); return INTEGER; }
[a-zA-Z]+           { yylval.sval = strdup(yytext); return CHAR; }
[ \t]+              ;       /* Ignore whitespace */
\n                  { return EOL; }
.                   { fprintf(stderr, "Error: Invalid character '%s'\n", yytext); }
%%

int yywrap(void) { return 1; }
