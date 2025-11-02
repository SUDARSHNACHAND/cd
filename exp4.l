%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
[0-9]+          { yylval = atoi(yytext); return NUM; }
[\t ]+          ;             /* ignore whitespace */
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
