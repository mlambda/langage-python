# Tests{#sec:tests}

## Définition

Les **tests** sont un élément essentiel à tout langage informatique si on veut lui donner un peu de complexité car ils permettent à l'ordinateur de prendre des décisions.
Pour cela, Python utilise l'instruction `if` ainsi qu'une comparaison que nous avons abordée au chapitre précédent.
Voici un premier exemple&nbsp;:

```python
>>> x = 2
>>> if x == 2:
...     print("Le test est vrai !")
...
Le test est vrai !
```

et un second&nbsp;:

```python
>>> x = "souris"
>>> if x == "tigre":
...     print("Le test est vrai !")
...
```

Il y a plusieurs remarques à faire concernant ces deux exemples&nbsp;:

- Dans le premier exemple, le test étant vrai, l'instruction `print("Le test est vrai !")` est exécutée. Dans le second exemple, le test est faux et rien n'est affiché.
- Les blocs d'instructions dans les tests doivent forcément être indentés comme pour les boucles `for` et `while`. L'indentation indique la portée des instructions à exécuter si le test est vrai.
- Comme avec les boucles `for` et `while`, la ligne qui contient l'instruction `if` se termine par le caractère deux-points «&nbsp;`:`&nbsp;».

## Tests à plusieurs cas

Parfois, il est pratique de tester si la condition est vraie ou si elle est fausse dans une même instruction `if`. Plutôt que d'utiliser deux instructions `if`, on peut se servir des instructions `if` et `else`&nbsp;:

```python
>>> x = 2
>>> if x == 2:
...     print("Le test est vrai !")
... else:
...     print("Le test est faux !")
...
Le test est vrai !
>>> x = 3
>>> if x == 2:
...     print("Le test est vrai !")
... else:
...     print("Le test est faux !")
...
Le test est faux !
```

On peut utiliser une série de tests dans la même instruction `if`, notamment pour tester plusieurs valeurs d'une même variable.

Par exemple, on se propose de tirer au sort une base d'ADN puis d'afficher le nom de cette dernière. Dans le code suivant, nous utilisons l'instruction `random.choice(liste)` qui renvoie un élément choisi au hasard dans une liste. L'instruction `import random` sera vue plus tard dans le +@sec:modules, admettez pour le moment qu'elle est nécessaire.

```python
>>> import random
>>> base = random.choice(["a", "t", "c", "g"])
>>> if base == "a":
...     print("choix d'une adénine")
... elif base == "t":
...     print("choix d'une thymine")
... elif base == "c":
...     print("choix d'une cytosine")
... elif base == "g":
...     print("choix d'une guanine")
...
choix d'une cytosine
```

Dans cet exemple, Python teste la première condition, puis, si et seulement si elle est fausse, teste la deuxième et ainsi de suite… Le code correspondant à la première condition vérifiée est exécuté puis Python sort du bloc d'instructions du `if`.

## Importance de l'indentation

De nouveau, faites bien attention à l'indentation ! Vous devez être très rigoureux sur ce point. Pour vous en convaincre, exécutez ces deux exemples de code&nbsp;:

Code 1

```{.python .number-lines}
nombres = [4, 5, 6]
for nb in nombres:
    if nb == 5:
        print("Le test est vrai")
        print("car la variable nb vaut {}".format(nb))
```

Résultat&nbsp;:

```default
Le test est vrai
car la variable nb vaut 5
```

Code 2

```{.python .number-lines}
nombres = [4, 5, 6]
for nb in nombres:
    if nb == 5:
        print("Le test est vrai")
    print("car la variable nb vaut {}".format(nb))
```

Résultat&nbsp;:

```default
car la variable nb vaut 4
Le test est vrai
car la variable nb vaut 5
car la variable nb vaut 6
```

Les deux codes pourtant très similaires produisent des résultats très différents. Si vous observez avec attention l'indentation des instructions sur la ligne 5, vous remarquerez que dans le code 1, l'instruction est indentée deux fois, ce qui signifie qu'elle appartient au bloc d'instructions du test `if`. Dans le code 2, l'instruction de la ligne 5 n'est indentée qu'une seule fois, ce qui fait qu'elle n'appartient plus au bloc d'instructions du test `if`, d'où l'affichage de `car la variable nb vaut xx` pour toutes les valeurs de `nb`.

## Tests multiples

Les tests multiples permettent de tester plusieurs conditions en même temps en utilisant des opérateurs booléens. Les deux opérateurs les plus couramment utilisés sont le **OU** et le **ET**. Voici un petit rappel sur le fonctionnement de l'opérateur **OU**&nbsp;:

| Condition 1 | Opérateur | Condition 2 | Résultat |
|:-----------:|:---------:|:-----------:|:--------:|
|    Vrai     |    OU     |    Vrai     |   Vrai   |
|    Vrai     |    OU     |    Faux     |   Vrai   |
|    Faux     |    OU     |    Vrai     |   Vrai   |
|    Faux     |    OU     |    Faux     |   Faux   |

et de l'opérateur **ET**&nbsp;:

| Condition 1 | Opérateur | Condition 2 | Résultat |
|:-----------:|:---------:|:-----------:|:--------:|
|    Vrai     |    ET     |    Vrai     |   Vrai   |
|    Vrai     |    ET     |    Faux     |   Faux   |
|    Faux     |    ET     |    Vrai     |   Faux   |
|    Faux     |    ET     |    Faux     |   Faux   |

En Python, on utilise le mot réservé `and` pour l'opérateur **ET** et le mot réservé `or` pour l'opérateur **OU**. Respectez bien la casse des opérateurs `and` et `or` qui, en Python, s'écrivent en minuscule. En voici un exemple d'utilisation&nbsp;:

```python
>>> x = 2
>>> y = 2
>>> if x == 2 and y == 2:
...     print("le test est vrai")
...
le test est vrai
```

Notez que le même résultat serait obtenu en utilisant deux instructions `if` imbriquées&nbsp;:

```python
>>> x = 2
>>> y = 2
>>> if x == 2:
...     if y == 2:
...         print("le test est vrai")
...
le test est vrai
```

Vous pouvez aussi tester directement l'effet de ces opérateurs à l'aide de `True` et `False` (attention à respecter la casse).

```python
>>> True or False
True
```

Enfin, on peut utiliser l'opérateur logique de négation `not` qui inverse le résultat d'une condition&nbsp;:

```python
>>> not True
False
>>> not False
True
>>> not (True and True)
False
```

## Instructions `break` et `continue`

Ces deux instructions permettent de modifier le comportement d'une boucle (`for` ou `while`) avec un test.

L'instruction `break` stoppe la boucle.

```python
>>> for i in range(5):
...     if i > 2:
...         break
...     print(i)
...
0
1
2
```

L'instruction `continue` saute à l'itération suivante, sans exécuter la suite du bloc d'instructions de la boucle.

```python
>>> for i in range(5):
...     if i == 2:
...         continue
...     print(i)
...
0
1
3
4
```

## Tests de valeur sur des *floats*

Lorsque l'on souhaite tester la valeur d'une variable de type *float*, le premier réflexe serait d'utiliser l'opérateur d'égalité comme&nbsp;:

```python
>>> 1/10 == 0.1
True
```

Toutefois, nous vous le déconseillons formellement. Pourquoi&nbsp;? Python stocke les valeurs numériques des *floats* sous forme de nombres flottants (d'où leur nom&nbsp;!), et cela mène à certaines [limitations](https://docs.python.org/fr/3/tutorial/floatingpoint.html). Observez l'exemple suivant&nbsp;:

```{.python .number-lines}
>>> (3 - 2.7) == 0.3
False
>>> 3 - 2.7
0.2999999999999998
```

Nous voyons que le résultat de l'opération `3 - 2.7` n'est pas exactement `0.3` d'où le `False` en ligne 2.

En fait, ce problème ne vient pas de Python, mais plutôt de la manière dont un ordinateur traite les nombres flottants (comme un rapport de nombres binaires). Ainsi certaines valeurs de *float* ne peuvent être qu'approchées. Une manière de s'en rendre compte est d'utiliser l'écriture formatée en demandant l'affichage d'un grand nombre de décimales&nbsp;:

```python
>>> 0.3
0.3
>>> "{:.5f}".format(0.3)
'0.30000'
>>> "{:.60f}".format(0.3)
'0.299999999999999988897769753748434595763683319091796875000000'
>>> "{:.60f}".format(3.0 - 2.7)
'0.299999999999999822364316059974953532218933105468750000000000'
```

On observe que lorsqu'on tape `0.3`, Python affiche une valeur arrondie. En réalité, le nombre réel `0.3` ne peut être qu'approché lorsqu'on le code en nombre flottant. Il est donc essentiel d'avoir cela en tête lorsque l'on effectue un test .

<div class="conseils">
Pour les raisons évoquées ci-dessus, il ne faut surtout pas tester si un *float* est égal à une certaine valeur. La bonne pratique est de vérifier si un *float* est compris dans un intervalle avec une certaine précision. Si on appelle cette précision *delta*, on peut procéder ainsi&nbsp;:

```python
>>> delta = 0.0001
>>> var = 3.0 - 2.7
>>> 0.3 - delta < var < 0.3 + delta
True
>>> abs(var - 0.3) < delta
True
```

Ici on teste si var est compris dans l'intervalle 0.3 ± delta. Les deux méthodes mènent à un résultat strictement équivalent&nbsp;:

- La ligne 3 est intuitive car elle ressemble à un encadrement mathématique.
- La ligne 5 utilise la fonction valeur absolue `abs()` et est plus compacte.

</div>

## Travaux pratiques

Les travaux pratiques sont disponibles [en ligne](https://colab.research.google.com/drive/1hBCYVCcNbBchddbAWVyRC38M2Pv0lVfM#forceEdit=true&sandboxMode=true).
