
import matplotlib.pyplot as plt
import math as math

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

def scatter_pr_ndep(n, save=True, show=False, verbose=False, xmin=0,xmax=10000,ymin=0,ymax=0.25):
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
  plt.title('Importance vs. Importance')
  plt.xlabel('# dependents')
  plt.ylabel('page rank')
  plt.scatter(nDeps, nPrs)
  #plt.yscale('log')
  #plt.xscale('log')
  plt.xlim(xmin=xmin, xmax=xmax)
  plt.ylim(ymin=ymin, ymax=ymax)
  if show: plt.show()
  if save:
    outputPath = outputDir + '/' + 'importance_zoom/importance_zoom_' + str(n) + '.png'
    plt.savefig(outputPath, dpi=720)

def generate_zoom(nFrames=60, xTerm=10, xInit=10000):
  rate = (float(xTerm)/xInit) ** (1.0/nFrames)
  xSeq = [xInit * (rate**n) for n in range(nFrames)]
  yInit = 0.25 * (xInit / 10000)
  yTerm = 0.25 * (xTerm / 10000)
  ySeq = [0.25 * (x / 10000) for x in xSeq]
  for (n,(x,y)) in enumerate(zip(xSeq,ySeq)):
    print(str((n,(x,y))) + ' of ' + str(nFrames))
    scatter_pr_ndep(n, save=True, show=False, verbose=False, xmin=0, xmax=x, ymin=0, ymax=y)

generate_zoom(nFrames=15)
