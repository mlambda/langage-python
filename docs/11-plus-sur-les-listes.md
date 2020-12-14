# Plus sur les listes{#sec:plus-sur-les-listes}

Nous avons vu les listes dès le +@sec:listes et les avons largement utilisées depuis le début de ce cours. Dans ce chapitre nous allons plus loin avec les méthodes associées aux listes, ainsi que d'autres caractéristiques très puissantes telles que les tests d'appartenance ou les listes de compréhension.

## Méthodes associées aux listes

Comme pour les chaînes de caractères, les listes possèdent de nombreuses méthodes qui leur sont propres et qui peuvent se révéler très pratiques. On rappelle qu'une méthode est une fonction qui agit sur l'objet auquel elle est attachée par un point.

### `.append()`

La méthode `.append()`, que l'on a déjà vu au +@sec:listes, ajoute un élément à la fin d'une liste&nbsp;:

```python
>>> a = [1, 2, 3]
>>> a.append(5)
>>> a
[1, 2, 3, 5]
```

qui est équivalent à&nbsp;:

```python
>>> a = [1, 2, 3]
>>> a = a + [5]
>>> a
[1, 2, 3, 5]
```

Conseil&nbsp;: préférez la version avec .append() qui est plus compacte et facile à lire.

### `.insert()`

La méthode `.insert()` insère un objet dans une liste avec un indice déterminé&nbsp;:

```python
>>> a = [1, 2, 3]
>>> a.insert(2, -15)
>>> a
[1, 2, -15, 3]
```

### `del`

L'instruction `del` supprime un élément d'une liste à un indice déterminé&nbsp;:

```python
>>> a = [1, 2, 3]
>>> del a[1]
>>> a
[1, 3]
```

<div class="remarque">
Contrairement aux autres méthodes associées aux listes, `del` est une instruction générale de Python, utilisable pour d'autres objets que des listes. Celle-ci ne prend pas de parenthèse.
</div>

### `.remove()`

La méthode `.remove()` supprime un élément d'une liste à partir de sa valeur&nbsp;:

```python
>>> a = [1, 2, 3]
>>> a.remove(3)
>>> a
[1, 2]
```

### `.sort()`

La méthode `.sort()` trie une liste&nbsp;:

```python
>>> a = [3, 1, 2]
>>> a.sort()
>>> a
[1, 2, 3]
```

### `.reverse()`

La méthode `.reverse()` inverse une liste&nbsp;:

```python
>>> a = [3, 1, 2]
>>> a.reverse()
>>> a
[2, 1, 3]
```

### `.count()`

La méthode `.count()` compte le nombre d'éléments (passés en argument) dans une liste&nbsp;:

```python
>>> a = [1, 2, 4, 3, 1, 1]
>>> a.count(1)
3
>>> a.count(4)
1
>>> a.count(23)
0
```

### Particularités des méthodes associées aux listes

De nombreuses méthodes ci-dessus (`.append()`, `.sort()`, etc.) modifient la liste mais ne renvoient rien, c'est-à-dire qu'elles ne renvoient pas d'objet récupérable dans une variable. Il s'agit d'un exemple d'utilisation de méthode (donc de fonction particulière) qui fait une action mais qui ne renvoie rien. Pensez-y dans vos utilisations futures des listes.

Certaines méthodes ou instructions des listes décalent les indices d'une liste (par exemple `.insert()`, `del`).

Enfin, pour obtenir une liste exhaustive des méthodes disponibles pour les listes, utilisez la fonction `dir(ma_liste)` (`ma_liste` étant une liste).

## Construction d'une liste par itération

La méthode `.append()` est très pratique car on peut l'utiliser pour construire une liste au fur et à mesure des itérations d'une boucle.

Pour cela, il est commode de définir préalablement une liste vide de la forme `maliste = []`. Voici un exemple où une chaîne de caractères est convertie en liste&nbsp;:

```python
>>> seq = "CAAAGGTAACGC"
>>> seq_list = []
>>> seq_list
[]
>>> for base in seq:
...   seq_list.append(base)
...
>>> seq_list
['C', 'A', 'A', 'A', 'G', 'G', 'T', 'A', 'A', 'C', 'G', 'C']
```

Remarquez que dans cet exemple, vous pouvez directement utiliser la fonction `list()` qui prend n'importe quel objet séquentiel (liste, chaîne de caractères, …) et qui renvoie une liste&nbsp;:

```python
>>> seq = "CAAAGGTAACGC"
>>> list(seq)
['C', 'A', 'A', 'A', 'G', 'G', 'T', 'A', 'A', 'C', 'G', 'C']
```

Cette méthode est certes plus simple, mais il arrive parfois qu'on doive utiliser des boucles tout de même, comme lorsqu'on lit un fichier. On rappelle que l'instruction `list(seq)` convertit un objet de type chaîne de caractères en un objet de type liste (il s'agit donc d'une opération de *casting*). De même que `list(range(10))` convertit un objet de type range en un objet de type list.

## Test d'appartenance

L'opérateur `in` teste si un élément fait partie d'une liste.

```python
liste = [1, 3, 5, 7, 9]
>>> 3 in liste
True
>>> 4 in liste
False
>>> 3 not in liste
False
>>> 4 not in liste
True
```

La variation avec `not` permet, *a contrario*, de vérifier qu'un élément n'est pas dans une liste.

## Copie de listes

Il est très important de savoir que l'affectation d'une liste (à partir d'une liste préexistante) crée en réalité une référence et non une copie&nbsp;:

```python
>>> x = [1, 2, 3]
>>> y = x
>>> y
[1, 2, 3]
>>> x[1] = -15
>>> x
[1, -15, 3]
>>> y
[1, -15, 3]
```

Vous voyez que la modification de `x` modifie `y` aussi&nbsp;! Pour comprendre ce qui se passe nous allons de nouveau utiliser le site *Python Tutor* avec cet exemple (+@fig:copy-list)&nbsp;:

![Copie de liste.](img/copy-list.png){#fig:copy-list}

Techniquement, Python utilise des pointeurs (comme dans le langage de programmation C) vers les mêmes objets. *Python Tutor* l'illustre avec des flèches qui partent des variables `x` et `y` et qui pointent vers la même liste. Donc, si on modifie la liste `x`, la liste `y` est modifiée de la même manière. Rappelez-vous de ceci dans vos futurs programmes car cela pourrait avoir des effets désastreux&nbsp;!

Pour éviter ce problème, il va falloir créer une copie explicite de la liste initiale. Observez cet exemple&nbsp;:

```python
>>> x = [1, 2, 3]
>>> y = x[:]
>>> x[1] = -15
>>> y
[1, 2, 3]
```

L'instruction `x[:]` a créé une copie «&nbsp;à la volée&nbsp;» de la liste `x`. Vous pouvez utiliser aussi la fonction `list()` qui renvoie explicitement une liste:

```python
>>> x = [1, 2, 3]
>>> y = list(x)
>>> x[1] = -15
>>> y
[1, 2, 3]
```

Si on regarde à nouveau dans *Python Tutor* (@fig:copy-list2), on voit clairement que l'utilisation d'une tranche `[:]` ou de la fonction `list()` crée des copies explicites. Chaque flèche pointe vers une liste différente, indépendante des autres.

![Copie de liste avec une tranche `[:]` et la fonction `list()`.](img/copy-list2.png){#fig:copy-list2}

Attention, les deux astuces précédentes ne fonctionnent que pour les listes à une dimension, autrement dit les listes qui ne contiennent pas elles-mêmes d'autres listes. Voyez par exemple&nbsp;:

```python
>>> x = [[1, 2], [3, 4]]
>>> x
[[1, 2], [3, 4]]
>>> y = x[:]
>>> x[1][1] = 55
>>> x
[[1, 2], [3, 55]]
>>> y
[[1, 2], [3, 55]]
```

et

```python
>>> y = list(x)
>>> x[1][1] = 77
>>> x
[[1, 2], [3, 77]]
>>> y
[[1, 2], [3, 77]]
```

La méthode de copie qui fonctionne à tous les coups consiste à appeler la fonction `deepcopy()` du module `copy`.

```python
>>> import copy
>>> x = [[1, 2], [3, 4]]
>>> x
[[1, 2], [3, 4]]
>>> y = copy.deepcopy(x)
>>> x[1][1] = 99
>>> x
[[1, 2], [3, 99]]
>>> y
[[1, 2], [3, 4]]
```

## Liste de compréhension

*Conseils&nbsp;:* pour les débutants, vous pouvez passer cette rubrique.

Une manière originale et très puissante de générer des listes est la compréhension de listes. Pour plus de détails, consultez à ce sujet le site de [Python](http://www.python.org/dev/peps/pep-0202/) et celui de [Wikipédia](http://fr.wikipedia.org/wiki/Comprehension_de_liste).

Voici quelques exemples.

### Nombres pairs compris entre 0 et 30{-}

```python
>>> print([i for i in range(31) if i % 2 == 0])
[0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
```

### Jeu sur la casse des mots d'une phrase{-}

```python
>>> message = "Python est puissant !"
>>> words = message.split()
>>> print([(word.upper(), len(word)) for word in words])
[('PYTHON', 6), ('EST', 3), ('PUISSANT', 8), ('!', 1)]
```

## Travaux pratiques

Les travaux pratiques sont disponibles [en ligne](https://colab.research.google.com/drive/1Cm9B7BMM_dyekeBanDFUhekuJLqQr2Fr#forceEdit=true&sandboxMode=true).
