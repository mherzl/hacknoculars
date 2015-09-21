
graph scatter of number of dependencies vs number of dependents

Check to see whether some of the dependencies are not listed as names; the middle fromMaybe in page_rank.hs was giving a Nothing when it was fromJust.
Ans: while there appear to be only 8346 package names, there are 8491 unique package names in either names or dependencies. This is after the packages with non-included dependencies were supposedly removed. I do not know what is going on there.

There are 8527 packages listed, 8345 of which do not list dependencies to nonexistent packages (182 list nonexistent dependencies).

5272 of the packages have 0 dependents.

format of: package_dependencies.txt
one package per line
first word is name of package
following words are the dependencies of that package

error during requests quoted: package, line
hmatrix-syntax, 4034
torrent, 7694


hackage: HandsomeSoup allows one to use css selectors

tutorial for parsing HTML in haskell (with Conduit)
https://www.fpcomplete.com/school/starting-with-haskell/libraries-and-frameworks/text-manipulation/tagsoup

css selector to get names of packages graph-utils depends on from the html of its dependencies page:
innerHTML of the <a> tags which are descendents of the div with id="detailed-dependencies"

curl command to get dependency html for graph-utils:
curl http://hackage.haskell.org/package/graph-utils/dependencies

using haskell package: tagsoup, to scrape html for package dependencies, as those apparently are not available in json format.

curl command to get list of hackage packages in json format:
curl http://hackage.haskell.org/packages/.json > packages.json
