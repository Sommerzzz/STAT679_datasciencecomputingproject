// infix.cxx: Use the Stack class to convert an infix arithmetic
// expression to the equivalent postfix expression. Note: The
// algorithm requires a set of parentheses around each operator and
// its operands, so "((3+4)*(1+2))" is correct input, but
// "(3+4)*(1+2)", which has no parentheses around the "*" and its
// operands, is not.

#include <iostream>
#include "Stack.h"


using namespace std;

int main() {
  Stack<int> operators; // calls Stack::Stack() constructor
  char c;

  cerr << "Enter an infix expression like 3 4 + 1 2 + *"
       << " for conversion to postfix: " << endl;

  while ((c = cin.get()) != '\n') {
    if ((c == '+') || (c == '*') || (c == '-') || (c == '/')) {
      int i=operators.pop();
      int j=operators.pop();
      if (c=='+'){
	operators.push(i+j);
      } else if (c=='*'){
	operators.push(i*j);
      }
        
    } else if ((c >= '0') && (c <= '9')) {
      int i=c-'0';
      operators.push(i);
    }
  }
  cout << operators.pop() << endl;

  // As operators goes out of scope, Stack::~Stack() destructor gets
  // called here.
  return 0;
}       
