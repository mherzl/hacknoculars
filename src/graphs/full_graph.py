import networkx as nx
from random import sample
import matplotlib.pyplot as plt

dependenciesPath = 'data/clean_dependencies.txt'
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

def remove_acme_everything(dd):
  r = dict(dd)
  key = 'acme-everything'
  del r[key]
  return r

def dic_percent(d,pct):
  kys = d.keys()
  l_new = int(len(kys) * pct)
  k_new = sample(kys, l_new)
  print("new length is: " + str(len(k_new)))
  print("out of: " + str(len(kys)))
  d_new = {k:d[k] for k in k_new}
  return d_new

def full_graph(pct):
  depDic = remove_acme_everything(dependencies_dic())
  depDic = dic_percent(depDic, pct)
  g = nx.DiGraph()
  g = nx.Graph()
  for a in depDic.keys():
    for b in depDic[a]:
      g.add_edge(a,b)
  return g

def show_full_graph(pct=1, show=False, save=True):
  g = full_graph(pct)
  nx.draw_networkx(g,
    with_labels=False,
    node_size=10,
    alpha=0.5,
    linewidths=0,
    width=0.1,
    )
  #nx.draw(g)
  title = str(100*pct) + '% of dependency graph'
  plt.title(title)
  if save: plt.savefig(outputDir + '/' + 'full_plot.png')
  if show: plt.show()

show_full_graph(pct=0.1, show=True)

