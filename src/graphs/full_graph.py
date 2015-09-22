import networkx as nx
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

def full_graph():
  depDic = remove_acme_everything(dependencies_dic())
  g = nx.DiGraph()
  for a in depDic.keys():
    for b in depDic[a]:
      g.add_edge(a,b)
  return g

def show_full_graph():
  g = full_graph()
  nx.draw(g)
  plt.show()

show_full_graph()
