%{
#include <stdio.h>
#include <stdlib.h>
int flag=0;	//to check infinite loop
int if_scope=-1;
int for_scope=-1;
%}

%union {double num; char* id;}        
%start line
%token PRINT
%token READ
%token FOR
%token IF
%token ELSE
%token THEN
%token LE
%token GE
%token EQ
%token NE
%token INC
%token DEC
%token exit_command
%token <num> NUM
%token <id> ID
%type <num> line exp


%right '=' 
%left  GE LE NE EQ '<' '>'
%left  '+' '-'
%left  '*' '/' '%' 
%left  '!'


%%

line    : line exp ';' 					{;}
         | line if_then_else 				{;}
         | line for_loop 				{;}
         | line exit_command ';' 			{end_code();exit(EXIT_SUCCESS);}
         | exit_command ';' 				{end_code();exit(EXIT_SUCCESS);}
         | exp ';'					{;}
         | for_loop					{;}
         | if_then_else					{;}
         | line read_var ';'  				{;}
         | read_var ';' 				{;}
         | line print_var ';' 				{;}
         | print_var ';'     				{;}
	 ;

exp      : identifier						 
	   '=' 						{push();} 
	   exp						{assign_code();}
	 | exp 						{push();}
	   INC						{incr();}
	 | exp 						{push();}
	   DEC						{decr();}
         | exp '+'					{push();} 
	   exp						{exp_code();}
         | exp '-'					{push();} 
	   exp						{exp_code();}
         | exp '*'					{push();} 
	   exp						{exp_code();}
         | exp '/'					{push();} 
	   exp						{exp_code();}
	 | exp '>'					{push();} 
	   exp						{assign_code();}
         | exp '<'					{push();} 
	   exp						{assign_code();}
         | exp LE 					{push();} 
	   exp						{assign_code();}
         | exp GE 					{push();}
	   exp						{assign_code();}
	 | exp NE 					{push();} 
	   exp						{assign_code();}
         | exp EQ 					{push();} 	
	   exp						{assign_code();}
         | '(' exp ')'					{;}
         | identifier					{;}
         | NUM						{push();}
         | 						{flag=1;}
         ;

identifier: ID						{push();}

if_then_else  : IF '(' exp ')'				{if_1();} 
		THEN '{'line'}'  			{if_2();}
		ELSE '{'line'}' 			{if_3();}
        ;


for_loop      : FOR '(' exp ';'				{initialisation();} 
		exp 					{cond_check();}';' 
		exp 					{increment();}
		')' '{'line'}' 				{execution();}
        ;

print_var     : PRINT ID 				{printing();}
        | 	PRINT NUM 				{printing_num();}
        ;

read_var      : READ ID 			 	{reading();}

        ;



%%       


#include <ctype.h>
#include <string.h>
#include "lex.yy.c"

char Token[100][10];	//token stack
int label[20];		//for loop label stack
int top=0;		
char temp_no=0;		//temp var no
char temp_var='t';	//temp var t

int if_label[20];	//if cond label stack
int if_num=-1;		//current if label no
int if_top=0;

typedef struct var_list
{
    char name[10];
    struct var_list* next;
}var_list;

var_list* head = NULL;

int label_count=0;
int for_num=-1;
int local_count=0;
              

void main()
{
    head=NULL;
    printf("#include<stdio.h>\n");
    printf("#include<stdlib.h>\n");
    printf("int main(){\n");
    yyparse();
}

void incr()
{
	char var_name[20];
	strcpy(var_name,Token[top-1]);
 	printf("%s=%s+1;\n",var_name,var_name); 
	top=top-2;
}

void decr()
{
	char var_name[20];
	strcpy(var_name,Token[top-1]);
 	printf("%s=%s-1;\n",var_name,var_name); 
	top=top-2;
}


void reading()
{
    char var_name[20];
    char var_type[20];
    strcpy(var_type,"%f");
    strcpy(var_name,yytext);
    int found=0;
    var_list *ptr=head;

    //finding variable in var_list
    while(ptr!=NULL && found==0)
    {
            if(strcmp(ptr->name,var_name)==0)
            {
                found=1;
            }
	    else
	    {
                ptr=ptr->next;
	    }
           
    }
  
    //if variable is not found then new variable node is created
    if (found==0)
    {
        printf("float %s;\n",var_name);
        var_list* newnode=(struct var_list*)malloc(sizeof(struct var_list));
        strcpy(newnode->name,var_name);
        newnode->next=head;
        head=newnode;
    }
    printf("scanf(\"%s\",&%s);\n",var_type,var_name); 
}


void printing()
{
	char var_name[20];
	char var_type[20];
	strcpy(var_type,"%.6g");
	strcpy(var_name,yytext);
 	printf("printf(\"%s\",%s);\n",var_type,var_name); 
	printf("printf(\"\\n\");");
}


void push()
{
   flag=0;
   strcpy(Token[++top],yytext);
}

void exp_code()
{
    char temp_var_name[3];
    temp_var_name[0]=temp_var;
    temp_var_name[1]=temp_no+'0';
    printf("float %s;\n",temp_var_name);
    printf("%s = %s %s %s;\n",temp_var_name,Token[top-2],Token[top-1],Token[top]);
    top=top-2;
    strcpy(Token[top],temp_var_name);
    temp_no++;
}


void printing_num()
{
  char numb[20];
  strcpy(numb,yytext);
  printf("printf(\"%s\");\n",numb); 
  printf("printf(\"\\n\");");
}

void assign_code()
{
    int found=0;
    var_list *ptr=head;

    //finding variable in var_list
    while(ptr!=NULL && found==0)
    {
            if(strcmp(ptr->name,Token[top-2])==0)
            {
                found=1;
            }
	    else
	    {
                ptr=ptr->next;
	    }
           
    }
  
    //if variable is not found then new variable node is created
    if (found==0 && strcmp(Token[top-1],"=")==0)
    {
        printf("float %s;\n",Token[top-2]);
        var_list* newnode=(struct var_list*)malloc(sizeof(struct var_list));
        strcpy(newnode->name,Token[top-2]);
        newnode->next=head;
        head=newnode;
    }

    //printing assignment code
    if(strcmp(Token[top-1],"=")==0)
    { 
	printf("%s %s %s ;\n",Token[top-2],Token[top-1],Token[top]);
        top=top-2;
    }
}

/*

for(i=1;i<=10;i++){print i;}

float i;
i = 1 ;
L0: 
if (!(i <= 10)) goto L1;
else goto L2;
L3: ;
float t;
t = i + 1;
i = t ;
goto L0 ;
L2: ;
printf("%f",i);
printf("\n");goto L3 ;
L1: ;


L0:cond check after intialisaton
L1:end loop
L2:execute body
L3:increment 

*/

void initialisation()
{
	for_scope++;
	//creating 4 labels of FOR loop
	for_num++;
	for(int i=label_count;i<label_count+4;i++)
	{
		label[i]=for_num;
		for_num++;
	}
	local_count=label_count;
	label_count=label_count+4;
    	printf("L%d_%d: \n",for_scope,label[local_count]);
}

void cond_check()
{
    if(flag==0)
    {      
	    char temp_var_name[2];
    	    temp_var_name[0]=temp_var;
    	    temp_var_name[1]=temp_no+'0';
            printf("if (!(%s %s %s)) goto L%d_%d;\n",Token[top-2],Token[top-1],Token[top],for_scope,label[local_count+1]);
            top=top-2;
 	    temp_no++;
	    printf("else goto L%d_%d;\n",for_scope,label[local_count+2]);
	    printf("L%d_%d: ;\n",for_scope,label[local_count+3]);
    }
    else
    {
         printf("goto L%d_%d;\n",for_scope,label[local_count+2]); 
	 printf("L%d_%d: ;\n",for_scope,label[local_count+3]);
         flag=0;
    }

 }


void increment()
{
    printf("goto L%d_%d ;\n",for_scope,label[local_count]);
    printf("L%d_%d: ;\n",for_scope,label[local_count+2]);
    
}

void execution()
{
    printf("goto L%d_%d ;\n",for_scope,label[local_count+3]);   
    printf("L%d_%d: ;\n",for_scope,label[local_count+1]);
    local_count=local_count-4;
    label_count=label_count-4;
    for_scope--;
}

/*

if(a==10) then {print a;} else {print 0;}

if (!(a == 10)) goto Q0;
printf("%f",a);
printf("\n");goto Q1;
Q0: ;
printf("0");
printf("\n");Q1: ;

Q0:end if-else block
Q1:skip else block

*/

void if_1()
{
    if_scope++;
    if_num++;
    printf("if (!(%s %s %s)) goto Q%d_%d;\n",Token[top-2],Token[top-1],Token[top],if_scope,if_num);
    top = top - 2;
    if_label[++if_top]=if_num;
}


void if_2()
{
	int t_label;
	if_num++;
	t_label=if_label[if_top--];
	printf("goto Q%d_%d;\n",if_scope,if_num);
	printf("Q%d_%d: ;\n",if_scope,t_label);
	if_label[++if_top]=if_num;
}


void if_3()
{
	int t_label;
	t_label=if_label[if_top--];
	printf("Q%d_%d: ;\n",if_scope,t_label);
	if_scope--;
}

void end_code()
{
	printf("return 0;\n}");
}

