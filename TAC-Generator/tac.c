#include<stdio.h>
#include<stdlib.h>
int main(){
float y;
y = 5 ;
float t0;
t0 = 13 * y;
float t1;
t1 = t0 / 4;
float t2;
t2 = 12 + t1;
float t3;
t3 = t2 - 7;
float x;
x = t3 ;
printf("%.6g",x);
printf("\n");float a;
scanf("%f",&a);
if (!(a == 10)) goto Q0_0;
printf("0");
printf("\n");goto Q0_1;
Q0_0: ;
if (!(a == 5)) goto Q1_2;
printf("1");
printf("\n");goto Q1_3;
Q1_2: ;
printf("2");
printf("\n");Q1_3: ;
Q0_1: ;
float counter;
counter = 0 ;
float i;
i = 0 ;
L0_0: 
if (!(i < 2)) goto L0_1;
else goto L0_2;
L0_3: ;
i=i+1;
goto L0_0 ;
L0_2: ;
float j;
j = 2 ;
L1_5: 
if (!(j <= 4)) goto L1_6;
else goto L1_7;
L1_8: ;
j=j+1;
goto L1_5 ;
L1_7: ;
float k;
k = 5 ;
L2_10: 
if (!(k < 7)) goto L2_11;
else goto L2_12;
L2_13: ;
k=k+1;
goto L2_10 ;
L2_12: ;
counter=counter+1;
goto L2_13 ;
L2_11: ;
goto L1_8 ;
L1_6: ;
goto L0_3 ;
L0_1: ;
printf("%.6g",counter);
printf("\n");return 0;
}