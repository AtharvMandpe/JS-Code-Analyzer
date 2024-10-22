%{
#include "ast.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

ASTNode *root;

%}

%union {
    char *str;
    int num;
    ASTNode *node; 
}

%token FUNCTION VAR IF ELSE RETURN
%token <num> NUMBER
%token <str> IDENTIFIER
%token ASSIGN PLUS MINUS MULTIPLY DIVIDE
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON

%type <node> program function_def statement statement_list expression

%left PLUS MINUS
%left MULTIPLY DIVIDE

%%
program:
    function_def { root = $1; }
    | statement_list { root = $1; }
    ;

function_def:
    FUNCTION IDENTIFIER LPAREN RPAREN LBRACE statement_list RBRACE
    {
        $$ = new_node("Function", new_node($2, NULL, NULL), $6);
        free($2); 
        print_ast($$, 0);
    }
    ;

statement_list:
    statement { $$ = $1; }
    | statement_list statement
    {
        $$ = new_node("StatementList", $1, $2);
    }
    ;

statement:
    VAR IDENTIFIER ASSIGN expression SEMICOLON
    {
        $$ = new_node("VarDecl", new_node($2, NULL, NULL), $4);
        free($2);
    }
    | expression SEMICOLON { $$ = $1; }
    ;

expression:
    expression PLUS expression
    {
        $$ = new_node("Plus", $1, $3);
    }
    | expression MINUS expression
    {
        $$ = new_node("Minus", $1, $3);
    }
    | expression MULTIPLY expression
    {
        $$ = new_node("Multiply", $1, $3);
    }
    | expression DIVIDE expression
    {
        $$ = new_node("Divide", $1, $3);
    }
    | IDENTIFIER
    {
        $$ = new_node($1, NULL, NULL);
        free($1);
    }
    | NUMBER
    {
        char buffer[20];
        sprintf(buffer, "%d", $1);
        $$ = new_node(buffer, NULL, NULL);
    }
    ;

%%

ASTNode *new_node(char *name, ASTNode *left, ASTNode *right) {
    ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
    node->name = strdup(name);
    node->left = left;
    node->right = right;
    return node;
}

void print_ast(ASTNode *node, int depth) {
    if (node == NULL) return;
    for (int i = 0; i < depth; i++) printf("  ");
    printf("%s\n", node->name);
    print_ast(node->left, depth + 1);
    print_ast(node->right, depth + 1);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error opening file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    yyparse();
    return 0;
}
