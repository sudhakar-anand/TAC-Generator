# Intermediate-3-address-code-Generator : Program to generate 3-address code.

Recommended **OS: ubuntu**.

Prequisites: **gcc** (C language compiler) , **lex** (generates lexical analyzers) and **yacc** (generates parser) 

**To run the program run following command in terminal :**
- To give execution permission to build, test_run and run : **chmod +x build**
							    **chmod +x test_run**
							    **chmod +x run**
- To build executable : **./build**
- To run the sample bc code in file sample_input: **./test_run**
- To run custom bc code : **./run**

**FILES :**
- **lp.l**	 - lex file
- **lp.y** 	 - yacc file
- **lp**   	 - intermediate code generator
- **tac.c**	 - intermediate 3-address code
- **tac**		 - executable file of intermediate code tac.c
- **sample_input** - sample input bc code
- **warning**	 - contains all prasing warnings (like: shift/reduce conflicts)
- **build**	 - file to create lp executable (generate lex.yy.c, y.tab.c, y.tab.h and lp) 
- **test_run**	 - file to run sample bc code (generate tac.c and tac for smple_input)
- **run**		 - file to run bc code given by user (generate tac.c and tac for user input code)
- **lex.yy.c**	 - generated by lex for yacc file
- **y.tab.c**	 - generated by yacc c file (Parser)
- **y.tab.h**	 - generated by yacc header file

**This program has the following functionalities:**
- supports '**bc**' (basic calculator) language code ( https://www.gnu.org/software/bc/manual/html_mono/bc.html )
- supports **print** (to print data to standard output) and **read** (to read a number from the standard input) commands
- supports **if-then-else** condition statement (nested if-then-else also supported)
- supports **for loop** (nested for loop also supported)
- supports **single line comments** ( // )
- converts the code to intermediate **3-address code** ( https://www.javatpoint.com/three-address-code ) .

Made by : **Sudhakar Anand**

Reference : http://dinosaur.compilertools.net/
