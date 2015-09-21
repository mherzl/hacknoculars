Matthew Herzl
Galvanize Data Science, 2015-aug-25

# Project Ideas

## Idea 1: Analyze Graph of Hackage Packages

### High Level Description
 * Given several Hackage packages with similar functionality, which library is best to use?
  - Compute page rank as measure of importance
  - Secondary: compute search term relevance. Order results by relevance, size by page rank.

### Presentation
 * Web app in which one can enter a search term and get list of functions where text size of package name represents the page rank of that package.
 * Perhaps also allow interactive display of graph of package dependencies
 * Other computations on the graph? Categorization? Means of exploring the world of Haskell packages.

### Current Status, Next Step
 * Have already scraped and cleaned the package dependency information
 * Next step is to create graph and compute page rank
 * Then create web app displaying this information in basic form.
 * I also need to figure out how to compute relevance.
  - Need to determine a good way of doing this, perhaps using hoogle.

### Data Sources
 * Hackage Web site. Have already scraped dependency information.

## Idea 2: Analyze Graph of Collective IP research papers (or patents)

### High Level Description
 * What are the most important research papers to familiarize oneself with on any given topic?
  - Compute graph of a large set of research papers (or patents)
  - Compute some kind of search functionality to specify categories.

### Presentation
 * Web app allowing one to specify criteria and search for most relevant papers meeting it.
 * Display interactive graph of paper citations.
 * Other computations? Categorization?

## Next Step
 * get data from IPcomplete
 * compute citations

## Data Sources
 * IPcomplete papers and/or patents

## Idea 3: Applying Machine Learning to the game of Go

### High Level Description
 * What rating would you give to a game? To a move?
 * Apply machine learning techniques to a large data set of Go games to create an algorithm that estimates the rating level of a performance in a single game
 * Will have to conglomerate the various rating systems
 * Perhaps use a markov-based ranking system to improve upon existing ranking systems.

### Presentation

### Next Step
 * Download (perhaps purchase) data (sensei library)
 * Create a basic random forest on a set of a million + points, perform verification, and see how accurate the resulting model is.
  - Use board symmetry in the model.

### Data Sources
 * Game data:
  - http://senseis.xmp.net/?GoDatabases
 * Comparison between ranking systems:
  - http://senseis.xmp.net/?RankWorldwideComparison
