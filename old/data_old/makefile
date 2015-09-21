clean_dependencies.txt: raw_dependencies.txt clean_dependencies.hs
	runhaskell clean_dependencies.hs

page_rank.txt: clean_dependencies.txt page_rank.hs
	runhaskell page_rank.hs
