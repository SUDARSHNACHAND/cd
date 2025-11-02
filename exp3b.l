%{
#include "y.tab.h"
#include <stdio.h>
%}

%%
"int"           { return INT; }
"float"         { return FLOAT; }
"double"        { return DOUBLE; }
[a-zA-Z][a-zA-Z0-9]*   { return ID; }
[ \t\n]+        ;
.               { return yytext[0]; }
%%

int yywrap(void) { return 1; }
