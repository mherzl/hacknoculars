raw_dependencies:
#	python

# Data -----------------------------

pubdates: data/package_names.txt src/fetch_pubdates.hs
	runhaskell src/fetch_pubdates.hs

clean_dependencies: data/raw_dependencies.txt src/clean_dependencies.hs
	runhaskell src/clean_dependencies.hs

dependents: data/clean_dependencies.txt src/dependents.hs
	runhaskell src/dependents.hs

page_rank: data/clean_dependencies.txt src/page_rank.hs
	runhaskell src/page_rank.hs

jacard_pairs: data/clean_dependencies.txt src/jacard_pairs.hs
	runhaskell src/jacard_pairs.hs

jacard_matches: data/clean_dependencies.txt src/jacard_matches.hs
	runhaskell src/jacard_matches.hs

# Plots -----------------------------


dependencies_hist: src/gen_plots/dependencies_hist.py data/clean_dependencies.txt
	python src/gen_plots/dependencies_hist.py

dependents_hist: src/gen_plots/dependents_hist.py data/dependents.txt
	python src/gen_plots/dependents_hist.py

pagerank_dependents: src/gen_plots/pagerank_dependents.py data/page_rank.txt data/dependents.txt
	python src/gen_plots/pagerank_dependents.py

jacard1_hist: src/gen_plots/jacard1_hist.py data/jacard_matches.txt
	python src/gen_plots/jacard1_hist.py

importance_zoom: src/gen_plots/importance_zoom.py data/page_rank.txt data/dependents.txt
	python src/gen_plots/importance_zoom.py
	convert -delay 35 -loop 0 plots/importance_zoom/importance_zoom_*.png plots/importance_zoom/importance_zoom.gif

# Graphs ---------------------------------

full_graph: src/graphs/full_graph.py data/dependents.txt
	python src/graphs/full_graph.py

# Data Scripts -------------------------------

query: src/data_scripts/query_package.hs
	runhaskell src/data_scripts/query_package.hs

# Aggregates -----------------------------

plots: dependencies_hist dependents_hist pagerank_dependents



