
import matplotlib.pyplot as plt

dependenciesPath = 'data/clean_dependencies.txt'
outputDir = 'plots'

def dependencies_dic():
  path = dependenciesPath
  with open(path) as f:
    content = f.read().splitlines()
    content_words = [e.split() for e in content]
    depDic = {}
    for line in content_words:
      depDic[line[0]] = line[1:]
    return depDic

def remove_acme_everything(dd):
  """
  input: dictionary of packages and dependency lists
  output: same dictionary but with key: acme-everything removed
  explanation: acme-everything is a joke package intended to depend on everything
  """
  r = dict(dd)
  key = 'acme-everything'
  del r[key]
  return r

def dependency_hist(save=True, show=False, verbose=False):
  depDic = remove_acme_everything(dependencies_dic())
  nDepsList = [len(e) for e in depDic.values()]
  nDepRange = range(0, 1 + max(nDepsList))
  if verbose:
    print('max number of dependencies is: ' + str(max(nDepsList)))
  def nDepFreq(n):
    return len(filter(lambda x: x==n, nDepsList))
  nDepFreqOverRange = [nDepFreq(d) for d in nDepRange]
  plt.title('Number of immediate dependencies')
  plt.xlabel('# dependencies')
  plt.ylabel('# packages')
  plt.bar(nDepRange, nDepFreqOverRange)
  #plt.yscale('log')
  #plt.xscale('log')
  if show: plt.show()
  if save: plt.savefig(outputDir + '/' + 'dependency_hist.png', dpi=720)

dependency_hist(save=True, show=False)
