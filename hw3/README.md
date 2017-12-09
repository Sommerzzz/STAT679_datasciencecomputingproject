[ additions:
  - John: require some ".csv" evidence so that graph.pdf isn't only
    record of distances; e.g. turn in "head -100" of the global .csv file

  - Please see "What to turn in" at the bottom.

  - For your convenience, I put the cb58 file in
    /home/groups/stat679/boss/cb58_Lyman_break.fit.

  - For a few ways to handle passing the input file names, see p. 47
    of Christina's slides posted in the "Christina Koch" line of the
    syllabus.

  - Don't debug much in HTCondor. Get things working via a "serial.sh"
    script first (using loops for what you want to do in parallel).

    You could create a few fake ".tgz" files by making them from 3
    ".fits" files from the HW2 data. For example, put three files in
    directory 0001 and run "tar cvzf 0001.tgz 0001" and you've got
    your first ".tgz" file. Then get serial.sh working. It will then
    be a small step to get it working on HTCondor.

  - Check the HTCondor manual as necessary:
    http://research.cs.wisc.edu/htcondor/manual.

]

Hello STAT 679 Students,

Here is a draft homework 3. I will revise it a little as we proceed
(after conversation with Christina from CHTC).

--John

----------------------------------------------------------------------

1. Revise your hw2.R to a new hw3.R that takes two command-line
   arguments: a template spectrum for which to search and a data
   directory in which to find spectra to compare to the template. If
   called from the command line without two arguments, it should
   display this message:
     usage: R CMD BATCH "--args <template spectrum> <data directory>" hw3.R
   An example actual usage is:
     usage: R CMD BATCH "--args cb58_Lyman_break.fit 3586" hw3.R  

   Your hw3.R should write an output file whose name is the data
   directory name followed by ".csv" and whose line format is
     distance,spectrumID,i
   where
     distance   = your measure of the distance from this spectrum to the
                  template
     spectrumID = the spectrum ID, e.g. 1353-53083-0579 from
                  spec-1353-53083-0579.fits
     i          = the index in the spectrum at which your alignment with
                  the template begins
   It should include one line per spectrum in the data directory. It
   should be sorted by increasing distance.

   Test your hw3.R on one of the data directories in
   /home/groups/stat679/boss/tgz on learn.chtc.wisc.edu. (I suggest
   limiting your hw3.R to process only about 3 of the 1000 spectra
   from the directory while coding and debugging. If your computation
   is slow, so that processing 1000 spectra takes more than an hour,
   limit yourself to fewer than 1000 spectra per data directory. That
   is, ignore some of the spectra rather than run a long job.)

   Note: Do not copy files from /home/groups/stat679/boss/tgz to your
   home directory, as this would unnecessarily blow up our usage of
   CHTC disk space. Instead, refer to files in
   /home/groups/stat679/boss/tgz and let HTCondor move one ".tgz" file
   per job to each compute note.

2. Write an HTCondor program to run your hw3.R on one of the data
   directories (still using only 3 spectra). Note its "Cpus", "Disk
   (KB)", and "Memory (MB)" use from the bottom of its ".log"
   file. Include these requirements (after increasing the Disk and
   Memory by a little) in your HTCondor ".sub" script. Try it again
   with all 1000 spectra.

3. Revise your program from (2) to run hw3.R on five data directories
   (first processing 3 files per directory, then all 1000).  Again
   note CPU, Disk, and Memory usage, and revise your ".sub" script
   requirements if necessary.

   Combine all five ".csv" output files into one file sorted by
   distance.

4. Revise your program from (3) to run hw3.R on all 2459 data
   directories in /home/groups/stat679/boss/tgz.

   Combine all 2459 ".csv" output files into one file sorted by
   distance.

5. Write a graph.R script to graph each of your best n=10 spectra
   aligned with the template, one page per spectrum, in a ".pdf" file.

   Look at the graphs. Revise your code to discard the poor matches,
   retaining only the good ones you think might interest our
   astronomer guide.

----------------------------------------------------------------------
Regarding CHTC:

- Monitor your jobs with "condor_q". To stop all your jobs, run
  "condor_rm <NetID>" (for me it's "condor_rm jgillett").
- No job should run longer than 1 hour. Kill any job that runs longer
  and redesign it.
- Do not copy a lot of data to your home directory on
  learn.chtc.wisc.edu or any other CHTC computer.
- Do not launch a large number of jobs via an untested script. Start
  with 1 job, then 5, and only then a larger number.
- Ask for help if you have trouble managing your jobs.

----------------------------------------------------------------------
What to turn in:

Please make a directory whose name is your NetID (mine is
"jgillett"). Put these files in that directory:

- hw3.R
- your HTCondor program (which probably includes at least a ".sub"
  file and a ".sh" file)
- the ".log" file resulting from running your HTCondor program, if
  it's easy
- graph.R
- graph.pdf, a ten-page ".pdf" file containing your 10 best matches
  (feel free to make your ".pdf" contain more good matches, without
  exceeding 10 MB; please don't include more than 10 if they do not
  look good)
- an optional "README" file if you want briefly to describe your
  results and complications. In particular, if you have many
  attractive-looking matches, please list their IDs.

Make a ".tar" file (mine is "jgillett.tar") of that
directory. Extracting it should recreate your
directory. (e.g. Extracting jgillett.tar creates directory jgillett
which contains the required files.)

----------------------------------------------------------------------
