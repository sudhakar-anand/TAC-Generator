%{

%}
%%

"read"				{return READ;}
"print"				{return PRINT;}
"exit"		 		{return exit_command;}
[0-9]*[.]?[0-9]*    	 	{return NUM;}
"if"				{return IF;}
"then"				{return THEN;}
"else"				{return ELSE;}
"for"            		{return FOR;}
[a-z][_a-z0-9]*			{return ID;}
"<="         			{return LE;}
">="         			{return GE;}
"=="         			{return EQ;}
"!="          			{return NE;}
"++"				{return INC;}
"--"				{return DEC;}
[\/][\/]+.*[\n]			{;}//comment
[\t \n]				{;}
.                		{return yytext[0];}

%%


