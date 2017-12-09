STAT 679 Homework 2

This exercise is a first step in our search for an undiscovered,
gravitationally lensed, high-redshift Lyman-break galaxy.

----------------------------------------------------------------------
I recommend working in a new directory, "~/private/679/2".

Download data.tar. Use an emacs shell buffer to run "tar xvf data.tar"
(tar="tape archive", xvf="extract verbose the file ..."). It will
extract 100 ".fits" files in a new subdirectory called "data". Each
file contains a SDSS spectrum of an astronomical object.

Download "cb58_Lyman_break.fit", the spectrum of a known Lyman-break
galaxy. It is a higher-quality spectrum than the SDSS spectra and is
relatively noise-free.

Note: I showed you how to download a file to your local machine and
then use scp to copy it to stat-679.stat.wisc.edu. Some students have
encountered an error when extracting their data.tar files. An
alternative to downloading and copying is to use the command
  wget http://pages.stat.wisc.edu/~jgillett/679/2/data.tar
on stat-679.stat.wisc.edu. (wget provides a non-interactive
download. "wget" means "web get.")

----------------------------------------------------------------------
The R package "astro" gives access to software that can read and
manipulate FITS files (https://en.wikipedia.org/wiki/FITS). In
particular, it gives the function
  read.fitstab()
which can read a ".fits" file containing a spectrum and return a
matrix containing its data. These are the columns of the matrix:

- "flux" is light intensity at a given wavelength. I think it is
  theoretically nonnegative, but with noise it can be negative.

- "loglam" is log(x=wavelength, base=10), so wavelength = 10^loglam.

- "ivar" is 1/sigma_i^2, where sigma_i^2 is an estimated variance of
  the ith flux.

- "and_mask" is 0 for a good observation. We should exclude data with
  nonzero and_mask. (Each spectrum is constructed from several
  observations. Masks flag problems in the data. "and_mask" indicates
  whether there is bad data at this pixel in all observations.)

- "or_mask" is 0 for a good observation. We can ignore it. (It says
  there is bad data at this pixel in at least one observation.)

- "wdisp" is the resolution of the spectrograph at that wavelength. We
  can ignore it.

- "sky" is the spectrum of the sky, mostly already subtracted out from
  flux. We can ignore it. (Some algorithms may need to mask out +/-5
  pixels around 5577 Angstroms to avoid spurious matches to a strong
  emission line due to Earth's atmosphere.)

- "model" is SDSS's hypothesis of the true spectrum, shifted to the
  redshift of the galaxy. We seek each spectrum that is closer to a
  known Lyman-break galaxy than to its model.

Note: read.fitstab() can also read "cb58_Lyman_break.fit", a ".fit"
file. The cb58 spectrum contains only "FLUX" and "LOGLAM".

----------------------------------------------------------------------
Work in emacs on the stat-679.stat.wisc.edu Linux computer to write
"hw2.R" to do these things:

  - Make a graph showing the spectrum (x=wavelength, y=flux) of
    cb58. [ It's ok if you abandon actual wavelength and instead use
    shifted wavelength, which could even be index. ]

  - Find the 3 SDSS spectra closest to cb58 by a measure of your choice.

    - Consider integer redshifts (shift 1, shift 2, shift 3, ...) of
      wavelengths in attempting to match cb58.

    - How complicated should you make your search?

      - The simplest search I can think of is to forget about
        astronomy. The x-coordinates (wavelength) are not relevant
        because we'll redshift them anyway. The y-coordinates (flux)
        are relevant. We have one vector of y-coordinates, cb58 (in
        cb58_Lyman_break.fit), which is a known Lyman break galaxy. We
        have another 100 vectors of y-coordinates (in data.tar). Which
        of them is most like the cb58 vector?

        For two vectors of y-coordinates A and B, the simplest measure
        I can think of is
          distance(A, B) = sqrt[ sum_{i=1}^n (A_i - B_i)^2 ].

        It's probably worth also considering and_mask and ivar in our
        distance measures. Approaches unrelated to this distance
        measure may also be appropriate and possibly much better.
 
      - We can ignore this paragraph. When we show the spectra we
        found to Christy (the astronomer), here are some ways she
        will decide whether it is a Lyman-break galaxy. In the
        Lyman-break galaxy cb58, note the presense of:
        - the Lyman-alpha absorption trough
        - the Lyman-alpha emission peak (just right of the trough)
        - metal abosorption lines (right of the peak)
        Last spring, students found spectra that interested Christy
        without considering these things. I mention them in case they
        can be helpful anyway.

    - Add the 3 aligned spectra to your graph. Include a legend
      identifying cb58 and the other spectra. (e.g. Identify
      "data/spec-2359-53826-0199.fits" as "2359-53826-0199".)

      [ Please make your graph show each of the 3 alignments
        separately:
        - For example, one graph of all four spectra, not overlapped,
          could work.
        - For another example, one graph of three panels could show
          cb58 vs. your best match, cb58 vs. your second best match,
          and cb58 vs. a third match.
        - It's also ok to make 3 graphs.
        - Possibly even one overlapping graph of all four spectra
          could work, but the plots like these I've seen were hard to
          read.
      ]

    - You should find at least one persuasive match, as the data
      directory contains an SDSS spectrum of cb58 (it is a noisy
      version of cb58) and one or several others that look similar.
      [ Hint: The SDSS spectrum of cb58 is spec-1353-53083-0579.fits. ]
      [ Bigger hint: read the file "hint.txt" in this directory. ]

Report on what you tried, what worked, and what didn't. In particular,

  - Describe the measure you chose and why you chose it.

  - Describe difficulties you had with data irregularities.

After hw2.R is turned in, each table of students will discuss results.
Each table will rank results and report the best insights to the class.

You can and should discuss algorithms with your peers, but you may not
look at your peers' code or show your code to peers.

----------------------------------------------------------------------
Here is what to turn in.

Please make a directory "2". Put the following files in it:

  - hw2.R, your R code that solves the problem. We should be able to
    run
      source("hw2.R")
    in a directory containing cb58_Lyman_break.fit and the data
    directory (extracted from data.tar).

    Please do not include cb58_Lyman_break.fit and the data in this 2
    directory you are setting up for turning in your files (so that we
    will not receive the data N times, where N is the number of
    students in the class).

  - hw2.pdf, which should contain your graph(s) and responses to these
    instructions:
    "Report on what you tried, what worked, and what didn't. In particular,
     - Describe the measure you chose and why you chose it.
     - Describe difficulties you had with data irregularities.
    "

    The first paragraph of hw2.pdf should summarize what you did and
    what success you had. Your entire hw2.pdf should be no more than 3
    pages long.

  - The source file you used to make hw2.pdf (e.g. hw2.tex or hw2.Rmd
    or hw2.docx, etc.)

In the directory above your 2 directory, open a shell buffer. Run
  tar cvf 2.tar 2
("tape archve c=create, v=verbose, f=file to create 2.tar from the 2 directory")
to create the file 2.tar from your 2 directory.

Upload 2.tar as Canvas's HW2Lyman100 assignment.
