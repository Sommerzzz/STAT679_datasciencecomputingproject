(Bash) Shell Scripts: Exercises
• Write a script, digits, to find the sum of the numbers between 1000 and 2000 (inclusive)
having digits only from the set {0, 1}. (Hint: Use a brace expansion, a loop, and a conditional
statement including a regular expression. In emacs, run M-x sh-mode to get help with code
formatting including indenting.)
• Write a script five_dirs.sh that does these tasks:
– make a directory five
– make five subdirectories five/dir1 through five/dir5
– in each subdirectory, make four files, file1 through file4, such that file1 has one line
containing the digit 1, file2 has two lines, each containing the digit 2, ..., and file4
has four lines, each containing the digit 4
• Write a script rm_n whose usage statement is usage: rm_n <dir> <n> that removes all files
in directory dir larger than <n> bytes. Try it on your five directory via rm_n five 3.
Hint: use find. In emacs, do M-x man Enter find Enter to check its man page. The page
is 1200 lines long–don’t read it all. Just read about its size argument and search within it
for the text “Numeric arguments.”
• Write a script, mean.sh, with usage statement usage: mean.sh <column> [file.csv], that
reads the column specified by <column> (a number) from the comma-separated-values file
(with header) specified by [file.csv] (or from stdin if no [file.csv] is specified) and
writes its mean.
– “mean.sh” in this usage statement should be is specified in your script as $0, so that
the usage statement will be correct even if you change the script name later.
– Write the usage statement, which is for humans to read (not for further programs in a
pipeline), to stderr. One way to do this is via echo. Normally it writes to stdout.
Redirect stdout to go to stderr via “1>&2” as in echo "hello" 1>&2.
– By convention, the “<...>” delimiters in “<column>” indicate a required argument, and
the “[...]” delimiters in “[file.csv]” indicate an optional argument.
– Here are three example runs:
∗ mean.sh prints the usage statement
∗ mean.sh 3 mtcars.csv finds the mean of the third column of mtcars.csv.
∗ cat mtcars.csv | mean.sh 3 also finds the mean of the third column of mtcars.csv.
(Here mean.sh 3, with no file specified, reads from stdin.)
• (optional) Write a script summary whose usage statement is usage: summary <file> <type>.
It reads from file, a file of one number per line, and, depending on <type> from min, max,
or median, writes one of the minimum, maximum, or median of the file’s numbers. Do this
using sort, head, tail, and wc. e.g. summary numbers.txt median writes the median of
the numbers in numbers.txt.
What to turn in:
Write a plain-text file called README that includes information on your group members (1 to several
students) in the line format NetID,LastName,FirstName. For example, if Wilma Flintstone (NetID:
wflint3) and Charlie Brown (NetID: cbrown71) worked together, their REAMDME file would be:
wflint3,Flinstone,Wilma
cbrown71,Brown,Charlie
Put five files, README, digits, five_dirs.sh, rm_n, and mean.sh (or six files including summary),
in a directory group1. From the parent directory of group1, run tar cvf group1.tar group1.
Turn in group1.tar.
