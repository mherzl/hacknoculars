
import matplotlib.pyplot as plt

outputDir = 'plots'

def read_namenum(path):
  with open(path) as f:
    content = f.read().splitlines()
    names = []
    nums = []
    for line in content:
      linesplit = line.split()
      name = linesplit[0]
      num = float(line.split()[-1])
      names.append(name)
      nums.append(num)
    return names, nums

def read_nameNdeps(path):
  with open(path) as f:
    content = f.read().splitlines()
    names = []
    nums = []
    for line in content:
      linesplit = line.split()
      name = linesplit[0]
      nDeps = len(linesplit) - 1
      names.append(name)
      nums.append(nDeps)
    return names, nums

def scatter_pr_ndep(save=True, show=False, verbose=False):
  depPath = 'data/dependents.txt'
  prPath = 'data/page_rank.txt'
  namesD, nDeps = read_nameNdeps(depPath)
  namesP, nPrs = read_namenum(prPath)
  if namesD == namesP:
    names = namesD
  else: print('namesD != namesP')
  if verbose:
    maxDep = max(nDeps)
    nMaxDep = []
    for i,d in enumerate(nDeps):
      if d == maxDep:
        nMaxDep.append(names[i])
    print('The greatest number of dependents is: ' + str(maxDep))
    print('The packages with this many dependents are: ' + str(nMaxDep))
    maxPr = max(nPrs)
    pMaxPr = []
    for i,p in enumerate(nPrs):
      if p == maxPr:
        pMaxPr.append(names[i])
    print('The greatest page rank is: ' + str(maxPr))
    print('The packages with this pr are: ' + str(pMaxPr))
  plt.title('Page Rank as a function of number of immediate dependents')
  plt.xlabel('# dependents')
  plt.ylabel('page rank')
  plt.scatter(nDeps, nPrs)
  #plt.yscale('log')
  #plt.xscale('log')
  if show: plt.show()
  if save:
    outputPath = outputDir + '/' + 'pagerank_dependents.png'
    plt.savefig(outputPath)

scatter_pr_ndep(save=True, show=False, verbose=True)

