Distributed Computing Exercise Using HTCondor on CHTC Machines
(Notes:

• The following design is not required. You may use your design, provided you include the
parallel step.

• We are using small data for which the parallel step slows us down! It helps when we have
more data than fit in memory on one machine. The goal here is to learn HTCondor scripting.
)

• Write a HTCondor DAGMan script, words.dag, to make a sorted list of the words and their
counts in the works of Shakespeare from shakespeare.tar (which extracts to a shakespeare
directory). Include the following steps:

– Write a PRE “.sh” script:
∗ Write all the plays to one large file.
· wget can download shakespeare.tar.
· tar can extract it.
· cat with wildcards can concatenate all the plays into one file.
∗ Break the large file into 5 smaller files.
· split can do it. The standard deviation program from lecture has an example.

– Write a HTCondor “.sub” script to process the 5 files in parallel by calling a “.sh”
script on each file:
∗ Reformat the current file so it has one word per line.
· tr SET1 SET2 (“translate from character SET1 to SET2”) can replace each tab
with a space. e.g. To replace a with X in banana, use echo "banana" | tr 'a' 'X'.
· tr again can replace one or more spaces with a newline. See man tr.
· Another option is sed -e s/regexp/replacement/g (“stream editor: substitute
regexp with replacement globally”). e.g. echo "banana" | sed -e s/a/X/g.
See man sed.
∗ Sort the file of words.
· sort can do it.

– In a POST “.sh” script:
∗ Merge the sorted small files into one large sorted file.
· sort can do it. (Don’t just run sort, which would waste your earlier parallel
sorting of the small files. Instead, look in the sort manual page to see how to
merge several sorted files without sorting.)
∗ Convert the large sorted file to one called countsOfWords whose lines have the form
count word
· uniq can do it.

Submit a tar file, words.tar, that extracts to make a directory words containing:
• your words.dag file and any other code you write
• your countsOfWords file
• a plain-text file README that includes information on your group members (1 to several students)
in the line format NetID,LastName,FirstName. For example, if Wilma Flintstone
(NetID: wflint3) and Charlie Brown (NetID: cbrown71) worked together, their REAMDME file
would be:
wflint3,Flinstone,Wilma
cbrown71,Brown,Charlie
