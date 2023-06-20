%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"

int charPos=1;

int yywrap(void) {
    charPos=1;
    return 1;
}


void adjust(void) {
    EM_tokPos=charPos;
    charPos+=yyleng;
}

%}

%%
" "	                    {adjust(); continue;}
"\n"	                {adjust(); EM_newline(); continue;}
"."	                    {adjust(); EM_error(EM_tokPos,"illegal token");}
","                     {adjust(); printf("逗号\n"); return COMMA;}
":"                     {adjust(); printf("冒号\n"); return COLON;}
";"                     {adjust(); printf("分号\n"); return SEMICOLON;}
"("                     {adjust(); printf("左括号\n"); return LPAREN;}
")"                     {adjust(); printf("右括号\n"); return RPAREN;}
"["                     {adjust(); printf("左中括号\n"); return LBRACK;}
"]"                     {adjust(); printf("右中括号\n"); return RBRACK;}
"{"                     {adjust(); printf("左大括号\n"); return LBRACE;}
"}"                     {adjust(); printf("右大括号\n"); return RBRACE;}
"."                     {adjust(); printf("点号\n"); return DOT;}
"+"                     {adjust(); printf("加号\n"); return PLUS;}
"-"                     {adjust(); printf("减号\n"); return MINUS;}
"*"                     {adjust(); printf("乘号\n"); return TIMES;}
"/"                     {adjust(); printf("除号\n"); return DIVIDE;}
"=="                    {adjust(); printf("相等判断\n"); return EQ;}
"!="                    {adjust(); printf("不相等\n"); return NEQ;}
"<"                     {adjust(); printf("小于判断\n"); return LT;}
"<="                    {adjust(); printf("小于等于判断\n"); return LE;}
">"                     {adjust(); printf("大于\n"); return GT;}
">="                    {adjust(); printf("大于等于\n"); return GE;}
"&"                     {adjust(); printf("并且\n"); return AND;}
"|"                     {adjust(); printf("或者\n"); return OR;}
":="                    {adjust(); printf("赋值\n"); return ASSIGN;}
"if"                    {adjust(); printf("IF\n"); return IF;}
"then"                  {adjust(); printf("THEN\n"); return THEN;}
"else"                  {adjust(); printf("ELSE\n"); return ELSE;}
"while"                 {adjust(); printf("WHILE\n"); return WHILE;}
"for"                   {adjust(); printf("FOR\n"); return FOR;}
"to"                    {adjust(); printf("TO\n"); return TO;}
"do"                    {adjust(); printf("DO\n"); return DO;}
"let"                   {adjust(); printf("LET\n"); return LET;}
"in"                    {adjust(); printf("IN\n"); return IN;}
"end"                   {adjust(); printf("END\n"); return END;}
"of"                    {adjust(); printf("OF\n"); return OF;}
"break"                 {adjust(); printf("BREAK\n"); return BREAK;}
"nil"                   {adjust(); printf("NIL\n"); return NIL;}
"function"              {adjust(); printf("FUNCTION\n"); return FUNCTION;}
"var"                   {adjust(); printf("VAR\n"); return VAR;}
"type"                  {adjust(); printf("TPYE\n"); return TYPE;}
"array"                 {adjust(); printf("ARRAY\n"); return ARRAY;}
\"(\\.|[^"\\])*\"       {adjust(); printf("字符串 %s\n", yytext); yylval.sval = yytext; return STRING;}
[0-9]+	                {adjust(); printf("整数 %s \n", yytext); yylval.ival=atoi(yytext); return INT;}
[a-zA-Z_][a-zA-Z_0-9]*  {adjust(); printf("标识符  %s \n", yytext); return ID;}
^\/\/((\\\n)|[^\n])*    {adjust(); printf("单行注释或者多行注释// \n"); continue;}
^\/\*(.*)\*\/           {adjust(); printf("块注释/**/\n"); continue;}
