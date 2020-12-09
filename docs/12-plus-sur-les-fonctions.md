# Plus sur les fonctions

Avant d'aborder ce chapitre, nous vous conseillons de relire le +@sec:fonctions et de bien en assimiler toutes les notions (et aussi d'en faire les exercices). Nous avons vu dans ce +@sec:fonctions le concept puissant et incontournable que représentent les **fonctions**. Nous avons également introduit la notion de variables **locales** et **globales**.

Dans ce chapitre, nous allons aller un peu plus loin sur la visibilité de ces variables dans et hors des fonctions, et aussi voir ce qui se passe lorsque ces variables sont des listes. Attention, la plupart des lignes de code ci-dessous sont données à titre d'exemple pour bien comprendre ce qui se passe, mais nombre d'entre elles sont des aberrations en terme de programmation. Nous ferons un récapitulatif des bonnes pratiques à la fin du chapitre. Enfin, nous vous conseillons de tester tous les exemples ci-dessous avec le site [*Python Tutor*](http://www.pythontutor.com/) afin de suivre l'état des variables lors de l'exécution des exemples.

## Appel d'une fonction dans une fonction

Dans le +@sec:fonctions nous avons vu des fonctions qui étaient appelées depuis le programme principal. Il est en fait possible d'appeler une fonction depuis une autre fonction. Et plus généralement, on peut appeler une fonction de n'importe où à partir du moment où elle est visible par Python (c'est-à-dire chargée dans la mémoire). Observez cet exemple&nbsp;:

```python
# définition des fonctions
def polynome(x):
    return (x**2 - 2*x + 1)

def calc_vals(debut, fin):
    liste_vals = []
    for x in range(debut, fin + 1):
        liste_vals.append(polynome(x))
    return liste_vals

# programme principal
print(calc_vals(-5, 5))
```

Nous appelons depuis le programme principal la fonction `calc_vals()`, puis à l'intérieur de celle-ci nous appelons l'autre fonction `polynome()`. Regardons ce que *Python Tutor* nous montre lorsque la fonction `polynome()` est exécutée dans la +@fig:appel-fct-ds-fct.

![Appel d'une fonction dans une fonction.](img/appel-fct-ds-fct.png){#fig:appel-fct-ds-fct}

L'espace mémoire alloué à `polynome()` est grisé, indiquant que cette fonction est en cours d'exécution. La fonction appelante `calc_vals()` est toujours là (sur un fond blanc) car son exécution n'est pas terminée. Elle est en quelque sorte *figée* dans le même état qu'avant l'appel de `polynome()`, et on pourra ainsi noter que ses variables *locales* (`debut`, `fin`, `liste_vals` et `x`) sont toujours là . De manière générale, les variables *locales* d'une fonction ne seront détruites que lorsque l'exécution de celle-ci sera terminée. Dans notre exemple, les variables *locales* de `calc_vals()` ne seront détruites que lorsque la boucle sera terminée et que la liste `liste_vals` sera retournée au programme principal. Enfin, notez bien que la fonction `calc_vals()` appelle la fonction `polynome()` à chaque itération de la boucle.

Ainsi, le programmeur est libre de faire tous les appels qu'il souhaite. Une fonction peut appeler une autre fonction, cette dernière peut appeler une autre fonction et ainsi de suite (et autant de fois qu'on le veut). Une fonction peut même s'appeler elle-même, cela s'appelle une fonction *récursive* (voir la rubrique suivante). Attention toutefois à retrouver vos petits si vous vous perdez dans les appels successifs&nbsp;!

## Fonctions récursives

*Conseil&nbsp;:* pour les débutants, vous pouvez passer cette rubrique.

Une fonction récursive est une fonction qui s'appelle elle-même. Les fonctions récursives permettent d'obtenir une efficacité redoutable dans la résolution de certains algorithmes comme le [tri rapide](https://fr.wikipedia.org/wiki/Tri_rapide) (en anglais *quicksort*).

Oublions la recherche d'efficacité pour l'instant et concentrons-nous sur l'exemple de la fonction mathématique factorielle. Nous vous rappelons que la factorielle s'écrit avec un `!` et se définit de la manière suivante&nbsp;:

\begin{align*}
  3! &= 3 \times 2 \times 1 = 6 \\
  4! &= 4 \times 3 \times 2 \times 1 = 30 \\
  n! &= n \times (n − 1) \times … \times 2 \times 1 \\
\end{align*}

Voici le code Python avec une fonction récursive&nbsp;:

```{.python .number-lines}
def calc_factorielle(nb):
    if nb == 1:
        return 1
    else:
        return nb * calc_factorielle(nb - 1)

# prog principal
print(calc_factorielle(4))
```

Pas très facile à comprendre, n'est-ce pas&nbsp;? À nouveau, nous nous aidons de *Python Tutor* pour visualiser ce qui se passe dans la +@fig:fct-recursive-factorielle (nous vous conseillons bien sûr de tester vous-même cet exemple)&nbsp;:

![Fonction récursive&nbsp;: factorielle.](img/fct-recursive-factorielle.png){#fig:fct-recursive-factorielle}

Ligne 8, on appelle la fonction `calc_factorielle()` en passant comme argument l'entier `4`. Dans la fonction, la variable locale qui récupère cet argument est `nb`. Au sein de la fonction, celle-ci se rappelle elle-même (ligne 5), mais cette fois-ci en passant la valeur `3`. Au prochain appel, ce sera avec la valeur `2`, puis finalement `1`. Dans ce dernier cas, le test `if nb == 1:` est vrai et l'instruction `return 1` sera exécutée. À ce moment précis de l'exécution, les appels successifs forment une sorte de pile (voir la +@fig:fct-recursive-factorielle). La valeur `1` sera ainsi renvoyée au niveau de l'appel précédent, puis le résultat $2 \times 1 = 2$ (où $2$ correspond à `nb` et $1$ provient de `calc_factorielle(nb - 1)` soit `1`) va être renvoyé à l'appel précédent, puis $3 \times 2 = 6$ (où $3$ correspond à `nb` et $2$ provient de `calc_factorielle(nb - 1)` soit `2`) va être renvoyé à l'appel précédent, pour finir par $4 \times 6 = 24$ (où $4$ correspond à `nb` et $6$ provient de `calc_factorielle(nb - 1)` soit `6`), soit la valeur de $4!$. Les appels successifs vont donc se «&nbsp;dépiler&nbsp;» et nous reviendrons dans le programme principal.

Même si les fonctions récursives peuvent être ardues à comprendre, notre propos est ici de vous illustrer qu'une fonction qui en appelle une autre (ici il s'agit d'elle-même) reste «&nbsp;figée&nbsp;» dans le même état, jusqu'à ce que la fonction appelée lui renvoie une valeur.

## Portée des variables

Il est très important lorsque l'on manipule des fonctions de connaître la portée des variables (*scope* en anglais), c'est-à-dire savoir là où elles sont visibles. On a vu que les variables créées au sein d'une fonction ne sont pas visibles à l'extérieur de celle-ci car elles étaient **locales** à la fonction. Observez le code suivant&nbsp;:

```python
>>> def ma_fonction():
...     x = 2
...     print('x vaut {} dans la fonction'.format(x))
...
>>> ma_fonction()
x vaut 2 dans la fonction
>>> print(x)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'x' is not defined
```

Lorsque Python exécute le code de la fonction, il connaît le contenu de la variable `x`. Par contre, de retour dans le module principal (dans ce cas, il s'agit de l'interpréteur Python), il ne la connaît plus, d'où le message d'erreur.

De même, une variable passée en argument est considérée comme **locale** lorsqu'on arrive dans la fonction:

```python
>>> def ma_fonction(x):
...     print('x vaut {} dans la fonction'.format(x))
...
>>> ma_fonction(2)
x vaut 2 dans la fonction
>>> print(x)
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
NameError: name 'x' is not defined
```

Lorsqu'une variable est déclarée dans le programme principal, elle est visible dans celui-ci ainsi que dans toutes les fonctions. On a vu qu'on parlait de variable **globale**&nbsp;:

```python
>>> def ma_fonction():
...     print(x)
...
>>> x = 3
>>> ma_fonction()
3
>>> print(x)
3
```

Dans ce cas, la variable `x` est visible dans le module principal et dans toutes les fonctions du module. Toutefois, Python ne permet pas la modification d'une variable globale dans une fonction:

```python
>>> def ma_fonction():
...     x = x + 1
...
>>> x = 1
>>> ma_fonction()
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in fct
UnboundLocalError: local variable 'x' referenced before assignment
```

L'erreur renvoyée montre que Python pense que `x` est une variable locale qui n'a pas été encore assignée. Si on veut vraiment modifier une variable globale dans une fonction, il faut utiliser le mot-clé `global`&nbsp;:

```python
>>> def ma_fonction():
...     global x
...     x = x + 1
...
>>> x = 1
>>> ma_fonction()
>>> x
2
```

Dans ce dernier cas, le mot-clé `global` a forcé la variable `x` à être globale plutôt que locale au sein de la fonction.

## Portée des listes

<div class="attention">
Les exemples de cette partie représentent des absurdités en termes de programmation. Ils sont donnés à titre indicatif pour comprendre ce qui se passe, mais il ne faut surtout pas s'en inspirer&nbsp;!
</div>

Soyez extrêmement attentifs avec les types modifiables (tels que les listes) car vous pouvez les changer au sein d'une fonction&nbsp;:

```python
>>> def ma_fonction():
...     liste[1] = -127
...
>>> liste = [1, 2, 3]
>>> ma_fonction()
>>> liste
[1, -127, 3]
```

De même, si vous passez une liste en argument, elle est modifiable au sein de la fonction&nbsp;:

```python
>>> def ma_fonction(x):
...     x[1] = -15
...
>>> y = [1, 2, 3]
>>> ma_fonction(y)
>>> y
[1, -15, 3]
```

Si vous voulez éviter ce problème, utilisez des n-uplets (ils seront présentés dans le +@sec:dictionnaires-n-uplets-et-ensembles), Python renverra une erreur car ces derniers sont non modifiables.

Une autre solution pour éviter la modification d'une liste, lorsqu'elle est passée comme argument à une fonction, est de la passer en copie explicitement afin qu'elle reste intacte dans le programme principal.

```python
>>> def ma_fonction(x):
...     x[1] = -15
...
>>> y = [1, 2, 3]
>>> ma_fonction(y[:])
>>> y
[1, 2, 3]
>>> ma_fonction(list(y))
>>> y
[1, 2, 3]
```

Dans ces deux derniers exemples, une copie de `y` est créée à la volée lorsqu'on appelle la fonction, ainsi la liste `y` du module principal reste intacte.

## Règle LGI

Lorsque Python rencontre une variable, il va traiter la résolution de son nom avec des priorités particulières. D'abord il va regarder si la variable est **locale**, puis si elle n'existe pas localement, il vérifiera si elle est **globale** et enfin si elle n'est pas globale, il testera si elle est **interne** (par exemple la fonction `len()` est considérée comme une fonction interne à Python, elle existe à chaque fois que vous lancez Python). On appelle cette règle la règle **LGI** pour locale, globale, interne. En voici un exemple&nbsp;:

```python
>>> def ma_fonction():
...     x = 4
...     print('Dans la fonction x vaut {}'.format(x))
...
>>> x = -15
>>> ma_fonction()
Dans la fonction x vaut  4
>>> print('Dans le module principal x vaut {}'.format(x))
Dans le module principal x vaut -15
```

Dans la fonction, `x` a pris la valeur qui lui était définie localement en priorité sur la valeur définie dans le module principal.

<div class="conseils">
Même si Python peut reconnaître une variable ayant le même nom que ses propres fonctions ou variables internes, évitez de les utiliser car ceci rendra votre code confus&nbsp;!
</div>

De manière générale la règle LGI découle de la manière dont Python gère ce que l'on appelle «&nbsp;les espaces de noms&nbsp;». C'est cette gestion qui définit la portée (visibilité) de chaque variable. Nous en parlerons plus longuement dans le chapitre 19 Avoir la classe avec les objets.

## Recommandations

### Évitez les variables globales

Dans ce chapitre nous avons *joué* avec les fonctions (et les listes) afin de vous montrer comment Python réagissait. Toutefois, notez bien que **l'utilisation de variables globales est à bannir définitivement de votre pratique de la programmation**.

Parfois on veut faire vite et on crée une variable globale visible partout dans le programme (donc dans toutes les fonctions), car *«&nbsp;Ça va plus vite, c'est plus simple&nbsp;»*. C'est un très mauvais calcul, ne serait-ce que parce que vos fonctions ne seront pas réutilisables dans un autre contexte si elles utilisent des variables globales&nbsp;! Ensuite, arriverez-vous à vous relire dans six mois&nbsp;? Quelqu'un d'autre pourrait-il comprendre votre programme&nbsp;? Il existe de nombreuses autres [raisons](http://wiki.c2.com/?GlobalVariablesAreBad) que nous ne développerons pas ici, mais libre à vous de consulter de la documentation externe.

Heureusement, Python est orienté objet et permet «&nbsp;d'encapsuler&nbsp;» des variables dans des objets et de s'affranchir définitivement des variables globales (nous verrons cela dans le chapitre 19 Avoir la classe avec les objets). En attendant, et si vous ne souhaitez pas aller plus loin sur les notions d'objet (on peut tout à fait «&nbsp;pythonner&nbsp;» sans cela), retenez la chose suivante sur les fonctions et les variables globales&nbsp;:

<div class="conseils">
Plutôt que d'utiliser des variables globales, passez vos variables explicitement aux fonctions comme des argument(s).
</div>

## Modifications sur place ou création d'un nouvel objet

Concernant les fonctions qui modifient un objet mutable (une liste par exemple), vous avez deux options&nbsp;:

- Renvoyer une copie de l'objet avec les modifications de la fonction
- Faire les modifications sur place en modifiant l'objet et en ne renvoyant rien

<div class="conseils">
Mélanger ces deux pratiques dans un même programme est très dangereux pour la lisibilité.

La première méthode est à privilégier tant que cela ne pose pas de problèmes de performance&nbsp; elle crée moins de bugs en moyenne.
</div>

Voyons ce que cela donne en pratique avec tout d'abord une version qui renvoie une nouvelle liste&nbsp;:

```{.python .number-lines}
# Version qui renvoie une nouvelle liste
def ajoute_un(liste):
    resultat = []
    for elem in liste:
        resultat.append(elem + 1)
    return resultat

# Programme principal.
liste_notes = [10, 8, 16, 7, 15]
liste_notes = ajoute_un(liste_notes)
print(liste_notes)
```

On peut voir ici que ligne 3, on crée une nouvelle liste qu'on finira par renvoyer ligne 6.
On doit donc récupérer cette liste dans une variable, comme on le fait ligne 10.

Voyons maintenant une version qui modifie sur place&nbsp;:

```{.python .number-lines}
# Version qui modifie sur place
def ajoute_un(liste):
    for i in range(len(liste)):
        liste[i] += 1

# Programme principal.
liste_notes = [10, 8, 16, 7, 15]
ajoute_un(liste_notes)
print(liste_notes)
```

On voit ici qu'on ne crée pas de copie et qu'on ne renvoie rien.
Ligne 8, on ne doit donc pas récupérer le résultat de la fonction dans une variable.

### Conclusion

Vous connaissez maintenant les fonctions sous tous leurs angles. Comme indiqué en introduction du +@sec:fonctions, elles sont incontournables et tout programmeur se doit de les maîtriser. Voici les derniers conseils que nous pouvons vous donner&nbsp;:

- Lorsque vous débutez un nouveau projet de programmation, posez-vous la question&nbsp;: «&nbsp;Comment pourrais-je décomposer en blocs chaque tâche à effectuer, chaque bloc pouvant être une fonction&nbsp;?&nbsp;». Et n'oubliez pas que si une fonction s'avère trop complexe, vous pouvez également la décomposer en d'autres fonctions.
- Au risque de nous répéter, forcez-vous à utiliser des fonctions en permanence. Pratiquez, pratiquez... et pratiquez encore&nbsp;!

## Exercices

*Conseils&nbsp;:* pour le second exercice, créez un script puis exécutez-le dans un *shell*.

### Prédire la sortie

Prédisez le comportement des codes suivants, sans les recopier dans un script ni dans l'interpréteur Python&nbsp;:

#### Code 1{-}

```python
def hello(prenom):
  print("Bonjour {}".format(prenom))


# Programme principal.
hello("Patrick")
print(x)
```

#### Code 2{-}

```python
def hello(prenom):
  print("Bonjour {}".format(prenom))


# Programme principal.
x = 10
hello("Patrick")
print(x)
```

#### Code 3{-}

```python
def hello(prenom):
  print("Bonjour {}".format(prenom))
  print(x)


# Programme principal.
x = 10
hello("Patrick")
print(x)
```

#### Code 4{-}

```python
def hello(prenom):
  x = 42
  print("Bonjour {}".format(prenom))
  print(x)


# Programme principal.
x = 10
hello("Patrick")
print(x)
```

### Passage de liste à une fonction

Créez une fonction `ajoute_nb_alea()` qui prend en argument une liste et qui ajoute un nombre entier aléatoire entre -10 et 10 (inclus) à chaque élément. La fonction affichera à l'écran cette nouvelle liste modifiée.

Dans le programme principal, on effectuera les actions suivantes&nbsp;:

- Créer une variable `ma_liste = [7, 3, 8, 4, 5, 1, 9, 10, 2, 6]`.
- Afficher `ma_liste` à l'écran.
- Appeler la fonction `ajoute_nb_alea()` en lui passant `ma_liste` en argument.
- Afficher à nouveau `ma_liste` à l'écran.

Comment expliquez-vous le résultat obtenu&nbsp;?
