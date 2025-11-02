#include <stdio.h>
#include <string.h>

int main() {
    char icode[10][30], str[30], opr[10];
    int i = 0;

    printf("Enter the set of intermediate code (terminated by 'exit'):\n");
    do {
        scanf("%s", icode[i]);
    } while (strcmp(icode[i++], "exit") != 0);

    printf("\nTarget Code Generation\n");
    printf("************************\n");

    i = 0;
    while (strcmp(icode[i], "exit") != 0) {
        strcpy(str, icode[i]);

     
        switch (str[3]) {
            case '+': strcpy(opr, "ADD"); break;
            case '-': strcpy(opr, "SUB"); break;
            case '*': strcpy(opr, "MUL"); break;
            case '/': strcpy(opr, "DIV"); break;
            default:  strcpy(opr, "");    break;
        }

       
        printf("MOV %c, R%d\n", str[2], i);
        printf("%s %c, R%d\n", opr, str[4], i);
        printf("MOV R%d, %c\n", i, str[0]);
        i++;
    }

    return 0;
}
