//  M-x compile Enter
//  g++ -Wall -g -o sd sd.cxx 
#include <iostream>
#include <cmath>
using namespace std;
double mean(int n, double *x){
  double sum = 0;
  for (int i = 0; i < n; ++i){
    sum +=x[i];
  }
  return sum/n;
}

double sd(int n, double *x){
  double calculate = 0;
  double get_mean=mean(n,x);
  for (int i = 0; i < n; ++i){ //get_mean is defined in the main function part
    calculate = calculate + (x[i]-get_mean)*(x[i]-get_mean);
  }
  return sqrt(calculate/(n-1));
}

int main(){ //execution starts in main()
  // write to standard output
  cout << "Please give number of points" << endl;
  int n_points; // declare the input x variables
  cin >> n_points; // read from the standard input
  
  cout << "Please input n number(n=number of points)" << endl;
  double *x = new double[n_points]; // declare the input x variables
  for (int i=0; i <n_points; ++i){
    cin >> x[i];
  }
  // allocate memory for x array
  cout << "result is " << sd(n_points,x) << endl; 
  // how to get the number of points
  return 0;
}