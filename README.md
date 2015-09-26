# hacknoculars

Project: Recommendation System for Haskell Packages

Using the correct set of component packages is an essential part of programming.
However, for any given functionality there often exist multiple package options, and exploring the usability of each contender on its own to make the most educated decision on which to use can cost valuable coding time.
A programmer might use Google or word-of-mouth and try one package after another until s/he comes across one which provides the desired functionality.
This method works to an extent, but leaves room for more specific and accurate solutions which narrow search constraints to packages within a particular desired language and have the full set of potential options at their disposal, and assist a programmer to consider the various options and efficiently determine which to use.
My project, which is a recommendation system for packages written for the Haskell programming language, approaches this package-search problem directly.
It uses the full set of Haskell packages (Hackage) and data science techniques to estimate the quality and functionality of each package, thus addressing the package-search problem directly.
These techniques include computing the page-rank on the dependency graph to estimate the importance of a given package, and providing a recommendation system which estimates which packages are likely to have similar functionality to any given package in question.
The product of my project is a web app which assists haskell programmers to explore relevant aspects of the available package set, and thus addressing the package search problem within the domain of Haskell.

