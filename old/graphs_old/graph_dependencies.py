
import matplotlib.pyplot as plt

def unique_list(list):
  ans = []
  for l in list:
    if l not in ans:
      ans.append(l)
  return ans

def dependency_dict():
  filePath = '../package_dependencies.txt'
  with open(filePath) as f:
    content = f.read().splitlines()
    content_words = [unique_list(x.split()) for x in content]
    ans = {}
    for line in content_words:
      ans[line[0]] = line[1:]
    return ans

def hist_package_dependencies(dd, show=False, bins='auto'):
  values = dd.values()
  nDependencies = [len(x) for x in values]
  if bins == 'auto':
    bins = max([len(x) for x in values])
  plt.title('Number of packages with each number of immediate dependencies')
  plt.xlabel('# dependencies')
  plt.ylabel('# packages')
  plt.hist(nDependencies, bins=bins)
  if show: plt.show()

def bar_package_dependencies(dd, show=False):
  values = dd.values()
  nDependencies = [len(x) for x in values]
  nDependencyRange = range(0, 1 + max(nDependencies))
  def countWithNDependencies(n):
    return len(filter(lambda x: x==n, nDependencies))
  nPackagesByNDependencies = [countWithNDependencies(d) for d in nDependencyRange]
  plt.title('Number of packages with each number of immediate dependencies')
  plt.xlabel('# dependencies')
  plt.ylabel('# packages')
  plt.bar(nDependencyRange, nPackagesByNDependencies)
  if show: plt.show()

def remove_acme_everything(dd):
  r = dict(dd)
  key = 'acme-everything'
  del r[key]
  return r

def print_limits(dd):
  values = dd.values()
  nDependencies = [len(x) for x in values]
  maxDependencies = max(nDependencies)
  countMaxDependencies = len(filter(lambda x: x==maxDependencies, nDependencies))
  maxDependenciesPackages = filter(lambda x: len(dd[x])==maxDependencies, dd.keys())
  print 'there are ' + str(len(values)) + 'packages.'
  print 'the packages with the most dependencies are: ' + str(maxDependenciesPackages)
  print 'which are dependent on ' + str(maxDependencies) + ' packages.'
  dd_keys2 = filter(lambda x: len(dd[x]) != maxDependencies, dd.keys())
  dd2 = {key:dd[key] for key in dd_keys2}
  values2 = dd2.values()
  nDependencies2 = [len(x) for x in values2]
  maxDependencies2 = max(nDependencies2)
  countMaxDependencies2 = len(filter(lambda x: x==maxDependencies2, nDependencies2))
  maxDependenciesPackages2 = filter(lambda x: len(dd2[x])==maxDependencies2, dd2.keys())
  print 'the package with the second-most number of dependencies is ' + str(maxDependenciesPackages2)
  print 'which depend on ' + str(maxDependencies2) + ' packages'

def nDependents(dd):
  nDep = {key:0 for key in dd.keys()}
  non_packages = []
  non_dependencies = []
  for key in dd:
    for pac in dd[key]:
      if pac in dd.keys():
        #nDep[pac] = nDep[pac] + 1
        nDep[pac] += 1
      else:
        non_packages.append(key)
        non_dependencies.append(pac)
  return nDep

def remove_unclean(dd):
  ans = {}
  for key in dd.keys():
    flag=True
    for pac in dd[key]:
      if pac not in dd:
        flag=False
    if flag:
      ans[key] = dd[key][:]
  return ans

def remove_zero_dependents(dd):
  nDep = nDependents(dd)
  keys_filtered = filter(lambda k: nDep[k] != 0, dd.keys())
  ans = {key: dd[key] for key in keys_filtered}
  return ans

def remove_gtx_dependents(dd):
  x = 40
  nDep = nDependents(dd)
  keys_filtered = filter(lambda k: nDep[k] <= x, dd.keys())
  ans = {key: dd[key] for key in keys_filtered}
  return ans

def hist_package_dependents(dd, show=False, bins='auto'):
  nDep = nDependents(dd)
  nDependentsList = nDep.values()
  if bins == 'auto':
    bins = max(nDependentsList)
  plt.hist(nDependentsList, bins = bins)
  #plt.xscale('log')
  plt.title('Number of packages with each number of immediate dependents')
  plt.xlabel('# dependents')
  plt.ylabel('# packages')
  if show: plt.show()

def bar_package_dependents(dd, show=False):
  nDep = nDependents(dd)
  nDependentsList = nDep.values()
  nDependentsRange = range(0, 1 + max(nDependentsList))
  def nWithNDependents(d):
    return len(filter(lambda n: n==d, nDependentsList))
  nDependentFrequency = [nWithNDependents(n) for n in nDependentsRange]
  plt.bar(nDependentsRange, nDependentFrequency)
  #plt.xscale('log')
  plt.title('Number of packages with each number of immediate dependents')
  plt.xlabel('# dependents')
  plt.ylabel('# packages')
  if show: plt.show()

def print_dependent_limits(dd):
  nDep = nDependents(dd)
  maxDep = max(nDep.values())
  print 'the most dependencies is ' + str(maxDep)
  maxDepPac = filter(lambda key: nDep[key]==maxDep, nDep.keys())
  print 'the packages with that many dependents are ' + str(maxDepPac)
  keys2 = filter(lambda key: key not in maxDepPac, nDep.keys())
  nDep2 = {key:nDep[key] for key in keys2}
  maxDep2 = max(nDep2.values())
  print 'the second most number of dependents is ' + str(maxDep2)
  maxDepPac2 = filter(lambda key: nDep2[key]==maxDep2, nDep2.keys())
  print 'the second most dependents is ' + str(maxDepPac2)
  max_pac_with_dep = 0
  max_freq = None
  for dep in range(0,maxDep + 1):
    count = 0
    for key in nDep.keys():
      if nDep[key] == dep:
        count += 1
    if count > max_pac_with_dep:
      max_pac_with_dep = count
      max_freq = dep
  print 'the most number of packages with a given dependent count is: ' + str(max_pac_with_dep)
  print 'and that count is ' + str(max_freq) + ' dependents'
      

if __name__=='__main__':
  dd = remove_unclean(dependency_dict())
  dd2 = remove_acme_everything(dd)
  #print_limits(dd)
  #print dd['hsc3-graphs']
  #hist_package_dependencies(remove_acme_everything(dd), show=True)
  #bar_package_dependencies(remove_acme_everything(dd), show=True)
  #hist_package_dependents(remove_gt100_dependents(dd), show=True)
  bar_package_dependents(remove_gtx_dependents(dd2), show=True)
  #bar_package_dependents(dd2, show=True)
  #bar_package_dependents(remove_gt100_dependents(remove_zero_dependents(dd2)), show=True)
  #print_dependent_limits(dd)

