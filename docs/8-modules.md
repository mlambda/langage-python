# Modules{#sec:modules}

## Définition

Les modules sont des programmes Python qui contiennent des fonctions que l'on est amené à réutiliser souvent (on les appelle aussi bibliothèques ou *libraries*). Ce sont des «&nbsp;boîtes à outils&nbsp;» qui vont vous être très utiles.

Les développeurs de Python ont mis au point de nombreux modules qui effectuent une quantité phénoménale de tâches. Pour cette raison, prenez toujours le réflexe de vérifier si une partie du code que vous souhaitez écrire n'existe pas déjà sous forme de module.

La plupart de ces modules sont déjà installés dans les versions standards de Python. Vous pouvez accéder à une [documentation exhaustive](https://docs.python.org/fr/3/py-modindex.html) sur le site de Python. N'hésitez pas à explorer un peu ce site, la quantité de modules disponibles est impressionnante (plus de 300).

## Importation de modules

Dans les chapitres précédents, nous avons rencontré la notion de module plusieurs fois. Notamment lorsque nous avons voulu tirer un nombre aléatoire&nbsp;:

```python
>>> import random
>>> random.randint(0, 10)
4
```

Regardons de plus près cet exemple&nbsp;:

- Ligne 1, l'instruction `import` donne accès à toutes les fonctions du module [`random`](https://docs.python.org/fr/3/library/random.html#module-random).
- Ensuite, ligne 2, nous utilisons la fonction `randint(0, 10)` du module `random`. Cette fonction renvoie un nombre entier tiré aléatoirement entre `0` inclus et `10` inclus.

Nous avons également croisé le module `math` lors de l'exercice sur la spirale (voir +@sec:fichiers). Ce module nous a donné accès aux fonctions trigonométriques sinus et cosinus, et à la constante $\pi$&nbsp;:

```python
>>> import math
>>> math.cos(math.pi / 2)
6.123233995736766e-17
>>> math.sin(math.pi / 2)
1.0
```

En résumé, l'utilisation de la syntaxe `import module` permet d'importer tout une série de fonctions organisées par «&nbsp;thèmes&nbsp;». Par exemple, les fonctions gérant les nombres aléatoires avec `random` et les fonctions mathématiques avec `math`. Python possède de nombreux autres modules internes (c'est-à-dire présent de base lorsqu'on installe Python).

<div class="remarque">
Dans le +@sec:affichage, nous avons introduit la syntaxe `truc.bidule()` avec `truc` étant un objet et `.bidule()` une méthode. Nous vous avions expliqué qu'une *méthode* était une fonction un peu particulière&nbsp;:

- elle était liée à un objet par un point ;
- en général, elle agissait sur ou utilisait l'objet auquel elle était liée.

Par exemple, la méthode `.format()` dans l'instruction `"{}".format(3.14)` utilise l'objet chaîne de caractères `"{}"` (auquel elle est liée) pour finalement renvoyer une autre chaîne de caractères `"3.14"`.

Avec les modules, nous rencontrons une syntaxe similaire. Par exemple, dans l'instruction `math.cos()`, on pourrait penser que `.cos()` est aussi une méthode. En fait la [documentation officielle de Python](https://docs.python.org/fr/3/tutorial/modules.html) précise bien que dans ce cas `.cos()` est une fonction. Dans cet ouvrage, nous utiliserons ainsi le mot **fonction** lorsqu'on évoquera des fonctions issues de modules.

Si cela vous parait encore ardu, ne vous inquiétez pas, c'est à force de pratiquer et de lire que vous vous approprierez le vocabulaire. Ici, la syntaxe `module.fonction()` est là pour rappeler de quel module provient la fonction en un coup d’œil&nbsp;!
</div>

Il existe un autre moyen d'importer une ou plusieurs fonctions d'un module&nbsp;:

```python
>>> from random import randint
>>> randint(0,10)
7
```

À l'aide du mot-clé `from`, on peut importer une fonction spécifique d'un module donné. Remarquez bien qu'il est inutile de répéter le nom du module dans ce cas, seul le nom de la fonction en question est requis.

On peut également importer toutes les fonctions d'un module&nbsp;:

```python
>>> from random import *
>>> x = [1, 2, 3, 4]
>>> shuffle(x)
>>> x
[2, 3, 1, 4]
>>> shuffle(x)
>>> x
[4, 2, 1, 3]
>>> randint(0,50)
46
>>> uniform(0,2.5)
0.64943174760727951
```

L'instruction `from random import *` importe toutes les fonctions du module `random`. On peut ainsi utiliser toutes ses fonctions directement, comme par exemple `shuffle()` qui permute une liste aléatoirement.

Dans la pratique, plutôt que de charger toutes les fonctions d'un module en une seule fois&nbsp;:

```python
from random import *
```

nous vous conseillons de charger le module seul de la manière suivante&nbsp;:

```python
import random
```

puis d'appeler explicitement les fonctions voulues, par exemple&nbsp;:

```python
random.randint(0,2)
```

Il est également possible de définir un alias (un nom plus court) pour un module&nbsp;:

```python
>>> import random as rand
>>> rand.randint(1, 10)
6
>>> rand.uniform(1, 3)
2.643472616544236
```

Dans cet exemple, les fonctions du module `random` sont accessibles via l'alias `rand`.

Enfin, pour vider de la mémoire un module déjà chargé, on peut utiliser l'instruction `del`&nbsp;:

```{.python .number-lines}
>>> import random
>>> random.randint(0,10)
2
>>> del random
>>> random.randint(0,10)
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
NameError: name 'random' is not defined
```

On constate alors qu'un rappel (ligne 5) d'une fonction du module `random` après l'avoir vidé de la mémoire (ligne 4) retourne un message d'erreur (lignes 6-8).

## Obtenir de l'aide sur les modules importés

Pour obtenir de l'aide sur un module rien de plus simple, il suffit d'utiliser la commande `help()`&nbsp;:

```python
>>> import random
>>> help(random)
[...]
```

Ce qui renvoie quelque chose du type&nbsp;:

```default
Help on module random:

NAME
    random - Random variable generators.

MODULE REFERENCE
    https://docs.python.org/3.7/library/random

    The following documentation is automatically generated from the Python
    source files.  It may be incomplete, incorrect or include features that
    are considered implementation detail and may vary between Python
    implementations.  When in doubt, consult the module reference at the
    location listed above.

DESCRIPTION
    integers
    --------
           uniform within range

    sequences
    ---------
           pick random element
           pick random sample
```

<div class="remarque">
- Pour vous déplacer dans l'aide, utilisez les flèches du haut et du bas pour parcourir les lignes les unes après les autres, ou les touches *page-up* et *page-down* pour faire défiler l'aide page par page.
- Pour quitter l'aide, appuyez sur la touche *Q*.
- Pour chercher du texte, tapez le caractère `/` puis le texte que vous cherchez puis la touche *Entrée*. Par exemple, pour chercher l'aide sur la fonction `randint()`, tapez `/randint` puis Entrée.
- Vous pouvez également obtenir de l'aide sur une fonction particulière d'un module de la manière suivante&nbsp;: `help(random.randint)`
</div>

La commande `help()` est en fait une commande plus générale permettant d'avoir de l'aide sur n'importe quel objet chargé en mémoire.

```python
>>> t = [1, 2, 3]
>>> help(t)
Help on list object:

class list(object)
 |  list() -> new list
 |  list(sequence) -> new list initialized from sequence's items
 |  
 |  Methods defined here:
 |  
 |  __add__(...)
 |      x.__add__(y) <==> x+y
 |  
...
```

Enfin, pour connaître d'un seul coup d’œil toutes les méthodes ou variables associées à un objet, utilisez la fonction `dir()`&nbsp;:

```python
>>> import random
>>> dir(random)
['BPF', 'LOG4', 'NV_MAGICCONST', 'RECIP_BPF', 'Random', 'SG_MAGICCONST',
'SystemRandom', 'TWOPI', 'WichmannHill', '_BuiltinMethodType', '_MethodT
ype', '__all__', '__builtins__', '__doc__', '__file__', '__name__', '_ac
os', '_ceil', '_cos', '_e', '_exp', '_hexlify', '_inst', '_log', '_pi',
'_random', '_sin', '_sqrt', '_test', '_test_generator', '_urandom', '_wa
rn', 'betavariate', 'choice', 'expovariate', 'gammavariate', 'gauss', 'g
etrandbits', 'getstate', 'jumpahead', 'lognormvariate', 'normalvariate',
 'paretovariate', 'randint', 'random', 'randrange', 'sample', 'seed', 's
 etstate', 'shuffle', 'uniform', 'vonmisesvariate', 'weibullvariate']
>>>
```

## Quelques modules courants

Il existe une série de modules que vous serez probablement amenés à utiliser si vous programmez en Python. En voici une liste non exhaustive. Pour la liste complète, reportez-vous à [la page des modules sur le site de Python](https://docs.python.org/fr/3/py-modindex.html)&nbsp;:

- [`math`](https://docs.python.org/fr/3/library/math.html#module-math)&nbsp;: fonctions et constantes mathématiques de base (sin, cos, exp, pi...).
- [`sys`](https://docs.python.org/fr/3/library/sys.html#module-sys)&nbsp;: interaction avec l'interpréteur Python, passage d'arguments (cf. plus bas).
- [`os`](https://docs.python.org/fr/3/library/os.html#module-os)&nbsp;: dialogue avec le système d'exploitation (cf. plus bas).
- [`random`](https://docs.python.org/fr/3/library/random.html#module-random)&nbsp;: génération de nombres aléatoires.
- [`time`](https://docs.python.org/fr/3/library/time.html#module-time)&nbsp;: accès à l'heure de l'ordinateur et aux fonctions gérant le temps.
- [`urllib`](https://docs.python.org/fr/3/library/urllib.html#module-urllib)&nbsp;: récupération de données sur internet depuis Python.
- [`re`](https://docs.python.org/fr/3/library/re.html#module-re)&nbsp;: gestion des expressions régulières (cf. +@sec:module-re).

Nous vous conseillons d'aller explorer les pages de ces modules pour découvrir toutes leurs potentialités.

Vous verrez dans le +@sec:creation-de-modules comment créer votre propre module lorsque vous souhaitez réutiliser souvent vos propres fonctions.

Enfin, notez qu'il existe de nombreux autres modules externes qui ne sont pas installés de base dans Python mais qui sont très utilisés dans la pratique ([Flask](https://flask.palletsprojects.com/en/1.1.x/), [Requests](https://requests.readthedocs.io/en/master/), [TensorFlow](https://www.tensorflow.org/), [scikit-learn](https://scikit-learn.org/), [Matplotlib](https://matplotlib.org/), [seaborn](https://seaborn.pydata.org/), [SQLAlchemy](https://www.sqlalchemy.org/), …).

## Module `sys`&nbsp;: passage d'arguments

Le module [`sys`](https://docs.python.org/fr/3/library/sys.html#module-sys) contient des fonctions et des variables spécifiques à l'interpréteur Python lui-même. Ce module est particulièrement intéressant pour récupérer les arguments passés à un script Python lorsque celui-ci est appelé en ligne de commande.

Dans cet exemple, créons le court script suivant que l'on enregistrera sous le nom `test.py`&nbsp;:

```python
import sys
print(sys.argv)
```

Ensuite, dans un *shell*, exécutons le script `test.py` suivi de plusieurs arguments. Par exemple&nbsp;:

```{.default .number-lines}
$ python test.py salut girafe 42
['test.py', 'salut', 'girafe', '42']
```

Ligne 1. Le caractère `$` représente l'invite du *shell*, `test.py` est le nom du script Python, `salut`, `girafe` et `42` sont les arguments passés au script (tous séparés par un espace).

Ligne 2. Le script affiche le contenu de la variable `sys.argv`. Cette variable est une liste qui contient tous les arguments de la ligne de commande, y compris le nom du script lui-même qu'on retrouve comme premier élément de cette liste dans `sys.argv[0]`. On peut donc accéder à chacun des arguments du script avec `sys.argv[1]`, `sys.argv[2]`, …

Toujours dans le module `sys`, la fonction `sys.exit()` est utile pour quitter un script Python. On peut donner un argument à cette fonction (en général une chaîne de caractères) qui sera renvoyé au moment où Python quittera le script. Par exemple, si vous attendez au moins un argument en ligne de commande, vous pouvez renvoyer un message pour indiquer à l'utilisateur ce que le script attend comme argument&nbsp;:

```python
import sys

if len(sys.argv) != 2:
    sys.exit("ERREUR : il faut exactement un argument.")

print("Argument vaut : {}".format(sys.argv[1]))
```

Puis on l'exécute sans argument&nbsp;:

```default
$ python test.py
ERREUR : il faut exactement un argument.
```

et avec un argument&nbsp;:

```default
$ python test.py 42
Argument vaut : 42
```

Notez qu'ici on vérifie que le script possède deux arguments car le nom du script lui-même compte pour un argument (le tout premier).

L'intérêt de récupérer des arguments passés dans la ligne de commande à l'appel du script est de pouvoir ensuite les utiliser dans le script.

Voici à titre d'exemple le script `compte_lignes.py` qui va prendre comme argument le nom d'un fichier puis afficher le nombre de lignes qu'il contient.

```python
import sys

if len(sys.argv) != 2:
    sys.exit("ERREUR : il faut exactement un argument.")

nom_fichier = sys.argv[1]
taille = 0
with open(nom_fichier, "r") as f_in:
    taille = len(f_in.readlines())

print("{} contient {} lignes.".format(nom_fichier, taille))
```

Supposons que dans le même répertoire, nous ayons le fichier `zoo1.txt` dont voici le contenu&nbsp;:

```default
girafe
tigre
singe
souris
```

et le fichier `zoo2.txt` qui contient&nbsp;:

```default
poisson
abeille
chat
```

Utilisons maintenant notre script `compte_lignes.py`&nbsp;:

```default
$ python compte_lignes.py
ERREUR : il faut exactement un argument.
$ python compte_lignes.py zoo1.txt
zoo1.txt contient 4 lignes.
$ python compte_lignes.py zoo2.txt
zoo2.txt contient 3 lignes.
```

Notre script est donc capable de&nbsp;:

- Vérifier si un argument lui est donné et si ce n'est pas le cas d'afficher un message d'erreur.
- D'ouvrir le fichier dont le nom est fourni en argument, de compter puis d'afficher le nombre de lignes.

Par contre, le script ne vérifie pas si le fichier existe bien&nbsp;:

```default
$ python compte_lignes.py zoo3.txt
Traceback (most recent call last):
 File "compte_lignes.py", line 8, in <module>
   with open(nom_fichier, "r") as f_in:
FileNotFoundError: [Errno 2] No such file or directory: 'zoo3.txt'
```

La lecture de la partie suivante va nous permettre d'améliorer notre script `compte_lignes.py`.

## Module `os`&nbsp;: interaction avec le système d'exploitation

Le module [`os`](https://docs.python.org/fr/3/library/os.html#module-os) gère l'interface avec le système d'exploitation.

La fonction `os.path.exists()` est une fonction pratique de ce module qui vérifie la présence d'un fichier sur le disque dur.

```python
>>> import sys
>>> import os
>>> if os.path.exists("toto.pdb"):
...     print("le fichier est présent")
... else:
...     sys.exit("le fichier est absent")
...
le fichier est absent
```

Dans cet exemple, si le fichier n'existe pas sur le disque, on quitte le programme avec la fonction `exit()` du module `sys` que nous venons de voir.

La fonction `os.getcwd()` renvoie le répertoire (sous forme de chemin complet) depuis lequel est lancé Python&nbsp;:

```python
>>> import os
>>> os.getcwd()
'/home/pierre'
```

Enfin, la fonction `os.listdir()` renvoie le contenu du répertoire depuis lequel est lancé Python&nbsp;:

```python
>>> import os
>>> os.listdir()
['1BTA.pdb', 'demo.py', 'tests']
```

Le résultat est renvoyé sous forme d'une liste contenant à la fois le nom des fichiers et des répertoires.

Il existe de nombreuse autres fonctions dans le module `os`, n'hésitez pas à consulter la documentation.

## Travaux pratiques

Les travaux pratiques sont disponibles [en ligne](https://colab.research.google.com/drive/1ihA98Kypgv6JwpmCF_6c6cyhB7PHSXBv#forceEdit=true&sandboxMode=true).
