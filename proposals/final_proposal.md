
=====================================
# Final Results: Web app
--------------------------------
* Page 1: Entire graph view
  - shows a visual graph of all the Hackage packages, shown as dots with arrows showing dependencies
  - option to show importance of dot as dot size (or color)
  - one can mouseover each dot to see the package name
  - other than the default display method; can select two SVD features, and show the position of each package(Dan has a friend expert in graph theory you can ask about how to display it)
  - option to show aspects of SVD features; e.g. color of a package (as determined by spectrum) the value on that feature scale.
  - ability to zoom in/out and move around
* Page 2: single package view
  - One can type in the name of a package, and see a visual arrangement of dependencies and dependents
  - Also shows a plot of the packages page rank and importance over the lifetime of the package
  - Interactive; clicking on one will bring us to that page
   - also shows similar packages as determined by SVD and a visual comparison of importance

=====================================
# Current Status
--------------------------------
* Have done
 - Have dependency data
 - Have hist graphs of dependencies and dependents
 - Have working page rank algorithm

=====================================
# Chronological Task List
--------------------------------
* Priority 0: Finish by end of Tomorrow Friday (sep-03)
 - Calculate page rank for each package
 - Create distribution graph of page rank of packages
 - Email Dan the three graphs you have so far and let him know where you plan to take it from there.
--------------------------------
* Priority 1: Finish by end of next Wednesday (sep-10)
 - basic ds3 app displaying package graph and incorporating pagerank (perhaps by color)
 - Create first draft of paper (blog style) and presentation documenting what you have done.
--------------------------------
* Priority 2: Finish by end of next Thursday (sep-11)
 - get uploaded date information
 - calculate importance for each package
 - create graph of package importance for each package over the lifetime
--------------------------------
* Priority 3: finish by end of next Friday (sep-12)
 - create package page app displaying the importance plot (and also pagerank over time)
 - page should also display local graph for that package in ds3 as with whole graph
--------------------------------
* Priority 3: Finish by end of following weekend (sep-13)
 - Compute SVD on adjacency matrix, and feature - package data to incorporate into web app.
* Priority 4: Finish following Monday (sep-14)
 - Add top n similar packages display and link to package pages of web app
* Priority 5: Finish by end of following Friday (sep-18)
 - Write second draft of paper/blog and presentation
 - Clean up code and plan what you will do with the following time that you have before presenting the project.

