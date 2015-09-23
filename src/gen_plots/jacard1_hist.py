
import matplotlib.pyplot as plt

jacard_matchesPath = 'data/jacard_matches.txt'
outputDir = 'plots'

def get_2highest_jacard():
  path = jacard_matchesPath
  with open(path) as f:
    content = f.read().splitlines()
    content_words = [e.split() for e in content]
    ans = [float(e[4]) for e in content_words]
    return ans

def dependency_hist(save=True, show=False, verbose=False, bins=0):
  jacList = get_2highest_jacard()
  if bins==0:
    unique = list(set(jacList))
    bins = int(len(unique) ** 0.5) * 2
  if verbose:
    print('max best similarity is: ' + str(max(jacList)))
    print('min best similarity is: ' + str(min(jacList)))
  plt.title('similarity of top match')
  plt.xlabel('similarity fraction')
  plt.ylabel('number of packages')
  plt.hist(jacList, bins=bins)
  if save: plt.savefig(outputDir + '/' + 'jacard1_hist.png', dpi=720)
  if show: plt.show()

dependency_hist(save=True, show=False, verbose=True)
