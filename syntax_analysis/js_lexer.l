%{
#include "ast.h"
#include "js_parser.tab.h"
#include <string.h>
%}

%option noyywrap

%%
"function"             { return FUNCTION; }
"var"                  { return VAR; }
"if"                   { return IF; }
"else"                 { return ELSE; }
"return"               { return RETURN; }
[0-9]+                 { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z_0-9]* { yylval.str = strdup(yytext); return IDENTIFIER; }
"="                    { return ASSIGN; }
"+"                    { return PLUS; }
"-"                    { return MINUS; }
"*"                    { return MULTIPLY; }
"/"                    { return DIVIDE; }
"=="                   { return EQUALITY; }
"<"                    { return LESS_THAN; }
">"                    { return GREATER_THAN; }
"<="                   { return LESS_EQUAL; }
">="                   { return GREATER_EQUAL; }
"{"                    { return LBRACE; }
"}"                    { return RBRACE; }
"("                    { return LPAREN; }
")"                    { return RPAREN; }
";"                    { return SEMICOLON; }
[ \t\n\r]+             { /* Ignore whitespace */ }
.                      { printf("Unknown character: %s\n", yytext); }

%%
