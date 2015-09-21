##Kanban document for HACKAGE_RANK
================================================================================================================================
#UNSTARTED
--------------------------------------------------------------------------------------------------------------------------------

  1.3 Verify Data graphically
    1.3.3 Graph number of times depended upon as a function of package age

2. Compute page rank for each package

6. Compute search query algorithm
  6.1 perhaps use latent semantic indexing on the package source code

3. Create web app which informs the world of the page ranks
  - Search query form
  - displays top x packages in order of relevance to search query, with text size proportional to page rank (or log of page rank).

4. Create visualization of the network
  4.1 Determine which package to use (need javascript (ds3) if want to make web interactive). Preferably something specific to networks e.g. wrapper to ds3.

5. Extra
  5.1 Show other statistics along with page rank
    5.1.2 voting statistics
  5.2 Make data gathering process more robust
    5.2.1 Have fetch scripts update sql process to a relational database containing all the data
  5.3 Make website update data automatically.
    5.3.1 Request package list periodically (e.g. nightly)
    5.3.2 Request parts of other data periodically (e.g. 5% nightly)
  5.4 Improve importance measure by factoring in more than just page rank
    5.4.1 Incorporate page rank inversely weighted by (log of) the number of dependencies which have occured since the date of publication
      5.4.1.1 Get date of publication for each package
      5.4.1.2 For any package can show graph of time-variant importance over time
    5.4.2 Is it possible to connect to github to obtain relevancy metrics from there?
  5.5 Compute similarity metric on package dependency graph
    5.5.1 Based on linear algebra of adjacency matrix

================================================================================================================================
#DESIGN
--------------------------------------------------------------------------------------------------------------------------------


================================================================================================================================
#TEST
--------------------------------------------------------------------------------------------------------------------------------

1. Get data from hackage
  1.1 list of package names
  1.2 list of dependencies for each package
  1.3 create file containing dependencies for each package

================================================================================================================================
#BUILD
--------------------------------------------------------------------------------------------------------------------------------


================================================================================================================================
#REVIEW
--------------------------------------------------------------------------------------------------------------------------------

    1.3.1 Graph number of packages as a function of number of dependencies
    1.3.2 Graph number of packages as a function of number of times depended upon

================================================================================================================================
#DONE
--------------------------------------------------------------------------------------------------------------------------------

