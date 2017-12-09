STAT 679 n-Queens Homework

The Assignment:
Implement a stack-based backtracking search to find a solution to the n-queens problem by placing n chess queens on an n by n board so that no queen is under attack. This is trivial for n=1, impossible for n=2 and n=3, and possible for n ≥ 4. For example, here is a solution to the 4-queens problem:
	 
	  .            0   1   2   3  
	
	  .          -----------------
	  
	  .        0 |   | Q |   |   |
	  
	  .          -----------------
	  
	  .        1 |   |   |   | Q |
	  
	  .          -----------------
	  
	  .        2 | Q |   |   |   |
	  
	  .          -----------------
	  
	  .        3 |   |   | Q |   |
	  
	  .          -----------------
	

Your program should print a solution if one exists, or "no solution exists" otherwise.
Goals:
Increase experience with C++ features including
template classes and functions
user-defined functions
command-line arguments
the stack abstract data type
in the context of a famous search problem.

Files you should write (start with our versions):
Stack.h: The header for a template Stack class. (Caution: "stack.h" is a libary file; our header file has a capital "S".) You do not need to change this file.
Stack.template: The implementation file for the Stack class. Your stack must be stored in a singly-linked list. This file is done except for Stack::operator[], which you should implement.
makefile: A file to allow efficient compiling of our multi-file project with the command "make". (Note that files using the template Stack class depend upon Stack.h and Stack.template, but that Stack.template doesn't appear on any of the compile command lines. This is because Stack.h has a line including Stack.template, so that both are seen by the compiler in any file that includes Stack.h.)
testStack.cxx: A small interactive test program that exercises your Stack code. Add a case to call your Stack::operator[] when the user types "i" and a numeric index in response to the menu. Use this program to test your Stack before writing queens.cxx.
queens.cxx: A program which runs a stack-based backtracking search to solve the n-queens problem. (Note that there are many ways to solve the n-queens problem. You must use our stack-based backtracking search, since it's part of what we want you to learn in this assignment.) This program takes two command-line arguments, described below. Your output must look at least as good as ours. See the 4x4 board above--its solution is easy to verify by looking at it. (Hint: I found the setw() ("set width") output operator operator helpful. It allows fixed-width output as in this code: int i = 3; cout << setw(2) << i << endl;)

Hint: My solution added about 10 lines of code to Stack.template, 5 to makefile, 5 to testStack.cxx, and 80 to queens.cxx, for a total of about 100 lines of code.

Here are all the above files in one place:
hw4.tar: a "tape archive" file that you can download and then extract by running "tar xvf hw4.tar". This will create a new directory called "4" containing all the required files.

Here's what to turn in:
hw4.tar: a "tape archive" file that you create. First clean your directory by running "make clean" and removing junk files. Then run "tar cvf ../hw4.tar .". This will create a tar file of the contents of your "hw4" directory. Make sure your tar file works on stat-679 by copying it to a junk directory and extracting it ("tar xvf hw4.tar"). Then try compiling and running your programs.
The n-queens problem: Discussion of the assignment
How to handle command-line arguments
