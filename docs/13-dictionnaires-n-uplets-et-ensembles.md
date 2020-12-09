# Dictionnaires, n-uplets et ensembles{#sec:dictionnaires-n-uplets-et-ensembles}

Jusqu'à maintenant nous avons vu et manipulé le type d'objet séquentiel le plus classique&nbsp;: les listes. On se rappelle qu'elles sont modifiables, ordonnées et itérables. Dans ce chapitre nous allons voir trois nouveaux types d'objet séquentiel avec des propriétés différentes&nbsp;: les dictionnaires, les n-uplets et les ensembles.

<div class="remarque">
Les objets séquentiels peuvent être aussi appelés parfois conteneurs (*containers* en anglais).
</div>

## Dictionnaires

### Définition

Les **dictionnaires** se révèlent très pratiques lorsque vous devez manipuler des structures complexes à décrire et que les listes présentent leurs limites. Les dictionnaires sont des collections non ordonnées d'objets, c'est-à-dire qu'il n'y a pas de notion d'ordre (*i.e.* pas d'indice). On accède aux **valeurs** d'un dictionnaire par des **clés**. Ceci semble un peu confus&nbsp;? Regardez l'exemple suivant&nbsp;:

```python
>>> ani1 = {}
>>> ani1["nom"] = "girafe"
>>> ani1["taille"] = 5.0
>>> ani1["poids"] = 1100
>>> ani1
{'nom': 'girafe', 'taille': 5.0, 'poids': 1100}
```

En premier, on définit un dictionnaire vide avec les accolades `{}` (tout comme on peut le faire pour les listes avec `[]`). Ensuite, on remplit le dictionnaire avec différentes clés (`"nom"`, `"taille"`, `"poids"`) auxquelles on affecte des valeurs (`"girafe"`, `5.0`, `1100`). Vous pouvez mettre autant de clés que vous voulez dans un dictionnaire (tout comme vous pouvez ajouter autant d'éléments que vous voulez dans une liste).

<div class="remarque">
Un dictionnaire est affiché sans ordre particulier.
</div>

On peut aussi initialiser toutes les clés et les valeurs d'un dictionnaire en une seule opération&nbsp;:

```python
>>> ani2 = {"nom": "singe", "poids": 70, "taille": 1.75}
```

Mais rien ne nous empêche d'ajouter une clé et une valeur supplémentaire&nbsp;:

```python
>>> ani2["age"] = 15
```

Pour récupérer la valeur associée à une clé donnée, il suffit d'utiliser la syntaxe suivante `dictionnaire["cle"]`. Par exemple&nbsp;:

```python
>>> ani1["taille"]
5.0
```

<div class="remarque">
Toutes les clés de dictionnaire utilisées jusqu'à présent étaient des chaînes de caractères. Rien n'empêche d'utiliser d'autres types d'objets comme des entiers (voire même des n-uplets, cf. rubrique suivante), cela peut parfois s'avérer très utile.

Néanmoins, nous vous conseillons, autant que possible, d'utiliser systématiquement des chaînes de caractères pour vos clés de dictionnaire.
</div>

Après ce premier tour d'horizon, on voit tout de suite l'avantage des dictionnaires. Pouvoir retrouver des éléments par des noms (clés) plutôt que par des indices. Les humains retiennent mieux les noms que les chiffres. Ainsi, l'usage des dictionnaires rend en général le code plus lisible. Par exemple, si nous souhaitions stocker les coordonnées $(x, y, z)$ d'un point dans l'espace&nbsp;: `coords = [0, 1, 2]` pour la version liste, `coords = {"x": 0, "y": 1, "z": 2}` pour la version dictionnaire. Un lecteur comprendra tout de suite que `coords["z"]` contient la coordonnée $z$, ce sera moins intuitif avec `coords[2]`.

### Itération sur les clés pour obtenir les valeurs

Il est possible d'obtenir toutes les valeurs d'un dictionnaire à partir de ses clés&nbsp;:

```python
>>> ani2 = {'nom':'singe', 'poids':70, 'taille':1.75}
>>> for key in ani2:
...     print(key, ani2[key])
...
poids 70
nom singe
taille 1.75
```

### Méthodes `.keys()`, `.values()` et `.items()`

Les méthodes `.keys()` et `.values()` renvoient, comme vous pouvez vous en doutez, les clés et les valeurs d'un dictionnaire&nbsp;:

```python
>>> ani2.keys()
dict_keys(['poids', 'nom', 'taille'])
>>> ani2.values()
dict_values([70, 'singe', 1.75])
```

Les mentions `dict_keys` et `dict_values` indiquent que nous avons à faire à des objets un peu particuliers. Ils ne sont pas indexables (on ne peut pas retrouver un élément par indice, par exemple `dico.keys()[0]` renverra une erreur). Si besoin, nous pouvons les transformer en liste avec la fonction `list()`&nbsp;:

```python
>>> ani2.values()
dict_values(['singe', 70, 1.75])
>>> list(ani2.values())
['singe', 70, 1.75]
```

Toutefois, ce sont des objets «&nbsp;itérables&nbsp;», donc utilisables dans une boucle.

*Conseil&nbsp;:* pour les débutants, vous pouvez sauter cette fin de rubrique.

Enfin, il existe la méthode `.items()` qui renvoie un nouvel objet `dict_items`&nbsp;:

```python
>>> dico = {0: 't', 1: 'o', 2: 't', 3: 'o'}
>>> dico.items()
dict_items([(0, 't'), (1, 'o'), (2, 't'), (3, 'o')])
```

Celui-ci n'est pas indexable (on ne peut pas retrouver un élément par un indice) mais il est itérable&nbsp;:

```python
>>> dico.items()[2]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'dict_items' object is not subscriptable
>>> for key, val in dico.items():
...    print(key, val)
...
0 t
1 o
2 t
3 o
```

Notez la syntaxe particulière qui ressemble à la fonction `enumerate()` vue au +@sec:boucles-et-comparaisons. On itère à la fois sur `key` et sur `val`. On verra plus bas que cela peut-être utile pour construire des compréhensions de dictionnaire.

### Existence d'une clé

Pour vérifier si une clé existe dans un dictionnaire, on peut utiliser le test d’appartenance avec l'instruction `in` qui renvoie un booléen&nbsp;:

```{.python .number-lines}
>>> if "poids" in ani2:
...     print("La clé 'poids' existe pour ani2")
...
La clé 'poids' existe pour ani2
>>> if "age" in ani2:
...     print("La clé 'age' existe pour ani2")
...
>>>
```

Dans le second test (lignes 5 à 7), le message n'est pas affiché car la clé `age` n'est pas présente dans le dictionnaire `ani2`.

### Liste de dictionnaires

En créant une liste de dictionnaires qui possèdent les mêmes clés, on obtient une structure qui ressemble à une base de données&nbsp;:

```python
>>> animaux = [ani1, ani2]
>>> animaux
[{'nom': 'girafe', 'poids': 1100, 'taille': 5.0}, {'nom': 'singe',
'poids': 70, 'taille': 1.75}]
>>>
>>> for ani in animaux:
...     print(ani['nom'])
...
girafe
singe
```

Vous constatez ainsi que les dictionnaires permettent de gérer des structures complexes de manière plus explicite que les listes.

### Fonction `dict()`

*Conseil&nbsp;:* Pour les débutants vous pouvez sauter cette rubrique.

La fonction `dict()` va convertir l'argument qui lui est passé en dictionnaire. Il s'agit donc d'une fonction de *casting* comme `int()`, `str()`, etc. Toutefois, l'argument qui lui est passé doit avoir une forme particulière&nbsp;: un objet séquentiel contenant d'autres objets séquentiels de 2 éléments. Par exemple, une liste de listes de 2 éléments&nbsp;:

```python
>>> liste_animaux = [["girafe", 2], ["singe", 3]]
>>> dict(liste_animaux)
{'girafe': 2, 'singe': 3}
```

Ou un n-uplet de n-uplets de 2 éléments (cf. rubrique suivante pour la définition d'un n-uplet), ou encore une combinaison liste / n-uplets&nbsp;:

```python
>>> tuple_animaux = (("girafe", 2), ("singe", 3))
>>> dict(tuple_animaux)
{'girafe': 2, 'singe': 3}
>>>
>>> dict([("girafe", 2), ("singe", 3)])
{'girafe': 2, 'singe': 3}
```

Si un des sous-éléments a plus de 2 éléments (ou moins), Python renvoie une erreur&nbsp;:

```python
>>> dict([("girafe", 2), ("singe", 3, 4)])
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: dictionary update sequence element #1 has length 3; 2 is required
```

## n-uplets

### Définition

Les **n-uplets** (*tuples* en anglais) correspondent aux listes à la différence qu'ils sont **non modifiables**. On a vu par exemple dans le +@sec:plus-sur-les-listes que les listes pouvaient être modifiées sur place dans une fonction, de manière peu explicite. Les n-uplets s'affranchissent de ce problème puisqu'ils sont non modifiables. Dans la pratique, on les définit avec des parenthèses au lieu des crochets&nbsp;:

```python
>>> x = (1, 2, 3)
>>> x
(1, 2, 3)
>>> x[2]
3
>>> x[0:2]
(1, 2)
>>> x[2] = 15
Traceback (innermost last):
File "<stdin>", line 1, in ?
TypeError: object doesn't support item assignment
```

L'affectation et l'indiçage fonctionnent comme avec les listes. Mais si on essaie de modifier un des éléments du tuple, Python renvoie un message d'erreur. Si vous voulez ajouter un élément (ou le modifier), vous devez créer un autre tuple&nbsp;:

```python
>>> x = (1, 2, 3)
>>> x + (2,)
(1, 2, 3, 2)
```

<div class="remarque">
Pour utiliser un n-uplet d'un seul élément, vous devez utiliser une syntaxe avec une virgule `(element,)`, ceci pour éviter une ambiguïté avec une simple expression.

Autre particularité des tuples, il est possible d'en créer de nouveaux sans les parenthèses, dès lors que ceci ne pose pas d'ambiguïté avec une autre expression&nbsp;:

```python
>>> x = (1, 2, 3)
>>> x
(1, 2, 3)
>>> x = 1, 2, 3
>>> x
(1, 2, 3)
```

Toutefois, nous vous conseillons d'utiliser systématiquement les parenthèses afin d'éviter les confusions.
</div>

Enfin, on peut utiliser la fonction `tuple(sequence)` qui fonctionne exactement comme la fonction `list()`, c'est-à-dire qu'elle prend en argument un objet séquentiel et renvoie le tuple correspondant (opération de *casting*)&nbsp;:

```python
>>> tuple([1, 2, 3])
(1, 2, 3)
>>> tuple("ATGCCGCGAT")
('A', 'T', 'G', 'C', 'C', 'G', 'C', 'G', 'A', 'T')
```

<div class="remarque">
Les listes, les dictionnaires et les tuples sont des objets qui peuvent contenir des collections d'autres objets. On peut donc construire des listes qui contiennent des dictionnaires, des tuples ou d'autres listes, mais aussi des dictionnaires contenant des tuples, des listes, etc.
</div>

### Itérations sur plusieurs valeurs à la fois

En fait, nous avons déjà croisé les n-uplets avec la fonction `enumerate()` dans le +@sec:boucles-et-comparaisons. Cette dernière permettait d'itérer **en même temps** sur les indices et les éléments d'une liste&nbsp;:

```python
>>> for i, elt in enumerate([75, -75, 0]):
...     print(i, elt)
...
0 75
1 -75
2 0
>>> for obj in enumerate([75, -75, 0]):
...     print(obj, type(obj))
...
(0, 75) <class 'tuple'>
(1, -75) <class 'tuple'>
(2, 0) <class 'tuple'>
```

En fin de compte, la fonction `enumerate()` produit une série de n-uplets. Pouvoir séparer `i` et `elt` dans la boucle est possible du fait que Python autorise l'affectation multiple du style `i, elt = 0, 75` (cf. rubrique suivante).

Dans le même ordre d'idée, nous avons vu à la rubrique précédente la méthode `.dict_items()` qui permettait d'itérer sur des couples clé / valeur d'un dictionnaire&nbsp;:

```python
>>> dico = {"pinson": 2, "merle": 3}
>>> for key, val in dico.items():
...     print(key, val)
...
pinson 2
merle 3
>>> for obj in dico.items():
...     print(obj, type(obj))
...
('pinson', 2) <class 'tuple'>
('merle', 3) <class 'tuple'>
```

On voit que cette méthode `.dict_items()` itère comme `enumerate()` sur une série de n-uplets.

Sur la même base, on peut finalement itérer sur 3 valeurs en même temps à partir d'une liste de triplets&nbsp;:

```python
>>> liste = [(i, i + 1, i + 2) for i in range(5, 8)]
>>> liste
[(5, 6, 7), (6, 7, 8), (7, 8, 9)]
>>> for x, y, z in liste:
...     print(x, y, z)
...
5 6 7
6 7 8
7 8 9
```

On pourrait concevoir la même chose sur 4 éléments, ou finalement autant que l'on veut. La seule restriction est d'avoir une correspondance systématique entre le nombre de variables d'itération (par exemple 3 ci-dessus avec `x, y, z`) et la longueur de chaque n-uplet de la liste sur laquelle on itère (chaque n-uplet a 3 éléments ci-dessus).

### Affectation multiple et le nom de variable `_`

L'affectation multiple est un mécanisme très puissant et important en Python. Pour rappel, il permet d'effectuer sur une même ligne plusieurs affectations en même temps, par exemple&nbsp;: `x, y, z = 1, 2, 3`. On voit que cette syntaxe correspond à un n-uplet de chaque côté de l'opérateur `=`. Notez qu'il serait possible de le faire également avec les listes&nbsp;: `[x, y, z] = [1, 2, 3]`. Toutefois, cette syntaxe est alourdie par la présence des crochets. On préfèrera donc la première syntaxe avec les n-uplets sans parenthèse.

<div class="remarque">
Nous avons appelé l'opération `x, y, z = 1, 2, 3` affectation multiple pour signifier que l'on affectait des valeurs à plusieurs variables en même temps. Toutefois, vous pourrez rencontrer aussi l'expression *tuple unpacking* que l'on pourrait traduire par «&nbsp;dépaquetage de n-uplet&nbsp;». Cela signifie que l'on décompose le n-uplet initial `1, 2, 3` en 3 variables différentes (comme si on vidait son sac à dos, d'où le terme dépaquetage&nbsp;!).
</div>

Nous avions croisé l'importance de l'affectation multiple dans le +@sec:fonctions lorsqu'une fonction renvoyait plusieurs valeurs.

```python
>>> def fct():
...     return 3, 14
...
>>> x, y = fct()
>>> print(x, y)
3 14
```

La syntaxe `x, y = fct()` permet de récupérer les 2 valeurs renvoyées par la fonction et de les affecter à la volée dans 2 variables différentes. Cela évite l'opération laborieuse de récupérer d'abord le tuple, puis de créer les variables en utilisant l'indiçage&nbsp;:

```python
>>> resultat = fct()
>>> resultat
(3, 14)
>>> x = resultat[0]
>>> y = resultat[1]
>>> print(x, y)
3 14
```

<div class="conseils">
Lorsqu'une fonction renvoie plusieurs valeurs sous forme de tuple, ce sera bien sûr la forme `x, y = fct()` qui sera privilégiée.
</div>

Quand une fonction renvoie plusieurs valeurs mais que l'on ne souhaite pas les utiliser toutes dans la suite du code, on peut utiliser le nom de variable `_` (*underscore*) pour indiquer que certaines valeurs ne nous intéressent pas&nbsp;:

```python
>>> def fct():
...     return 1, 2, 3, 4
...
>>> x, _, y, _ = fct()
>>> x
1
>>> y
3
```

Cela envoie le message à celui qui lit le code «&nbsp;je me fiche des valeurs récupérées dans ces variables `_`&nbsp;». Notez que l'on peut utiliser une ou plusieurs variables *underscores(s)*. Dans l'exemple ci-dessus, la 2ème et la 4ème variable renvoyées par la fonction seront ignorées dans la suite du code. Cela a le mérite d'éviter la création de variables dont on ne se sert pas.

<div class="remarque">
La variable `_` a une autre signication spéciale dans l'interpréteur interactif, elle prend automatiquement la dernière valeur affichée&nbsp;:

```python
>>> 3
3
>>> _
3
>>> "mésange"
'mésange'
>>> _
'mésange'
```

Attention, cela n'est vrai que dans l'interpréteur.
</div>

<div class="remarque">
Le *underscore* est couramment utilisé dans les noms de variable pour séparer les mots et être explicite, par exemple `racine_carree` ou `liste_notes`. On verra dans le chapitre 15 Bonnes pratiques en programmation Python que ce style de nommage est appelé *snake_case*. Toutefois, il faut éviter d'utiliser les *underscores* en début et/ou en fin de nom de variable (*i.e.* `_var`, `var_`, `__var`, `__var__`). On verra au chapitre 19 Avoir la classe avec les objets que ces *underscores* ont une signification particulière.
</div>

## Ensembles

Les conteneurs de type `set` (ensemble en français) représentent un autre type de structure de données qui peut se révéler très pratique. Ils ont la particularité d'être non ordonnés et de ne contenir qu'une seule copie maximum de chaque élément. Pour créer un nouvel ensemble on peut utiliser les accolades&nbsp;:

```{.python .number-lines}
>>> s = {1, 2, 3, 3}
>>> s
{1, 2, 3}
>>> type(s)
<class 'set'>
```

Notez que la répétition du `3` dans la définition du set en ligne 1 donne au final un seul `3` car chaque élément ne peut être présent qu'une seule fois. A quoi différencie-t-on un ensemble d'un dictionnaire alors que les deux utilisent des accolades&nbsp;? L'ensemble sera défini seulement par des valeurs `{val1, val2, ...}` alors que le dictionnaire aura toujours des couples clé / valeur `{clé1: val1, clé2: val2, ...}`.

Cela induit une ambiguité pour les dictionnaires et ensembles vides&nbsp;: les deux pourraient être notés `{}`. Python a tranché et considère `{}` comme un dictionnaire vide. On utilisera donc la fonction interne à Python `set()` pour générer un nouvel ensemble. Celle-ci prend en argument n'importe quel objet itérable et le convertit en ensemble (opération de *casting*)&nbsp;:

```python
>>> set([1, 2, 4, 1])
{1, 2, 4}
>>> set((2, 2, 2, 1))
{1, 2}
>>> set(range(5))
{0, 1, 2, 3, 4}
>>> set({"clé1": 1, "clé2": 2})
{'clé1', 'clé2'}
>>> set(["ti", "to", "to"])
{'ti', 'to'}
>>> set("Maître corbeau sur un arbre perché")
{'h', 'u', 'o', 'b', ' ', 'M', 'a', 'p', 'n', 'e', 'é', 'c', 'î', 's', 't', 'r'}
```

Nous avons dit plus haut que les sets ne sont pas ordonnés, il est donc impossible de récupérer un élément par sa position. Par contre, les sets sont itérables&nbsp;:

```python
>>> s = {1, 2, 4, 1}
>>> s[1]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'set' object is not subscriptable
>>> for elt in s:
...     print(elt)
...
1
2
4
```

Les conteneurs de type `set` sont très utiles pour rechercher les éléments uniques d'une suite d'éléments. Cela revient à éliminer tous les doublons. Par exemple&nbsp;:

```python
>>> import random as rd
>>> l = [rd.randint(0, 9) for i in range(10)]
>>> l
[7, 9, 6, 6, 7, 3, 8, 5, 6, 7]
>>> set(l)
{3, 5, 6, 7, 8, 9}
```

On peut bien sûr transformer dans l'autre sens un ensemble en liste. Cela permet par exemple d'éliminer les doublons de la liste initiale tout en récupérant une liste à la fin&nbsp;:

```python
>>> list(set([7, 9, 6, 6, 7, 3, 8, 5, 6, 7]))
[3, 5, 6, 7, 8, 9]
```

On peut faire des choses très puissantes. Par exemple, un compteur de lettres en combinaison avec une liste de compréhension, le tout en une ligne&nbsp;!

```python
>>> seq = "atctcgatcgatcgcgctagctagctcgccatacgtacgactacgt"
>>> set(seq)
{'c', 'g', 't', 'a'}
>>> [(base, seq.count(base)) for base in set(seq)]
[('c', 15), ('g', 10), ('t', 11), ('a', 10)]
```

Les ensembles permettent aussi l'évaluation d'union ou d'intersection mathématiques en conjonction avec les opérateurs respectivement `|` et `&`&nbsp;:

```python
>>> l = [3, 3, 5, 1, 3, 4, 1, 1, 4, 4]
>>> l2 = [3, 0, 5, 3, 3, 1, 1, 1, 2, 2]
>>> set(l) & set(l2)
{1, 3, 5}
>>> set(l) | set(l2)
{0, 1, 2, 3, 4, 5}
```

Enfin, notez qu'il existe la classe `frozenset` qui est le pendant non modifiable de `set`. Elle est très intéressante pour limiter les possibilités de bugs quand vous savez qu'un ensemble ne doit pas être modifié&nbsp;!

<div class="conseils">
Pour aller plus loin, vous pouvez consulter deux articles sur les sites [programiz](https://www.programiz.com/python-programming/set) et [towardsdatascience](https://towardsdatascience.com/python-sets-and-set-theory-2ace093d1607).
</div>

## Compréhension de dictionnaires et d'ensemble

*Conseil&nbsp;:* pour les débutants, vous pouvez passer cette rubrique.

Nous avons vu au +@sec:plus-sur-les-fonctions les compréhensions de listes. Il est également possible de générer des dictionnaires par compréhension&nbsp;:

```python
>>> dico = {'a': 10, 'g': 10, 't': 11, 'c': 15}
>>> dico.items()
dict_items([('a', 10), ('g', 10), ('t', 11), ('c', 15)])
>>> {key: val * 2 for key, val in dico.items()}
{'a': 20, 'g': 20, 't': 22, 'c': 30}
>>>
>>> {key: val for key, val in enumerate("toto")}
{0: 't', 1: 'o', 2: 't', 3: 'o'}
>>>
>>> seq = "atctcgatcgatcgcgctagctagctcgccatacgtacgactacgt"
>>> {base: seq.count(base) for base in set(seq)}
{'a': 10, 'g': 10, 't': 11, 'c': 15}
```

Si vous souhaitez aller plus loin, vous pouvez consulter cet [article sur le site *Datacamp*](https://www.datacamp.com/community/tutorials/python-dictionary-comprehension).

Il est également possible de générer des ensembles par compréhension sur le même modèle que les listes de compréhension&nbsp;:

```python
>>> {i for i in range(10)}
{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
>>> {i ** 2 for i in range(10)}
{0, 1, 64, 4, 36, 9, 16, 49, 81, 25}
```

## Module `collections`

*Conseil&nbsp;:* pour les débutants, vous pouvez passer cette rubrique.

Le module `collections` contient d'autres types de conteneurs qui peuvent se révéler utiles, c'est une véritable mine d'or&nbsp;! Nous n'aborderons pas tous ces objets ici, mais nous pouvons citer tout de même certains d'entre eux si vous souhaitez aller un peu plus loin&nbsp;:

- les [dictionnaires ordonnés](https://docs.python.org/fr/3/library/collections.html#collections.OrderedDict) qui se comportent comme les dictionnaires classiques mais qui sont ordonnés ;
- les [`defaultdict`s](https://docs.python.org/fr/3/library/collections.html#collections.defaultdict) permettant de générer des valeurs par défaut quand on demande une clé qui n'existe pas (cela évite que Python génère une erreur) ;
- les [compteurs](https://docs.python.org/fr/3/library/collections.html#collections.Counter) dont un exemple est montré ci-dessous ;
- les [`namedtuple`s](https://docs.python.org/fr/3/library/collections.html#collections.namedtuple) que nous évoquerons au chapitre 19 Avoir la classe avec les objets.

L'objet `collection.Counter()` est particulièrement intéressant et facile à utiliser. Il crée des compteurs à partir d'objets itérables, par exemple&nbsp;:

```python
>>> import collections
>>> compo_seq = collections.Counter("aatctccgatcgatcgatcgatgatc")
>>> compo_seq
Counter({'a': 7, 't': 7, 'c': 7, 'g': 5})
>>> type(compo_seq)
<class 'collections.Counter'>
>>> compo_seq["a"]
7
>>> compo_seq["n"]
0
```

On voit que Python a automatiquement compté chaque atgc de la chaîne de caractères passée en argument&nbsp;! Cela crée un objet de type `Counter` qui se comporte ensuite comme un dictionnaire, à une exception près&nbsp;: si on appelle une clé qui n'existe pas dans l'itérable initiale (comme le `n` ci-dessus) cela renvoie 0.
