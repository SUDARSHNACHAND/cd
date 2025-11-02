%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_IDENTIFIER_LENGTH 50
void addtosymboltable(const char*);
%}

%option noyywrap
%option yylineno

%%
[ \t]                ;                       /* ignore spaces/tabs  */
\n                   ;                       /* ignore new lines    */
"/*"([^*]|\*+[^*/])*\*+"/"   ;               /* ignore comments     */
[0-9]+               { printf("Constant: %s\n", yytext); }
"="                  { printf("%s is an Assignment Operator\n", yytext); }
"*"|"+"|"-"          { printf("%s is an Operator\n", yytext); }
[a-zA-Z][a-zA-Z0-9]* { printf("Identifier: %s\n", yytext); addtosymboltable(yytext); }
.                    { printf("Invalid token: %s\n", yytext); }
%%

typedef struct {
    char name[MAX_IDENTIFIER_LENGTH];
} Symbol;

Symbol symbol_table[100];
int symbol_count = 0;

void addtosymboltable(const char *identifier) {
    if (symbol_count < 100) {
        strncpy(symbol_table[symbol_count].name, identifier, MAX_IDENTIFIER_LENGTH - 1);
        symbol_table[symbol_count].name[MAX_IDENTIFIER_LENGTH - 1] = '\0';
        symbol_count++;
        printf("Identifier %s entered into symbol table\n", identifier);
    } else {
        printf("Symbol table full. Cannot add more identifiers.\n");
        exit(1);
    }
}

int main(void) {
    printf("Enter C code below (Ctrl+D to stop):\n\n");
    yylex();
    return 0;
}
