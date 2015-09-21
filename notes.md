
consider using the package on github at: https://github.com/jamwt/mirror-hackage
to download all of hackage

================================
SVD
--------------------------------

SVD on the adjacency matrix will give a matrix factorization A = U S V
where each row of A is zeros and ones, each row is zero or 1 dependent on whether the package of that row depends on the package in the corresponding column.

U has #packages rows and #features columns.
The similarity in dependencies between two packages will be the cosine similarity between corresponding rows of U.

S is a square diagonal #features by #features matrix representing the significance of each feature.

V is a #features by #packages matrix, each column of which represents dependents.


================================
Jacard Similarity
--------------------------------

For any two rows a and b of A, the Jacard similarity is
|a intersect b| / |a union b|

Jacard similarity is a measure of the similarity of two packages and Dan expects that it should give very similar results to SVD.
It is also much simpler to implement, so I should start with that, and for the long term it would be interesting to see how well Jacard similarity agrees with SVD similarity in this case.

================================
Synopsis
--------------------------------

Using the correct set of component packages is an essential part of programming.
However, for any given functionality there often exist multiple package options, and exploring the usability of each contender on its own to make the most educated decision on which to use can cost valuable coding time.
A programmer might use Google or word-of-mouth and try one package after another until s/he comes across one which provides the desired functionality. This method works to an extent, but leaves room for more specific and accurate solutions which narrow search constraints to packages within a particular desired language and have the full set of potential options at their disposal, and assist a programmer to consider the various options and efficiently determine which to use.
My project, which is a recommendation system for packages written for the Haskell programming language, approaches this package-search problem directly. It uses the full set of Haskell packages (Hackage) and data science techniques to estimate the quality and functionality of each package, thus addressing the package-search problem directly. These techniques include computing the page-rank on the dependency graph to estimate the importance of a given package, and providing a recommendation system which estimates which packages are likely to have similar functionality to any given package in question.
The product of my project is a web app which assists haskell programmers to explore relevant aspects of the available package set, and thus addressing the package search problem within the domain of Haskell.




Google and word-of-mouth tend to be eff
specific solution which addresses this problem directly.
However, when performing this essential aspect of writing code and determining which packages to use, Google & word-of-mouth are often the extent of search capabilities used; often a programmer will use a package 

Hacknoculars is a recommendation system for Haskell packages.
