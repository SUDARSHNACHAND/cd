#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAXLINE 256


static void trim(char *s) {
    char *p = s;
    size_t len;
    while (isspace((unsigned char)*p)) p++;
    if (p != s) memmove(s, p, strlen(p) + 1);
    len = strlen(s);
    while (len > 0 && isspace((unsigned char)s[len-1])) s[--len] = '\0';
}


static void chomp(char *s) {
    size_t n = strlen(s);
    if (n > 0 && s[n-1] == '\n') s[n-1] = '\0';
}


static int is_exit(const char *s) {
    if (!s) return 0;
    while (isspace((unsigned char)*s)) s++;
    return (strcasecmp(s, "exit") == 0);
}


int main(void) {
    char line[MAXLINE];

    printf("Enter intermediate code lines (type 'exit' to finish).\n");
    printf("Examples:\n  a = b + c\n  t1 = 10\n  result = t1 * x\n\n");

    while (1) {
        if (!fgets(line, sizeof(line), stdin)) break; /
        chomp(line);
        trim(line);
        if (line[0] == '\0') continue;
        if (is_exit(line)) break;

       
        char dest[64] = {0}, rhs[192] = {0};
       
        char *eq = strchr(line, '=');
        if (!eq) {
            fprintf(stderr, "Ignored (no '=' found): %s\n", line);
            continue;
        }
      
        size_t left_len = eq - line;
        if (left_len >= sizeof(dest)) left_len = sizeof(dest) - 1;
        strncpy(dest, line, left_len);
        dest[left_len] = '\0';
        trim(dest);
        strncpy(rhs, eq + 1, sizeof(rhs) - 1);
        trim(rhs);

        char op = 0;
        char op1[64] = {0}, op2[64] = {0};
        
        int found = 0;
        for (size_t i = 0; i < strlen(rhs); ++i) {
            if (rhs[i] == '+' || rhs[i] == '-' || rhs[i] == '*' || rhs[i] == '/') {
                op = rhs[i];
               
                strncpy(op1, rhs, i);
                op1[i] = '\0';
                strncpy(op2, rhs + i + 1, sizeof(op2) - 1);
                trim(op1); trim(op2);
                found = 1;
                break;
            }
        }

        if (!found) {
       
            trim(rhs);
            if (rhs[0] == '\0') {
                fprintf(stderr, "Ignored empty RHS in line: %s\n", line);
                continue;
            }
            printf("; %s  => simple assignment\n", line);
            printf("    MOV %s, %s\n\n", dest, rhs);
            continue;
        }

        
        printf("; %s\n", line);
        switch (op) {
            case '+':
                
                printf("    MOV %s, %s\n", dest, op1);
                printf("    ADD %s, %s\n\n", dest, op2);
                break;
            case '-':
                printf("    MOV %s, %s\n", dest, op1);
                printf("    SUB %s, %s\n\n", dest, op2);
                break;
            case '*':
              
                printf("    ; multiply: using AX, result in AX (simplified)\n");
                printf("    MOV AX, %s\n", op1);
                printf("    MUL %s\n", op2);
                printf("    MOV %s, AX\n\n", dest);
                break;
            case '/':
               
                printf("    ; divide: using AX, result in AX (simplified)\n");
                printf("    MOV AX, %s\n", op1);
                printf("    CWD\n");
                printf("    DIV %s\n", op2);
                printf("    MOV %s, AX\n\n", dest);
                break;
            default:
                fprintf(stderr, "Unhandled operator '%c'\n\n", op);
        }
    }

    printf("\n; Code generation finished.\n");
    return 0;
}
