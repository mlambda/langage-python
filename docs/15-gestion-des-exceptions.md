# Gestion des exceptions

Les langages de programmation comme Python contiennent un [système de gestion des **exceptions**](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_d%27exceptions). Qu'est-ce qu'une exception ? Sur la [page anglaise de Wikipedia](https://en.wikipedia.org/wiki/Exception_handling), une exception est définie comme une anomalie de l'exécution d'un programme requérant une action spéciale, en général l'arrêt de l'exécution. Le plus souvent, **une exception correspond à une erreur** que Python rencontre lorsqu'il tente d'exécuter les lignes de code qu'on lui soumet. Par exemple, un problème de syntaxe, une variable ou objet qui prend une valeur aberrante (par exemple diviser par 0, parcourir une liste au delà du nombre d'éléments, etc.). 

Le système de gestion des exceptions évite que votre programme « plante » en prévoyant vous-même les sources d'erreurs éventuelles.

Voici un exemple dans lequel on demande à l'utilisateur d'entrer un nombre entier, puis on affiche ce nombre.

```python
>>> nb = int(input("Entrez un nombre entier : "))
Entrez un nombre entier : 23
>>> print(nb)
23
```

La fonction `input()` demande à l'utilisateur de saisir une chaîne de caractères. Cette chaîne de caractères est ensuite transformée en nombre entier avec la fonction `int()`.

Si l'utilisateur ne rentre pas un nombre, voici ce qui se passe :

```python
>>> nb = int(input("Entrez un nombre entier : "))
Entrez un nombre entier : ATCG
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: invalid literal for int() with base 10: 'ATCG'
```

L'erreur provient de la fonction `int()` qui n'a pas pu convertir la chaîne de caractères `"ATCG"` en nombre entier, ce qui est parfaitement normal. En termes plus techniques, on dira que « Python a levé une exception de type `ValueError` ». Eh oui il y a de nombreux types d'exceptions différents (voir plus bas) ! Le nom de l'exception apparaît toujours comme le premier mot de la dernière ligne du message d'erreur. Si nous lancions ces lignes de code sous forme de script (du style `python script.py`), cet exemple conduirait à l'arrêt de l'exécution du programme.

Le jeu d'instructions `try` / `except` permet de tester l'exécution d'une commande et d'intervenir en cas de levée d'exception.

```python
>>> try:
...     nb = int(input("Entrez un nombre entier : "))
... except:
...     print("Vous n'avez pas entré un nombre entier !")
...
Entrez un nombre entier : ATCG
Vous n'avez pas entré un nombre entier !
```

Dans cette exemple, l'exception levée par la fonction `int()` (qui ne peut pas convertir `"ATCG"` en nombre entier) est interceptée et déclenche l'affichage du message d'avertissement.

On peut ainsi redemander sans cesse un nombre entier à l'utilisateur, jusqu'à ce que celui-ci en rentre bien un.

```python
>>> while True:
...     try:
...             nb = int(input("Entrez un nombre entier : "))
...             print("Le nombre est", nb)
...             break
...     except:
...             print("Vous n'avez pas entré un nombre entier !")
...             print("Essayez encore")
...
Entrez un nombre entier : ATCG
Vous n'avez pas entré un nombre entier !
Essayez encore
Entrez un nombre entier : toto
Vous n'avez pas entré un nombre entier !
Essayez encore
Entrez un nombre entier : 3.2
Vous n'avez pas entré un nombre entier !
Essayez encore
Entrez un nombre entier : 55
Le nombre est 55
```

Notez que dans cet exemple, l'instruction `while True` est une boucle infinie car la condition `True` est toujours vérifiée. L'arrêt de cette boucle est alors forcé par la commande `break` lorsque l'utilisateur a effectivement entré un nombre entier.

La gestion des exceptions est très utile dès lors que des données extérieures entrent dans un programme Python, que ce soit directement par l'utilisateur (avec la fonction `input()`) ou par des fichiers. Cela est fondamental si vous distribuez votre code à la communauté : si les utilisateurs ne connaissent pas Python, un message comme `Vous n'avez pas entré un nombre entier !` reste plus clair que `ValueError: invalid literal for int() with base 10: 'ATCG'`.

Vous pouvez par exemple vérifier qu'un fichier a bien été ouvert.

```python
>>> nom = "toto.pdb"
>>> try:
...     with open(nom, "r") as fichier:
...         for ligne in fichier:
...             print(ligne)
... except:
...     print("Impossible d'ouvrir le fichier", nom)
```

Si une erreur est déclenchée, c'est sans doute que le fichier n'existe pas à l'emplacement indiqué sur le disque ou que vous n'avez pas les droits pour le lire.

Il est également possible de spécifier le type d'erreur à gérer. Le premier exemple que nous avons étudié peut s'écrire :

```python
>>> try:
...     nb = int(input("Entrez un nombre entier : "))
... except ValueError:
...     print("Vous n'avez pas entré un nombre entier !")
...
Entrez un nombre entier : ATCG
Vous n'avez pas entré un nombre entier !
```

Ici, on intercepte une exception de type `ValueError`, ce qui correspond bien à un problème de conversion avec `int()`. 

Attention, si vous précisez le type d'exception comme `ValueError`, le `except ValueError` n'empêchera pas la levée d'une autre exception.

```python
>>> try:
...     nb = int(variable)
... except ValueError:
...     print("Vous n'avez pas entré un nombre entier !")
...
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
NameError: name 'variable' is not defined
```

Ici l'exception levée est de type `NameError` car `variable` n'existe pas. Alors que si vous mettez `except` tout court, cela intercepte n'importe quelle exception.

```python
>>> try:
...    nb = int(variable)
... except:
...    print("Vous n'avez pas entré un nombre entier !")
...
Vous n'avez pas entré un nombre entier !
>>>
```

Vous voyez qu'ici cela pose un nouveau problème : le message d'erreur ne correspond pas à l'exception levée !

<div class="conseils">
- Nous vous conseillons vivement de toujours préciser le type d'exception dans vos `except`. Cela évite d'intercepter une exception que vous n'aviez pas prévue. Il est possible d'intercepter plusieurs types d'exceptions en passant un tuple à `except`, par exemple : `except (Exception1, Exception2)`. 
- Pa ailleurs, ne mettez pas trop de lignes dans le bloc du `try`. Dans un tel cas, il peut être très pénible de trouver la ligne qui a conduit à l'exécution du `except`. Pire encore, il se peut que des lignes que vous aviez prévues ne soient pas exécutées ! Donc gardez des choses simples dans un premier temps, comme par exemple tester les conversions de type ou vérifier qu'un fichier existe bien et que vous pouvez l'ouvrir.
</div>

Il existe de nombreux types d'exception comme `RuntimeError`, `TypeError`, `NameError`, `IOError`, etc. Vous pouvez aller voir la [liste complète](https://docs.python.org/fr/3.7/library/exceptions.html#exceptions.TypeError) sur le site de Python. Nous avions déjà croisé des noms d'exception au +@sec:avoir-la-classe-avec-les-objets en regardant ce que contient le module `builtins`.

```python
>>> import builtins
>>> dir(builtins)
['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException',
[...]
'UserWarning', 'ValueError', 'Warning', 'ZeroDivisionError'
[...]
```

Leur présence dans le module `builtins` signifie qu'elles font partie du langage lui même, au même titre que les fonctions de base comme `range()`, `list()`, etc. 

Avez-vous aussi remarqué que leur nom commence toujours par une majuscule et qu'il peut en contenir plusieurs à la façon *CamelCase* ? Nous verrons dans le +@sec:bonnes-pratiques-en-programmation-python pourquoi plus précisément. Pour l'instant, on peut noter que c'est parce que **les exceptions sont des classes**. C'est très intéressant car il est ainsi possible d'utiliser l'héritage pour créer ses propres exceptions à partir d'exceptions pré-existantes. Nous ne développerons pas cet aspect, mais en guise d'illustration, regardez ce que renvoit  un `help()` de l'exception `OverflowError`.

```default
>>> help(OverflowError)
[...]
class OverflowError(ArithmeticError)
 |  Result too large to be represented.
 |
 |  Method resolution order:
 |      OverflowError
 |      ArithmeticError
 |      Exception
 |      BaseException
 |      object
```

L'exception `OverflowError` hérite de `ArithmeticError`, c'est-à-dire qu'`OverflowError` a été conçue à partir de `ArithmeticError` et en hérite de tous ses attributs.

Un autre aspect très important que nous avons croisé au +@sec:avoir-la-classe-avec-les-objets est la possibilité de lever vous-même une exception avec le mot-clé `raise`. Nous avions vu le code suivant :

```python
if valeur < 0:
    raise ValueError("Z'avez déjà vu une masse négative ? C'est nawak")
```

La ligne 2 lève une exception `ValueError` lorsque la variable `valeur` est négative. L'instruction `raise` est bien pratique lorsque vous souhaitez stopper l'exécution d'un programme si une variable ne se trouve pas dans le bon intervalle ou ne contient pas la bonne valeur. Vous avez sans doute compris maintenant pourquoi on parlait de « levée » d'exception... Pour les non anglophones, allez voir ce que signifie *raise* en anglais ;-) !

Enfin, on peut aussi être très précis dans le message d'erreur. Observez la fonction `download_page()` qui, avec le module *urllib*, télécharge un fichier sur internet.

```python
import urllib.request

def download_page(address):
    error = ""
    page = ""
    try:
        data = urllib.request.urlopen(address)
        page = data.read()
    except IOError as e:
        if hasattr(e, 'reason'):
            error =  "Cannot reach web server: " + str(e.reason)
        if hasattr(e, 'code'):
            error = "Server failed {:d}".format(e.code)
    return page, error

data, error = download_page("https://files.rcsb.org/download/1BTA.pdb")

if error:
    print("Erreur rencontrée : {}".format(error))
else:
    with open("proteine.pdb", "w") as prot:
        prot.write(data.decode('utf-8'))
    print("Protéine enregistrée")
```

La variable `e` est une instance de l'exception `IOError`. Certains de ses attributs sont testés avec la fonction `hasattr()` pour ainsi affiner le message renvoyé (ici contenu dans la variable `error`).

Si tout se passe bien, la page est téléchargée est stockée dans la variable `data`, puis ensuite enregistrée sur le disque dur.

Pour aller plus loin sur les exceptions, vous pouvez lire l'[excellente page](http://sametmax.com/gestion-des-erreurs-en-python/) du blog impertinent et politiquement incorrect de Sam et Max.
