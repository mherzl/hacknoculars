
import matplotlib.pyplot as plt

dependentsPath = 'data/dependents.txt'
outputDir = 'plots'

def dependents_dic():
  path = dependentsPath
  with open(path) as f:
    content = f.read().splitlines()
    content_words = [e.split() for e in content]
    depDic = {}
    for line in content_words:
      depDic[line[0]] = line[1:]
    return depDic

def remove_package(dd, name):
  """
  input: dictionary of packages and dependency lists
  output: same dictionary but with key: containers removed
  explanation: containers is the package with the highest number of dependents, 2790
  """
  r = dict(dd)
  key = name
  del r[key]
  return r

def dependent_hist(save=True, show=False, verbose=False):
  depDic = remove_package(remove_package(dependents_dic(), 'containers'), 'mtl')
  depDic = dependents_dic()
  nDepsList = [len(e) for e in depDic.values()]
  nDepRange = range(0, 1 + max(nDepsList))
  if verbose:
    maxDeps = max(nDepsList)
    print('max number of dependents is: ' + str(maxDeps))
    maxDepNames = []
    for k in depDic:
      if len(depDic[k]) == maxDeps:
        maxDepNames.append(k)
    print('the packages with that number of dependents is ' + str(maxDepNames))
  def nDepFreq(n):
    return len(filter(lambda x: x==n, nDepsList))
  nDepFreqOverRange = [nDepFreq(d) for d in nDepRange]
  plt.title('Number of packages with each number of immediate dependents')
  plt.xlabel('# dependents')
  plt.ylabel('# packages')
  plt.bar(nDepRange, nDepFreqOverRange)
  plt.yscale('log')
  plt.xscale('log')
  if show: plt.show()
  if save: plt.savefig(outputDir + '/' + 'dependent_hist.png')

dependent_hist(save=True, show=False, verbose=False)

