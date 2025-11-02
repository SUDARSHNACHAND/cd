%{
#include "y.tab.h"
#include <stdio.h>
%}

%%
"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"for"       { return FOR; }
"switch"    { return SWITCH; }
"case"      { return CASE; }
"default"   { return DEFAULT; }
"break"     { return BREAK; }
"("         { return OPEN_BRACKET; }
")"         { return CLOSE_BRACKET; }
"{"         { return OPEN_BRACE; }
"}"         { return CLOSE_BRACE; }
";"         { return SEMICOLON; }
":"         { return COLON; }
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[ \t\n]+     ;
.            { return yytext[0]; }
%%

int yywrap(void) { return 1; }
