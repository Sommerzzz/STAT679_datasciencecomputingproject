// These students wrote this program:
// NetID,LastName,FirstName
// 
// 
//

// sd.cxx
// This is a group work exercise.
//
// Write a program called "sd.cxx" that computes the sample standard
// deviation of a set of data.
//
// Your program should include three functions:
//
// - mean(), which takes two parameters:
//   - n, an integer, the length of the array being passed
//   - x, an array of doubles (as a pointer), the data
//
// - sd(), which takes two parameters:
//   - n, an integer, the length of the array being passed
//   - x, an array of doubles (as a pointer), the data
//   sd() should call mean() as part of its calculation
//
// - main(), which should:
//   - prompt (to standard error) the user for the number of points
//   - read (from standard input) in the number of points and then the
//     points themselves
//   - use your sd() function to find the standard deviation and write
//     it (alone) to standard output
//

// Hints:
// - If the user types 5 and then 1 2 3 4 5, you should get a standard
//   deviation of about 1.58.
// - Redirect stdin to read from a file, if you wish, by making a file
//   "in" (for "input") containing "5 1 2 3 4 5". Then run "./x < in"
//   to save typing the input repeatedly.
