# Module *NumPy*{#sec:module-numpy}

Le module [*NumPy*](http://numpy.scipy.org/) est incontournable en bioinformatique. Il permet d'effectuer des calculs sur des vecteurs ou des matrices, élément par élément, via un nouveau type d'objet appelé *array*.

On charge le module *NumPy* avec la commande :

```python
>>> import numpy
```

On peut également définir un nom raccourci pour *NumPy* :

```python
>>> import numpy as np
```

## Objets de type *array*

Les objets de type *array* correspondent à des tableaux à une ou plusieurs dimensions et permettent d'effectuer du calcul vectoriel. La fonction `array()` convertit un objet séquentiel (comme une liste ou un tuple) en un objet de type *array*. Voici un exemple simple de conversion d'une liste à une dimension en objet *array* :

```python
>>> import numpy as np
>>> a = [1, 2, 3]
>>> np.array(a)
array([1, 2, 3])
>>> b = np.array(a)
>>> b
array([1, 2, 3])
>>> type(b)
<type 'numpy.ndarray'>
```

Nous avons converti la liste `[1, 2, 3]` en *array*. Nous aurions obtenu le même résultat si nous avions converti le tuple `(1, 2, 3)` en *array*.

Par ailleurs, lorsqu'on demande à Python d'afficher le contenu d'un objet *array*, le mot `array` et les symboles `([` et `])` sont utilisés pour le distinguer d'une liste (délimitée par les caractères `[` et `]`) ou d'un tuple (délimité par les caractères `(` et `)`).

<div class="remarque">
Un objet *array* ne contient que des données homogènes, c'est-à-dire d'un type identique.

Il est possible de créer un objet *array* à partir d'une liste contenant des entiers et des chaînes de caractères, mais dans ce cas, toutes les valeurs seront comprises par *NumPy* comme des chaînes de caractères :

```python
>>> a = np.array([1, 2, "tigre"])
>>> a
array(['1', '2', 'tigre'], dtype='<U21')
>>> type(a)
<class 'numpy.ndarray'>
```

De même, il est possible de créer un objet *array* à partir d'une liste constituée d'entiers et de *floats*, mais toutes les valeurs seront alors comprises par *NumPy* comme des *floats* :  

```python
>>> b = np.array([1, 2, 3.5])
>>> b
array([1. , 2. , 3.5])
>>> type(b)
<class 'numpy.ndarray'>
```

Ici, la notation `1.` indique qu'il s'agit du *float* `1.0000...` et pas de l'entier `1`.
</div>

Sur un modèle similaire à la fonction `range()`, la fonction `arange()` permet de construire un *array* à une dimension de manière simple.

```python
>>> np.arange(10)
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
```

Comme avec `range()`, on peut spécifier en argument une borne de début, une borne de fin et un pas :

```python
>>> np.arange(10, 0, -1)
array([10,  9,  8,  7,  6,  5,  4,  3,  2,  1])
```

Un autre avantage de la fonction `arange()` est qu'elle génère des objets *array* qui contiennent des entiers ou des *floats* selon l'argument qu'on lui passe :

```python
>>> np.arange(10)
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> np.arange(10.0)
array([ 0.,  1.,  2.,  3.,  4.,  5.,  6.,  7.,  8.,  9.])
```

La différence fondamentale entre un objet *array* à une dimension et une liste (ou un tuple) est que celui-ci est considéré comme un **vecteur**. Par conséquent, on peut effectuer des opérations **élément par élément** sur ce type d'objet, ce qui est bien commode lorsqu'on analyse de grandes quantités de données. Regardez ces exemples :

```python
>>> v = np.arange(4)
>>> v
array([0, 1, 2, 3])
>>> v + 1
array([1, 2, 3, 4])
>>> v + 0.1
array([ 0.1,  1.1,  2.1,  3.1])
>>> v * 2
array([0, 2, 4, 6])
>>> v * v
array([0, 1, 4, 9])
```

Avec les listes, ces opérations n'auraient été possibles qu'en utilisant des boucles. Nous vous encourageons donc à utiliser dorénavant les objets *array* lorsque vous aurez besoin de faire des opérations élément par élément.

Notez également que, dans le dernier exemple de multiplication (ligne 10), l'*array* final correspond à la multiplication **élément par élément** des deux *array* initiaux.

## *Array* et dimensions

Il est aussi possible de construire des objets *arrays* à deux dimensions, il suffit de passer en argument une liste de listes à la fonction `array()` :

```python
>>> w = np.array([[1, 2], [3, 4], [5, 6]])
>>> w
array([[1, 2],
       [3, 4],
       [5, 6]])
```

On peut aussi créer des tableaux à trois dimensions en passant comme argument à la fonction `array()` une liste de listes de listes :

```python
>>> x = np.array([[[1, 2], [2, 3]], [[4, 5], [5, 6]]])
>>> x
array([[[1, 2],
        [2, 3]],

       [[4, 5],
        [5, 6]]])
```

La fonction `array()` peut créer des tableaux à n'importe quel nombre de dimensions. Toutefois ça devient vite compliqué lorsqu'on dépasse trois dimensions. Retenez qu'un objet *array* à une dimension peut être considéré comme un **vecteur** et un *array* à deux dimensions comme une **matrice**. Nous nous focaliserons dans la suite sur des *arrays* 1D ou 2D.

Avant de continuer, il est important de définir comment sont organisés ces *arrays* 2D qui représentent des matrices. Il s'agit de tableaux de nombres qui sont organisés en lignes et en colonnes comme le montre la +@fig:array-2d-lignes-colonnes. Les indices indiqués dans cette figure seront définis un peu plus loin dans la rubrique *Indices*.

![Définition des lignes et colonnes dans un *array* 2D.](img/array-2d-lignes-colonnes.png "Définition des lignes et colonnes dans un array 2D"){ #fig:array-2d-lignes-colonnes width=60% }

Voici quelques attributs intéressants pour décrire un objet *array* :

- `.ndim` renvoie le nombre de dimensions (par exemple,
    1 pour un vecteur et 2 pour une matrice).
- `.shape` renvoie les dimensions sous forme d'un tuple. Dans le cas d'une matrice (*array* à deux dimensions), la première valeur du tuple correspond au nombre de lignes et la seconde au nombre de colonnes.
- `.size` renvoie le nombre total d'éléments contenus dans l'`array`.

```python
>>> v = np.arange(4)
>>> v
array([0, 1, 2, 3])
>>> v.ndim
1
>>> v.shape
(4,)
>>> v.size
4
>>> w = np.array([[1, 2], [3, 4], [5, 6]])
>>> w
array([[1, 2],
       [3, 4],
       [5, 6]])
>>> w.ndim
2
>>> w.shape
(3, 2)
>>> w.size
6
```

Et la méthode `.reshape()` renvoie un nouvel *array* avec les dimensions spécifiées :

```python
>>> a = np.arange(0, 6)
>>> a
array([0, 1, 2, 3, 4, 5])
>>> a.shape
(6,)
>>> b = a.reshape((2, 3))
>>> b
array([[0, 1, 2],
       [3, 4, 5]])
>>> b.shape
(2, 3)
>>> a
array([0, 1, 2, 3, 4, 5])
```

Notez bien que `a` n'a pas été modifié. Notez également que `a.reshape((2, 3))` n'est pas la même chose que `a.reshape((3, 2))` :

```python
>>> c = a.reshape((3, 2))
>>> c
array([[0, 1],
       [2, 3],
       [4, 5]])
>>> c.shape
(3, 2)
```

La méthode `.reshape()` attend que les nouvelles dimensions soient **compatibles** avec la dimension initiale de l'objet *array*, c'est-à-dire que le nombre d'éléments contenus dans les différents *arrays* soit le même.
Dans nos exemples précédents, $6 = 2 \times 3 = 3 \times 2$.

Si les nouvelles dimensions ne sont pas compatibles avec les dimensions initiales, la méthode `.reshape()` génère une erreur.

```python
>>> a = np.arange(0, 6)
>>> a
array([0, 1, 2, 3, 4, 5])
>>> a.shape
(6,)
>>> d = a.reshape((3, 4))
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ValueError: cannot reshape array of size 6 into shape (3,4)
```

La méthode `.resize()` par contre ne déclenche pas d'erreur dans une telle situation et ajoute des 0 jusqu'à ce que le nouvel *array* soit rempli, ou bien coupe la liste initiale.

```python
>>> a = np.arange(0, 6)
>>> a.shape
(6,)
>>> a.resize((3, 3), refcheck=False)
>>> a.shape
(3, 3)
>>> a
array([[0, 1, 2],
       [3, 4, 5],
       [0, 0, 0]])
```

```python
>>> b = np.arange(0, 10)
>>> b.shape
(10,)
>>> b.resize((2, 3), refcheck=False)
>>> b.shape
(2, 3)
>>> b
array([[0, 1, 2],
       [3, 4, 5]])
```

<div class="attention">
Attention, cette modification de la forme de l'*array* par la méthode `.resize()` est faite « sur place » (*in place*), c'est-à-dire que la méthode ne renvoie rien mais l'*array* est bel et bien modifié (à l'image des méthodes sur les listes comme `.reverse()`, cf. +@sec:plus-sur-les-listes). Si l'option `refcheck=False` n'est pas présente, Python peut parfois renvoyer une erreur s'il existe des références vers l'*array* qu'on souhaite modifier.
</div>

Il existe aussi la fonction `np.resize()` qui, dans le cas d'un nouvel *array* plus grand que l'*array* initial, va répéter l'*array* initial afin de remplir les cases manquantes :

```python
>>> a = np.arange(0, 6)
>>> a.shape
(6,)
>>> c = np.resize(a, (3, 5))
>>> c.shape
(3, 5)
>>> c
array([[0, 1, 2, 3, 4],
       [5, 0, 1, 2, 3],
       [4, 5, 0, 1, 2]])
>>> a
array([0, 1, 2, 3, 4, 5])
```

Notez que cette fonction `np.resize()` renvoie un nouvel *array* mais ne modifie pas l'*array* initial contrairement à la méthode `.resize()` décrite ci-dessus.

<div class="remarque">
Depuis le début de ce chapitre, nous avons toujours montré l'affichage d'un *array* dans l'interpréteur :

```python
>>> a = np.array(range(10))
>>> a
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> a2 = np.ones((3, 3))
>>> a2
array([[1., 1., 1.],
       [1., 1., 1.],
       [1., 1., 1.]])
```

Nous avons déjà indiqué que Python affiche systématiquement le mot *array* ainsi que les parenthèses, crochets et virgules pour séparer les éléments. Attention toutefois si vous utilisez la fonction `print()` car l'affichage est différent. Le mot *array*, les parenthèses et les virgules disparaissent :

```python
>>> print(a)
[0 1 2 3 4 5 6 7 8 9]
>>> print(a2)
[[1. 1. 1.]
 [1. 1. 1.]
 [1. 1. 1.]]
```

Ceci peut amener des confusions spécialement pour un *array* 1D `[0 1 2 3 4 5 6 7 8 9]` et une liste contenant les même éléments `[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]`. Dans ce cas, seule la présence ou l'absence de virgules permet de trancher s'il s'agit d'un *array* ou d'une liste.
</div>

## Méthodes de calcul sur les *arrays* et l'argument `axis`

Chaque *array NumPy* qui est créé possède une multitude de méthodes. Nombre d'entre elles permettent de faire des calculs de base comme `.mean()` pour la moyenne, `.sum()` pour la somme, `.std()` pour l'écart-type, `.max()` pour extraire le maximum, `.min()` pour extraire le minimum, etc. La liste exhaustive est [ici](https://numpy.org/doc/stable/reference/arrays.ndarray.html#calculation). Par défaut, chacune de ces méthodes effectuera l'opération sur l'*array* entier, quelle que soit sa dimensionnalité. Par exemple :

```python
>>> import random as rd
>>> l = list(range(8))
>>> rd.shuffle(l)
>>> l
[2, 7, 6, 4, 0, 3, 1, 5]
>>> a = np.resize(l, (4, 2))
>>> a
array([[2, 7],
       [6, 4],
       [0, 3],
       [1, 5]])
>>> a.max()
7
```

La méthode `.max()` nous a bien renvoyé la valeur maximum 7. Un argument *très* utile existant dans toutes ces méthodes est `axis`. Pour un *array* 2D, `axis=0` signifie qu'on fera l'opération le long de l'axe 0, à savoir les lignes. C'est-à-dire que l'opération se fait en faisant varier les lignes. On récupère ainsi une valeur par colonne :

```python
>>> a.max(axis=0)
array([6, 7])
```

L'*array* 1D récupéré a son premier élément qui vaut 6 (maximum de la 1ère colonne) et son deuxième qui vaut 7 (maximum de la deuxième colonne).

Avec `axis=1` on fait une opération similaire mais en faisant varier les colonnes. On récupère ainsi une valeur par ligne :

```python
>>> a.max(axis=1)
array([7, 6, 3, 5])
```

L'*array* 1D récupéré a 4 éléments correspondant au maximum de chaque ligne.

On comprend la puissance de cet argument `axis`. A nouveau, il est possible, en une ligne, de faire des calculs qui pourraient être très fastidieux avec les listes traditionnelles.

## Indices

Pour récupérer un ou plusieurs élément(s) d'un objet *array*, vous pouvez utiliser les indices ou les tranches, de la même manière qu'avec les listes :

```python
>>> a = np.arange(10)
>>> a
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> a[5:]
array([5, 6, 7, 8, 9])
>>> a[::2]
array([0, 2, 4, 6, 8])
>>> a[1]
1
```

Dans le cas d'un objet *array* à deux dimensions, vous pouvez récupérer une ligne complète (d'indice *i*), une colonne complète (d'indice *j*) ou bien un seul élément. La +@fig:array-2d-lignes-colonnes montre comment sont organisés les lignes / colonnes et indices.

```python
>>> a = np.array([[1, 2], [3, 4]])
>>> a
array([[1, 2],
       [3, 4]])
>>> a[:,0]
array([1, 3])
>>> a[0,:]
array([1, 2])
>>> a[1, 1]
4
```

Lignes 5 à 8. La syntaxe `a[i,:]` renvoie la $(i+1)^{ème}$ ligne d'indice `i`, et `a[:,j]` renvoie la $(j+1)^{ème}$ colonne d'indice `j`. Les tranches sont évidemment aussi utilisables sur un *array* à deux dimensions.

Lignes 9 à 10. La syntaxe `a[i, j]` renvoie l'élément à la ligne d'indice `i` et à la colonne d'indice `j`. Notez que *NumPy* suit la convention mathématiques des [matrices](https://fr.wikipedia.org/wiki/Matrice_(math%C3%A9matiques)#D%C3%A9finitions), à savoir, **on définit toujours un élément par sa ligne puis par sa colonne**. En mathématiques, l'élément $a_{ij}$ d'une matrice $A$ se trouve à la $i^{ème}$ ligne et à la $j^{ème}$ colonne.

<div class="remarque">
- Pour un *array* 2D, si un seul indice est donné, par exemple `a[i]`, on récupère la ligne d'indice `i` sous forme d'*array* 1D :

  ```python
  >>> a
  array([[1, 2],
         [3, 4]])
  >>> a[0]
  array([1, 2])
  >>> a[1]
  array([3, 4])
  ```

- Pour cette raison, la syntaxe `a[i][j]` est également valide pour récupér un élément :

  ```python
  >>> a
  array([[1, 2],
         [3, 4]])
  >>> a[1, 1]
  4
  >>> a[1][1]
  4
  ```

Bien que cela soit possible, nous vous recommandons tout de même la syntaxe `a[i, j]` qui est plus proche de la [définition mathématiques d'un élément de matrice](https://fr.wikipedia.org/wiki/Matrice_(math%C3%A9matiques)#D%C3%A9finitions).
</div>

## Copie d'*arrays*

Comme pour les listes, nous attirons votre attention sur la copie d'*arrays* :

```python
>>> a = np.arange(5)
>>> a
array([0, 1, 2, 3, 4])
>>> b = a
>>> b[2] = -300
>>> b
array([   0,    1, -300,    3,    4])
>>> a
array([   0,    1, -300,    3,    4])
```

<div class="attention">
Par défaut la copie d'*arrays* se fait par référence comme pour tous les objets séquentiels en Python (listes, *tuples*, dictionnaires, etc.).
</div>

Afin d'éviter le problème, vous pouvez soit utiliser la fonction `np.array()` qui crée une nouvelle copie distincte de l'*array* initial, soit la fonction `copy.deepcopy()` comme pour les listes (cf. +@sec:plus-sur-les-listes) :

```python
>>> a = np.full((2, 2), 0)
>>> a
array([[0, 0],
       [0, 0]])
>>> b = np.array(a)
>>> b[1, 1] = -300
>>> c = copy.deepcopy(a)
>>> c[1, 1] = -500
>>> a
array([[0, 0],
       [0, 0]])
>>> b
array([[   0,    0],
       [   0, -300]])
>>> c
array([[   0,    0],
       [   0, -500]])
```

<div class="remarque">

On pourra noter que la stratégie `b = np.array(a)` fait bien une copie distincte de l'*array* `a` quelle que soit sa dimensionnalité. Ceci n'était pas le cas avec la fonction `list()`  pour les copies de listes à partir de la dimensionnalité 2 :

```python
>>> l1 = [[0, 0], [1, 1]]
>>> l2 = list(l1)
>>> l3 = copy.deepcopy(l1)
>>> l1[1][1] = -365
>>> l2
[[0, 0], [1, -365]]
>>> l3
[[0, 0], [1, 1]]
```

</div>

## Construction automatique de matrices

Il peut être parfois pénible de construire une matrice (*array* à deux dimensions) à l'aide d'une liste de listes. Le module *NumPy* possède quelques fonctions pratiques pour initialiser des matrices. Par exemple, Les fonctions `zeros()` et `ones()` construisent des objets *array* contenant des 0 ou des 1. Il suffit de leur passer en argument un tuple indiquant les dimensions voulues.

```python
>>> np.zeros((2, 3))
array([[0., 0., 0.],
       [0., 0., 0.]])
>>> np.ones((3, 3))
array([[1., 1., 1.],
      [1., 1., 1.],
      [1., 1., 1.]])
```

Par défaut, les fonctions `zeros()` et `ones()` génèrent des *floats*, mais vous pouvez demander des entiers en passant le type (par exemple `int`, `float`, etc.) en second argument :

```python
>>> np.zeros((2,3), int)
array([[0, 0, 0],
       [0, 0, 0]])
```

Enfin, si vous voulez construire une matrice avec autre chose que des 0 ou des 1, vous avez à votre disposition la fonction `full()` :

```python
>>> np.full((2, 3), 7, int)
array([[7, 7, 7],
       [7, 7, 7]])
>>> np.full((2, 3), 7, float)
array([[ 7.,  7.,  7.],
       [ 7.,  7.,  7.]])
```

Nous construisons ainsi une matrice constituée de 2 lignes et 3 colonnes. Celle-ci ne contient que le chiffre 7 sous formes d'entiers (`int`) dans le premier cas et de *floats* dans le second.

Le module numpy contient aussi des fonctions pour lire des données à partir de fichiers et créer des *arrays* automatiquement. Cela se révèle bien pratique car la plupart du temps les données que l'on analyse proviennent de fichiers. La fonction la plus simple à prendre en main est `np.loadtxt()`. Celle-ci lit un fichier organisé en lignes / colonnes. Par exemple, imaginons que nous ayons un fichier `donnees.dat` contenant :

```python
  1   7 310
 15  -4  35
 78  95  79
```

La fonction prend en argument le nom du fichier et renvoie un *array* 2D directement :

```python
>>> np.loadtxt("donnees.dat")
array([[  1.,   7., 310.],
       [ 15.,  -4.,  35.],
       [ 78.,  95.,  79.]])
```

Pratique, non ? Attention toutefois aux points suivants :

- chaque ligne doit avoir le même nombre de colonnes, la fonction ne gère pas les données manquantes ;
- chaque donnée est convertie en *float*, donc si une chaîne est rencontrée la fonction renvoie une erreur ;
- par défaut, les données doivent être séparées par n'importe quelle combinaison d'espace(s) et/ou de tabulations.

Nous vous conseillons vivement de consulter la [documentation complète](https://numpy.org/doc/stable/reference/generated/numpy.loadtxt.html) de cette fonction. `np.loadtxt()` contient tout un tas d'arguments par mot-clé permettant de récupérer telles ou telles lignes / colonnes, ignorer des lignes de commentaire, changer le séparateur par défaut (par exemple la virgule `,` pour les fichiers .csv), etc., qui peuvent se révéler commodes.

L'opération inverse consistant à sauver un *array* dans un fichier se fait avec la fonction `np.savetxt()` :

```python
>>> a = np.reshape(range(1, 10), (3, 3))
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> np.savetxt("out.dat", a)
```

Ceci générera le fichier `out.dat` contenant les lignes suivantes :

```python
1.000000000000000000e+00 2.000000000000000000e+00 3.000000000000000000e+00
4.000000000000000000e+00 5.000000000000000000e+00 6.000000000000000000e+00
7.000000000000000000e+00 8.000000000000000000e+00 9.000000000000000000e+00
```

On voit que la fonction écrit par défaut les données comme des *floats* en notation scientifique. Bien sûr il existe de nombreuses [options possibles](https://numpy.org/doc/stable/reference/generated/numpy.savetxt.html) permettant de changer le format, les séparateurs, etc.

<div class="details">
Il existe d'autres fonctions plus avancées telles que [np.genfromttxt()](https://numpy.org/doc/stable/reference/generated/numpy.genfromtxt.html) gérant les données manquantes, ou encore [np.load()](https://numpy.org/doc/stable/reference/generated/numpy.load.html) et [np.fromfile()](https://numpy.org/doc/stable/reference/generated/numpy.fromfile.html) permettant de lire des données au format binaire. De même, il existe des fonctions ou méthodes permettant d'écrire au format binaire : [np.save()](https://numpy.org/doc/stable/reference/generated/numpy.save.html) ou [.tofile()](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.tofile.html#numpy.ndarray.tofile). Le format binaire possède en général l'extension `.npy` ou `.npz` lorsque les données sont compressées. L'avantage d'écrire au format binaire est que cela prend moins de place pour les gros tableaux.
</div>

## Un peu d'algèbre linéaire

Après avoir manipulé les objets *array* comme des vecteurs et des matrices, voici quelques fonctions pour faire de l'algèbre linéaire.

La fonction `transpose()` renvoie la [transposée](https://fr.wikipedia.org/wiki/Matrice_transpos%C3%A9e) d'un *array*. Par exemple, pour une matrice :

```python
>>> a = np.resize(np.arange(1, 10), (3, 3))
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> np.transpose(a)
array([[1, 4, 7],
       [2, 5, 8],
       [3, 6, 9]])
```

Tout objet *array* possède un attribut `.T` qui contient la transposée, il est ainsi possible d'utiliser cette notation objet plus compacte :

```python
>>> a.T
array([[1, 4, 7],
       [2, 5, 8],
       [3, 6, 9]])
```

La fonction `dot()` vous permet de réaliser une [multiplication de matrices](https://fr.wikipedia.org/wiki/Produit_matriciel#Produit_matriciel_ordinaire).

```python
>>> a = np.resize(np.arange(4), (2, 2))
>>> a
array([[0, 1],
       [2, 3]])
>>> np.dot(a, a)
array([[ 2,  3],
       [ 6, 11]])
>>> a * a
array([[0, 1],
       [4, 9]])
```

Notez bien que `dot(a, a)` renvoie le **produit matriciel** entre deux matrices, alors que `a * a` renvoie le produit **élément par élément**.

<div class="remarque">
Dans le module *NumPy*, il existe également des objets de type *matrix* pour lesquels les multiplications de matrices sont différents, mais nous ne les aborderons pas ici.
</div>

Pour toutes les opérations suivantes, nous utiliserons des fonctions du sous-module *linalg* de *NumPy*. La fonction `inv()` renvoie l'[inverse d'une matrice carrée](https://fr.wikipedia.org/wiki/Matrice_inversible), `det()` son [déterminant](https://fr.wikipedia.org/wiki/Calcul_du_d%C3%A9terminant_d%27une_matrice) et `eig()` ses [vecteurs et valeurs propres](https://fr.wikipedia.org/wiki/D%C3%A9composition_d%27une_matrice_en_%C3%A9l%C3%A9ments_propres).

```python
>>> a = np.diag((1, 2, 3))
>>> a
array([[1, 0, 0],
       [0, 2, 0],
       [0, 0, 3]])
>>> np.linalg.inv(a)
array([[1.        , 0.        , 0.        ],
       [0.        , 0.5       , 0.        ],
       [0.        , 0.        , 0.33333333]])
>>> np.linalg.det(a)
6.0
>>> np.linalg.eig(a)
(array([1., 2., 3.]), array([[1., 0., 0.],
       [0., 1., 0.],
       [0., 0., 1.]]))
```

Ligne 1. La fonction `.diag()` permet de générer une matrice diagonale.

Lignes 12 à 15. La fonction `eig()` renvoie un tuple dont le premier élément (d'indice 0) correspond aux valeurs propres et le second (d'indice 1) aux vecteurs propres. Une façon commode de récupérer ces éléments est d'utiliser cette fonction avec l'affectation multiple :

```python
>>> eigvals, eigvecs = np.linalg.eig(a)
>>> eigvals
array([1., 2., 3.])
>>> eigvecs
array([[1., 0., 0.],
       [0., 1., 0.],
       [0., 0., 1.]])
>>> eigvecs[0]
array([1., 0., 0.])
>>> eigvecs[1]
array([0., 1., 0.])
>>> eigvecs[2]
array([0., 0., 1.])
```

Lignes 2 et 3. `eigvals` est un *array* 1D  contenant les 3 valeurs propres.

Lignes 4 à 13. `eigvecs` est un *array* 2D contenant les 3 vecteurs propres (un par ligne), que l'on peut récupérer avec `eigvecs[0]`,  `eigvecs[1]` et  `eigvecs[2]`.

## Parcours de matrice et affectation de lignes / colonnes

Lorqu'on a une matrice, on est souvent amené à la parcourir par ligne ou par colonne. Une fonctionnalité bien commode vient du fait que les *arrays NumPy* sont directement itérables par ligne :

```python
>>> a = np.reshape(np.arange(1, 10), (3, 3))
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> for row in a:
...     print(row, type(row))
...
[1 2 3] <class 'numpy.ndarray'>
[4 5 6] <class 'numpy.ndarray'>
[7 8 9] <class 'numpy.ndarray'>
```

A chaque itération, la variable `row` est un *array* 1D correspondant à chaque ligne de `a`. Cela est lié au fait que l'utilisation d'un indiçage unique `a[i]` pour un *array* 2D correspond à sa ligne d'indice `i` (cf. rubrique *Indices* ci-dessus). 

Pour itérer sur les colonnes, on pourra utiliser l'astuce d'itérer sur la transposée de l'*array* `a`, c'est-à-dire `a.T` :

```python
>>> for col in a.T:
...     print(col, type(col))
...
[1 4 7] <class 'numpy.ndarray'>
[2 5 8] <class 'numpy.ndarray'>
[3 6 9] <class 'numpy.ndarray'>
```

A chaque itération, la variable `col` est un *array* 1D correspondant à chaque colonne de `a`.

On se souvient de l'affectation multiple `x, y = 1, 2` qui permettait d'affecter des valeurs à plusieurs variables à la fois. Et bien, il est possible d'utiliser cette fonctionnalité aussi avec les *arrays NumPy* :

```python
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> l1, l2, l3 = a
>>> l1
array([1, 2, 3])
>>> l2
array([4, 5, 6])
>>> l3
array([7, 8, 9])
```

Par défaut, cela se fait sur les lignes de l'*array* 2D. Cette fonctionnalité provient à nouveau du fait que pour *NumPy* `a[i]` correspond à la ligne d'indice `i` d'un *array* 2D.

Pour utiliser l'affectation multiple sur les colonnes, il suffit d'utiliser la transposée `a.T` :

```python
>>> c1, c2, c3 = a.T
>>> c1
array([1, 4, 7])
>>> c2
array([2, 5, 8])
>>> c3
array([3, 6, 9])
```

## Masques booléens

Une des grandes puissance des *arrays* *NumPy* est qu'ils supportent les **masques booléens**. Avant de les définir, il est important d'introduire le concept d'*arrays* de booléens. Jusqu'à maintenant nous avions définis uniquement des *arrays* avec des types numériques *int* ou *float*. Il est tout à fait possible de définir des *arrays* de booléens. La fonction `np.full()` vue ci-dessus nous permet d'en construire facilement :

```python
>>> np.full((2, 2), True)
array([[ True,  True],
       [ True,  True]])
>>> np.full((2, 2), False)
array([[False, False],
       [False, False]])
```

Très bien, mais au premier abord nous n'en voyons pas forcément l'utilité... Mais qu'en est-il lorsqu'on utilise les opérateurs de comparaison avec un *array* ? Et bien cela renvoie un *array* de booléens !

```python
>>> a = np.reshape(np.arange(1, 10), (3, 3))
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> a > 5
array([[False, False, False],
       [False, False,  True],
       [ True,  True,  True]])
>>> a == 2
array([[False,  True, False],
       [False, False, False],
       [False, False, False]])
```

Tous les éléments de l'*array* satisfaisant la condition seront à `True`, les autres à `False`. Encore plus fort, il est possible de combiner plusieurs conditions avec les opérateurs logiques `&` et `|` (respectivement **ET** et **OU**) :

```python
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> (a > 3) & (a % 2 == 0)
array([[False, False, False],
       [ True, False,  True],
       [False,  True, False]])
>>> (a > 3) | (a % 2 == 0)
array([[False,  True, False],
       [ True,  True,  True],
       [ True,  True,  True]])
```

Nous pouvons effectuer deux remarques :

- Les opérateurs logiques `&` et `|` s'appliquent sur les *arrays* et sont différents des opérateurs logiques `and` et `or` qui eux s'appliquent sur les booléens (`True` ou `False`) ;
- Il est conseillé de mettre des parenthèses pour chaque condition afin d'éviter les ambiguïtés.

Maintenant que les *arrays* de booléens ont été introduits, nous pouvons définir les masques booléens :

<div class="definition">
Les masques booléens sont des *arrays* de booléens qui sont utilisés en tant qu'« indice » d'un *array* initial. Cela permet de récupérer / modifier une partie de l'*array* initial.
</div>

Concrètement, il suffira d'utiliser un *array* et un opérateur de comparaison entre les crochets qui étaient dédiés à l'indiçage :

```python
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> a[a > 5]
array([6, 7, 8, 9])
>>> a[a == 2]
array([2])
>>> a[a != 0]
array([1, 2, 3, 4, 5, 6, 7, 8, 9])
```

On voit que l'on récupère seulement les éléments de l'*array* `a` qui sastisfont la sélection ! Toutefois, il est important de constater que l'*array* renvoyé perd la dimensionnalité de l'array `a` initial, il s'agit systématiquement d'un *array* 1D. 

La grande puissance de ce mécanisme est que l'on peut utiliser les masques booléens pour modifier les éléments que l'on sélectionne :

```python
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> a[a > 5]
array([6, 7, 8, 9])
>>> a[a > 5] = -1
>>> a
array([[ 1,  2,  3],
       [ 4,  5, -1],
       [-1, -1, -1]])
```

On peut bien sûr combiner plusieurs conditions avec les opérateurs logiques :

```python
>>> a
array([[1, 2, 3],
       [4, 5, 6],
       [7, 8, 9]])
>>> a[(a > 3) | (a % 2 == 0)] = 0
>>> a
array([[1, 0, 3],
       [0, 0, 0],
       [0, 0, 0]])
```

Ce mécanisme de sélection avec des masques booléens se révèle très puissant pour manipuler des grandes quantités de données. On verra qu'il peut être également utilisé avec les *dataframes* du module *pandas*.

<div class="remarque">
Les masques booléens ne doivent pas être confondus avec les [*masked arrays*](https://numpy.org/doc/1.18/reference/maskedarray.html) qui sont des *arrays* dans lesquels on peut trouver des valeurs manquantes ou invalides.
</div>

Une application possible des masques est de « binariser » une matrice de nombre :

```python
>>> import random as rd
>>> import numpy as np
>>> a = np.resize([rd.random() for i in range(16)], (4,
4))
>>> a
array([[0.58704728, 0.50212977, 0.70652863, 0.24158108],
       [0.93102132, 0.41864373, 0.45807961, 0.98288744],
       [0.48198211, 0.16877376, 0.14431518, 0.74784176],
       [0.92913469, 0.08383269, 0.10670144, 0.14554345]])
>>> seuil = 0.3
>>> a[a < seuil] = 0
>>> a[a > seuil] = 1
>>> a
array([[1., 1., 1., 0.],
       [1., 1., 1., 1.],
       [1., 0., 0., 1.],
       [1., 0., 0., 0.]])
```

En deux lignes de code cela est fait alors qu'il aurait fallu faire des boucles avec les listes classiques !

## Quelques conseils

Nous venons de voir une petite partie du module *NumPy* mais vous avez pu en constater son extraordinaire puissance. On pourrait au premier abord être tenté d'abandonner les listes, toutefois elles gardent toute leur importance. Alors quand utiliser les listes ou quand utiliser les *arrays NumPy* ? Voici une liste non exhaustive d'éléments qui peuvent guider votre choix :

Utilisez NumPy pour :

- les opérations vectorielles (éléments par éléments) ;
- lorsque vous souhaitez manipuler des objets mathématiques (vecteurs, matrices, etc.) et les outils associés (algèbre linéaire) ;
- tout ce qui est numérique de manière générale.

Utilisez les listes :

- lorsque vous avez besoin d'un container pour accumuler des valeurs (fussent-elles des sous-listes), surtout lorsqu'elles ne sont pas homogènes (i.e. du même type) ;
- lorsque vous souhaitez accumuler des valeurs : la méthode `.append()` est bien plus efficace que faire grandir un *array* au fur et à mesure (ce que nous n'avons pas abordé) ; lorsqu'on ne peut pas utiliser les fonctions de lecture de fichier de *NumPy* pour quelque raison que ce soit, il est tout à fait classique de faire grandir une liste au fur et à mesure de la lecture du fichier puis de la convertir à la fin en *array*.

Enfin, comme nous vous le conseillons depuis le début, soignez bien votre documentation (*docstrings*) ou vos commentaires lorsque vous utilisez des *arrays NumPy*. *Numpy* permettant de réaliser des opérations vectorielles de manière très compacte, il est essentiel de se mettre à la place du lecteur et de bien indiquer ce que contient chaque *array* et sa dimensionnalité (1D, 2D, etc.).

Le module *NumPy* est la brique de base pour tout ce qui est numérique. Associé aux modules *SciPy* et *matplotlib*, il permet de faire de l'analyse scientifique. On verra dans le +@sec:module-pandas que la puissance de *NumPy* est également utilisée par le module *pandas* et ses fameux *dataframes* pour faire de l'analyse de données.
