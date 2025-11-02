%{
#include "y.tab.h"
#include <stdio.h>
%}

%%
"="                  { return '='; }
"+"                  { return '+'; }
"-"                  { return '-'; }
"*"                  { return '*'; }
"/"                  { return '/'; }
[a-zA-Z][a-zA-Z0-9]* { return ID; }
[ \t\n]+             ;       /* ignore whitespace */
.                    { return yytext[0]; }
%%

int yywrap(void) { return 1; }
