%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%% 

if            { printf("IF keyword\n"); }
else          { printf("ELSE keyword\n"); }
switch        { printf("SWITCH keyword\n"); }
case          { printf("CASE keyword\n"); }
default       { printf("DEFAULT keyword\n"); }

for           { printf("FOR keyword\n"); }
while         { printf("WHILE keyword\n"); }
do            { printf("DO keyword\n"); }

var           { printf("VAR keyword\n"); }
let           { printf("LET keyword\n"); }
const         { printf("CONST keyword\n"); }

console       { printf("CONSOLE keyword\n"); }
log           { printf("LOG keyword\n"); }

[a-zA-Z_][a-zA-Z0-9_]*    { printf("IDENTIFIER: %s\n", yytext); }

"+"           { printf("PLUS operator\n"); }
"-"           { printf("MINUS operator\n"); }
"="           { printf("ASSIGN operator\n"); }
"=="          { printf("EQUALITY operator\n"); }
"<"           { printf("LESS THAN operator\n"); }
">"           { printf("GREATER THAN operator\n"); }

[0-9]+       { printf("NUMBER: %s\n", yytext); }

"("          { printf("LEFT PAREN\n"); }
")"          { printf("RIGHT PAREN\n"); }
"{"          { printf("LEFT BRACE\n"); }
"}"          { printf("RIGHT BRACE\n"); }

";"           { printf("SEMICOLON\n"); }
"."           { printf("DOT\n"); }
\"[^"]*\"    { printf("STRING: %s\n", yytext); }

[ \t\n]+

.            { printf("UNKNOWN: %s\n", yytext); }

%% 

int main(int argc, char **argv) {
    yylex();
    return 0;
}
