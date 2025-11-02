%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
"="              { printf("\n%s is an Assignment operator", yytext); }
"<="|">="|"<"|">"|"=="  { printf("\n%s is a Relational operator", yytext); }
"+"|"-"|"*"|"/"          { printf("\n%s is an Arithmetic operator", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*   { printf("\nIdentifier: %s", yytext); }
[0-9]+                   { printf("\nConstant: %s", yytext); }
[ \t\n]+                 ;  /* Ignore spaces and newlines */
.                        { printf("\nUnknown symbol: %s", yytext); }
%%

int main(int argc, char **argv) {
    FILE *file;
    if (argc > 1) {
        file = fopen(argv[1], "r");
        if (!file) {
            printf("Cannot open file: %s\n", argv[1]);
            exit(1);
        }
        yyin = file;
    }
    printf("Analyzing tokens...\n");
    yylex();
    printf("\n\nLexical analysis complete.\n");
    return 0;
}
