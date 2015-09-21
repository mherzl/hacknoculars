

import matplotlib.pyplot as plt

def page_ranks():
  with open('../page_rank.txt') as f:
    content = f.read().splitlines()
    pgs = []
    for line in content:
      pg = float(line.split()[-1])
      pgs.append(pg)
    return pgs

def remove_minimums(lst):
  m = min(lst)
  ans = filter(lambda e: e > m, lst)

  return ans

def remove_maximums(lst):
  m = max(lst)
  ans = filter(lambda e: e<m, lst)
  return ans

def remove_max_pair_lb(la, lb):
  t = zip(la, lb)
  m = max(lb)
  ans = filter(lambda (a,b): b < m, t)
  aAns = []
  bAns = []
  for (a,b) in ans:
    aAns.append(a)
    bAns.append(b)
  return (aAns, bAns)

def hist_pagerank():
  pgs = page_ranks()
  for i in range(0):
    print 'here'
    pgs = remove_minimums(pgs)
  print [min(pgs), max(pgs)]
  plt.hist(pgs, bins=200, range=[0, 10**-6])
  plt.yscale('log')
  #plt.xscale('log')
  plt.show()

def ndeps():
  def dependency_dict():
    filePath = '../clean_dependencies.txt'
    with open(filePath) as f:
      content = f.read().splitlines()
      #content_words = [unique_list(x.split()) for x in content]
      content_words = map(lambda e: e.split(), content)
      ans = {}
      for line in content_words:
	ans[line[0]] = line[1:]
      return ans
  dd = dependency_dict()
  return map(len, dd.values())
  #return values(dd)

def scatter_pr_ndep():
  pgs = page_ranks()
  pgs = [e*10**20 for e in pgs]
  print pgs[:10]
  nds = ndeps()
  pgs, nds = remove_max_pair_lb(pgs, nds)
  plt.scatter(nds, pgs)
  #plt.yscale('log')
  axes = plt.gca()
  axes.set_ylim([0, 1])
  plt.show()

scatter_pr_ndep()  
