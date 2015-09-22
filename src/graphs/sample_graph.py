import networkx as nx
import matplotlib.pyplot as plt

dependenciesPath = 'data/sample/sampleDep.txt'
outputDir = 'graphs'

def dependencies_dic():
  path = dependenciesPath
  with open(path) as f:
    content = f.read().splitlines()
    content_words = [e.split() for e in content]
    depDic = {}
    for line in content_words:
      depDic[line[0]] = line[1:]
    return depDic

def sample_graph():
  depDic = dependencies_dic()
  g = nx.DiGraph()
  for a in depDic.keys():
    for b in depDic[a]:
      g.add_edge(a,b)
  return g

def show_sample_graph(show=False,save=True):
  g = sample_graph()
  nx.draw_networkx(
    g,
    with_labels=True,
    node_size=1000,
    alpha=1,
    linewidths=0,
    width=1,
    font_size=24
    )
  title = 'sample dependency graph'
  plt.title(title)
  if save: plt.savefig(outputDir + '/' + 'sample_graph.png')
  if show: plt.show()

show_sample_graph(show=True)
