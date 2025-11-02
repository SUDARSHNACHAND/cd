%{
#include <stdio.h>
#include <stdlib.h>
#include "ex4.tab.h"
%}

%%
[0-9]+          { yylval = atoi(yytext); return NUM; }
[\t ]+          ;               /* Ignore whitespace */
\n              { return EOL; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"("             { return '('; }
")"             { return ')'; }
.               { fprintf(stderr, "Error: Invalid character '%s'\n", yytext); }
%%

int yywrap(void) { return 1; }
