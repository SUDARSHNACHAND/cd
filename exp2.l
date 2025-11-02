%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
"="                     { printf("= is an Assignment operator "); }
"<="|">="|"<"|">"|"=="  { printf("%s is a relational operator ", yytext); }
.|\n                    { ECHO; }   /* Print all other characters normally */
%%

int main(int argc, char **argv)
{
    if(argc > 1)
    {
        FILE *file = fopen(argv[1], "r");
        if(!file)
        {
            printf("\nCould not open the file: %s", argv[1]);
            exit(1);
        }
        yyin = file;
    }

    yylex();
    printf("\n");
    return 0;
}
