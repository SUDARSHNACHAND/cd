%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_IDENTIFIER_LENGTH 50

void addToSymbolTable(const char *);
%}

/* Disable default yywrap() warning */
%option noyywrap
%option yylineno
%%

[\t]+                  ;   /* Ignore tabs */
[ \n]+                 ;   /* Ignore spaces and newlines */
"//".*                 ;   /* Ignore single-line comments */
"/*"([^*]|\*+[^*/])*\*+"/" ; /* Ignore multi-line comments */

[0-9]+                 { printf("Constant: %s\n", yytext); }
"="                    { printf("%s is an Assignment Operator\n", yytext); }
"*"|"+"|"-"            { printf("%s is an Operator\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]* {
                            printf("Identifier: %s\n", yytext);
                            addToSymbolTable(yytext);
                        }

.                      { printf("Invalid token: %s\n", yytext); }

%%

typedef struct {
    char name[MAX_IDENTIFIER_LENGTH];
} Symbol;

Symbol symbol_table[100];
int symbol_count = 0;

void addToSymbolTable(const char *identifier) {
    if (symbol_count < 100) {
        strncpy(symbol_table[symbol_count].name, identifier, MAX_IDENTIFIER_LENGTH - 1);
        symbol_table[symbol_count].name[MAX_IDENTIFIER_LENGTH - 1] = '\0';
        symbol_count++;
        printf("Identifier %s is entered in the symbol table\n", identifier);
    } else {
        printf("Symbol table is full. Cannot add more identifiers.\n");
        exit(1);
    }
}

int main() {
    printf("Enter your expression:\n");
    yylex();
    return 0;
}
