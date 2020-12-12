# Module *re*{#sec:module-re}

Le module *re* permet d'utiliser des expressions régulières avec Python. Les expressions régulières sont aussi appelées en anglais *regular expressions* ou en plus court *regex*. Dans la suite de ce chapitre, nous utiliserons souvent le mot *regex* pour désigner une expression régulière. Les expressions régulières sont puissantes et incontournables en bioinformatique, spécialement lorsque vous souhaitez récupérer des informations dans de gros fichiers.

Cette action de recherche de données dans un fichier est appelée plus généralement *parsing* (qui signifie littéralement « analyse syntaxique »). Le *parsing* fait partie du travail quotidien du bioinformaticien, il est sans arrêt en train de « fouiller » dans des fichiers pour en extraire des informations d'intérêt comme par exemple récupérer les coordonnées 3D des atomes d'une protéine dans un fichier PDB ou encore extraire les gènes d'un fichier GenBank.

Dans ce chapitre, nous ne ferons que quelques rappels sur les expressions régulières. Pour une documentation plus complète, référez-vous à la [page d'aide des expressions régulières](https://docs.python.org/fr/3/library/re.html) sur le site officiel de Python.


## Définition et syntaxe

Une expression régulière est une suite de caractères qui a pour but de décrire un fragment de texte. Cette suite de caractères est encore appelée **motif** (en anglais *pattern*), motif qui est constitué de deux types de caractères:

- Les caractères dits *normaux*.
- Les *métacaractères* ayant une signification particulière, par exemple le caractère `^` signifie début de ligne et non pas le caractère « chapeau » littéral.

Avant de présenter les *regex* en Python, nous allons faire un petit détour par Unix. En effet, certains programmes comme `egrep`, `sed` ou encore `awk` savent interpréter les expressions régulières. Tous ces programmes fonctionnent généralement selon le schéma suivant :

- Le programme lit un fichier ligne par ligne.
- Pour chaque ligne lue, si l'expression régulière passée en argument est retrouvée dans la ligne, alors le programme effectue une action.

Par exemple, pour le programme `egrep` :

```
$ egrep "^DEF" herp_virus.gbk
DEFINITION  Human herpesvirus 2, complete genome.
```

Ici, `egrep` affiche toutes les lignes du fichier du virus de l'herpès (`herp_virus.gbk`) dans lesquelles la *regex* `^DEF` (c'est-à-dire le mot `DEF` en début de ligne) est retrouvée.

<div class="remarque">

Il est intéressant de faire une point sur le vocabulaire utilisé en anglais et en français. En général, on utilise le verbe *to match* pour indiquer qu'une *regex* « a fonctionné ». Bien qu'il n'y ait pas de traduction littérale en français, on peut utiliser les verbes « retrouver » ou « correspondre ». Par exemple, on pourra traduire l'expression « *The regex matches the line* » par « La *regex* est retrouvée dans la ligne » ou encore « La *regex* correspond dans la ligne ».

</div>

Après avoir introduit le vocabulaire des *regex*, voici quelques éléments de syntaxe des métacaractères :


`^`

:   Début de chaîne de caractères ou de ligne.

    Exemple : la *regex* `^ATG` est retrouvée dans la chaîne de caractères `ATGCGT` mais pas dans la chaîne `CCATGTT`.

`$`

:   Fin de chaîne de caractères ou de ligne.

    Exemple : la *regex* `ATG$` est retrouvée dans la chaîne de caractères `TGCATG` mais pas dans la chaîne `CCATGTT`.

`.`

:   N'importe quel caractère (mais un caractère quand même).

    Exemple : la *regex* `A.G` est retrouvée dans `ATG`, `AtG`, `A4G`, mais aussi dans `A-G` ou dans `A G`.


`[ABC]`

:   Le caractère A ou B ou C (un seul caractère).

    Exemple : la *regex* `T[ABC]G` est retrouvée dans `TAG`, `TBG` ou `TCG`, mais pas dans `TG`.

`[A-Z]`

:   N'importe quelle lettre majuscule.

    Exemple : la *regex* `C[A-Z]T` est retrouvée dans `CAT`, `CBT`, `CCT`...

`[a-z]`

:   N'importe quelle lettre minuscule.

`[0-9]`

:   N'importe quel chiffre.

`[A-Za-z0-9]`

:   N'importe quel caractère alphanumérique.

`[^AB]`

:   N'importe quel caractère sauf A et B.

    Exemple : la *regex* `CG[^AB]T` est retrouvée dans `CG9T`, `CGCT`... mais pas dans `CGAT` ni dans `CGBT`.

`\`

:   Caractère d'échappement (pour protéger certains caractères).

    Exemple : la *regex* `\+` désigne le caractère `+` littéral. La *regex* `A\.G` est retrouvée dans `A.G` et non pas dans `A` suivi de n'importe quel caractère, suivi de `G`.

`*`

:   0 à *n* fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(CG)*T` est retrouvée dans `AT`, `ACGT`, `ACGCGT`...

`+`

:   1 à *n* fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(CG)+T` est retrouvée dans `ACGT`, `ACGCGT`... mais pas dans `AT`.

`?`

:   0 à 1 fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(CG)?T` est retrouvée dans `AT` ou `ACGT`.

`{n}`

:   *n* fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(CG){2}T` est retrouvée dans `ACGCGT` mais pas dans `ACGT`, `ACGCGCGT` ou `ACGCG`.

`{n,m}`

:   *n* à *m* fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(C){2,4}T` est retrouvée dans `ACCT`, `ACCCT` et `ACCCCT` mais pas dans `ACT`, `ACCCCCT` ou `ACCC`.

`{n,}`

:   Au moins *n* fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(C){2,}T` est retrouvée dans `ACCT`, `ACCCT` et `ACCCCT` mais pas à `ACT` ou `ACCC`.

`{,m}`

:   Au plus *m* fois le caractère précédent ou l'expression entre parenthèses précédente.

    Exemple : la *regex* `A(C){,2}T` est retrouvée dans `AT`, `ACT` et `ACCT` mais pas dans `ACCCT` ou `ACC`.

`(CG|TT)`

:   Les chaînes de caractères `CG` ou `TT`.

    Exemple : la *regex* `A(CG|TT)C` est retrouvée dans `ACGC` ou `ATTC`.

Enfin, il existe des caractères spéciaux qui sont bien commodes et qui peuvent être utilisés en tant que métacaractères :

`\d`

: remplace n'importe quel chiffre (*d* signifie *digit*), équivalent à `[0-9]`.

`\w`

: remplace n'importe quel caractère alphanumérique et le caractère souligné (*underscore*) (*w* signifie *word character*), équivalent à `[0-9A-Za-z_]`.

`\s`

: remplace n'importe quel « espace blanc » (*whitespace*) (*s* signifie *space*), équivalent à `[ \t\n\r\f]`. La notion d'espace blanc a été abordée dans le +@sec:plus-sur-les-chaines-de-caracteres. Les espaces blancs les plus classiques sont l'espace, la tabulation `\t`, le retour à la ligne `\n`, mais il en existe d'autres comme `\r` et `\f` que nous ne développerons pas ici. `\s` est très pratique pour détecter une combinaison d'espace(s) et/ou de tabulation(s).

Comme vous le constatez, les métacaractères sont nombreux et leur signification est parfois difficile à maîtriser. Faites particulièrement attention aux métacaractères `.`, `+` et `*` qui, combinés ensemble, peuvent donner des résultats ambigus.

Il est important de savoir par ailleurs que les *regex* sont « avides » (*greedy* en anglais) lorsqu'on utilise les métacaractères `+` et `*`. C'est-à-dire que la *regex* cherchera à « s'étendre » au maximum. Par exemple, si on utilise la *regex* `A+` pour faire une recherche dans la chaîne `TTTAAAAAAAAGC`, tous les A de cette chaîne (8 en tout) seront concernés, bien que `AA`, `AAA`, etc. « fonctionnent » également avec cette *regex*.

## Quelques ressources en ligne

Nous vous conseillons de tester systématiquement vos expressions régulières sur des exemples simples. Pour vous aider, nous vous recommandons plusieurs sites internet :

- [https://regexone.com/](https://regexone.com/) : tutoriel en ligne très bien fait.
- [https://regexr.com/](https://regexr.com/) : visualise tous les endroits où une *regex* est retrouvée dans un texte.
- [https://www.regular-expressions.info](https://www.regular-expressions.info) : documentation exhaustive sur les *regex* (il y a même une section sur Python).
- [https://pythex.org/](https://pythex.org/) : interface simple et efficace, dédiée à Python.

N'hésitez pas à tester ces sites avant de vous lancer dans les exercices ou dans l'écriture de vos propres *regex* !


## Le module *re*

### La fonction `search()`

Dans le module *re*, la fonction `search()` est incontournable. Elle permet de rechercher un motif, c'est-à-dire une *regex*, au sein d'une chaîne de caractères avec une syntaxe de la forme `search(motif, chaine)`. Si `motif` est retrouvé dans `chaine`, Python renvoie un objet du type `SRE_Match`.

Sans entrer dans les détails propres au langage orienté objet, si on utilise un objet du type `SRE_Match` dans un test, il sera considéré comme vrai. Regardez cet exemple dans lequel on va rechercher le motif `tigre` dans la chaîne de caractères `"girafe tigre singe"` :

```
>>> import re
>>> animaux = "girafe tigre singe"
>>> re.search("tigre", animaux)
<_sre.SRE_Match object at 0x7fefdaefe2a0>
>>> if re.search("tigre", animaux):
...     print("OK")
...
OK
```

<div class="attention">

Le motif que vous utilisez comme premier argument de la fonction `search()` sera interprété en tant que *regex*. Ainsi, `^DEF` correspondra au mot `DEF` en début de chaîne et pas au caractère littéral `^`suivi du mot `DEF`.

</div>


### Les fonctions `match()` et `fullmatch()`

Il existe aussi la fonction `match()` dans le module `re` qui fonctionne sur le modèle de `search()`. La différence est qu'elle renvoie un objet du type `SRE_Match` seulement lorsque la *regex* correspond au début de la chaîne de caractères (à partir du premier caractère).

```
>>> animaux = "girafe tigre singe"
>>> re.search("tigre", animaux)
<_sre.SRE_Match object at 0x7fefdaefe718>
>>> re.match('tigre', animaux)
>>>
>>> animaux = "tigre singe"
>>> re.match("tigre", animaux)
<_sre.SRE_Match object; span=(0, 5), match='tigre'>
>>>
```

Il existe également la fonction `fullmatch()` qui renvoie un objet du type `SRE_Match` si et seulement si l'expression régulière correspond **exactement** à la chaîne de caractères.

```
>>> animaux = "tigre "
>>> re.fullmatch('tigre', animaux)
>>> animaux = "tigre"
>>> re.fullmatch('tigre', animaux)
<_sre.SRE_Match object; span=(0, 5), match='tigre'>
```

De manière générale, nous vous recommandons l'usage de la fonction `search()`. Si vous souhaitez avoir une correspondance avec le début de la chaîne de caractères comme dans la fonction `match()`, vous pouvez toujours utiliser l'accroche de début de ligne `^`. Si vous voulez une correspondance exacte comme dans la fonction `fullmatch()`, vous pouvez utiliser les métacaractères `^` et `$`, par exemple `^tigre$`.


### Compilation d'expressions régulières

Lorsqu'on a besoin de tester la même expression régulière sur plusieurs milliers de chaînes de caractères, il est pratique de compiler préalablement la *regex* à l'aide de la fonction `compile()` qui renvoie un objet de type `SRE_Pattern` :

```
>>> regex = re.compile("^tigre")
>>> regex
<_sre.SRE_Pattern object at 0x7fefdafd0df0>
```

On peut alors utiliser directement cet objet avec la méthode `.search()` :

```
>>> animaux = "girafe tigre singe"
>>> regex.search(animaux)
>>> animaux = "tigre singe"
>>> regex.search(animaux)
<_sre.SRE_Match object at 0x7fefdaefe718>
>>> animaux = "singe tigre"
>>> regex.search(animaux)
```


### Groupes

L'intérêt de l'objet de type `SRE_Match` renvoyé par Python lorsqu'une *regex* trouve une correspondance dans une chaîne de caractères est de pouvoir ensuite récupérer certaines zones précises :

```
>>> regex = re.compile("([0-9]+)\.([0-9]+)")
```

Dans cet exemple, on recherche un nombre décimal, c'est-à-dire une chaîne de caractères :

- qui débute par un ou plusieurs chiffres `[0-9]+`,
- suivi d'un point `\.` (le point a d'habitude une signification de métacaractère, donc il faut l'échapper avec `\` pour qu'il retrouve sa signification de point),
- et qui se termine encore par un ou plusieurs chiffres `[0-9]+`.

Les parenthèses dans la *regex* créent des groupes (`[0-9]+` deux fois) qui seront récupérés ultérieurement par la méthode `.group()`.

```
>>> resultat = regex.search("pi vaut 3.14")
>>> resultat.group(0)
'3.14'
>>> resultat.group(1)
'3'
>>> resultat.group(2)
'14'
>>> resultat.start()
8
>>> resultat.end()
12
```

La totalité de la correspondance est donnée par `.group(0)`, le premier élément entre parenthèses est donné par `.group(1)` et le second par `.group(2)`.

Les méthodes `.start()` et `.end()` donnent respectivement la position de début et de fin de la zone qui correspond à la *regex*. Notez que la méthode `.search()` ne renvoie que la première zone qui correspond à l'expression régulière, même s'il en existe plusieurs :

```
>>> resultat = regex.search("pi vaut 3.14 et e vaut 2.72")
>>> resultat.group(0)
'3.14'
```


### La méthode `.findall()`

Pour récupérer chaque zone, s'il y en a plusieurs, vous pouvez utiliser la méthode `.findall()` qui renvoie une liste des éléments en correspondance.

```
>>> regex = re.compile("[0-9]+\.[0-9]+")
>>> resultat = regex.findall("pi vaut 3.14 et e vaut 2.72")
>>> resultat
['3.14', '2.72']
```

L'utilisation des groupes entre parenthèses est également possible et ceux-ci sont alors renvoyés sous la forme de tuples.

```
>>> regex = re.compile("([0-9]+)\.([0-9]+)")
>>> resultat = regex.findall("pi vaut 3.14 et e vaut 2.72")
>>> resultat
[('3', '14'), ('2', '72')]
```


### La méthode `.sub()`

Enfin, la méthode `.sub()` permet d'effectuer des remplacements assez puissants. Par défaut la méthode `.sub(chaine1, chaine2)` remplace toutes les occurrences trouvées par l'expression régulière dans `chaine2` par `chaine1`. Si vous souhaitez ne remplacer que les *n* premières occurrences, utilisez l'argument `count=n` :

```
>>> regex = re.compile("[0-9]+\.[0-9]+")
>>> regex.sub("quelque chose","pi vaut 3.14 et e vaut 2.72")
'pi vaut quelque chose et e vaut quelque chose'
>>> regex.sub("quelque chose","pi vaut 3.14 et e vaut 2.72", count=1)
'pi vaut quelque chose et e vaut 2.72'
```

Encore plus puissant, il est possible d'utiliser dans le remplacement des groupes qui ont été « capturés » avec des parenthèses.

```
>>> regex = re.compile("([0-9]+)\.([0-9]+)")
>>> phrase = "pi vaut 3.14 et e vaut 2.72"
>>> regex.sub("approximativement \\1", phrase)
'pi vaut approximativement 3 et e vaut vaut approximativement 2'
>>> regex.sub("approximativement \\1 (puis .\\2)",phrase)
'pi vaut approximativement 3 (puis .14) et e vaut approximativement 2 (puis .72)'
```

Si vous avez capturé des groupes, il suffit d'utiliser `\\1`, `\\2` (etc.) pour utiliser les groupes correspondants dans la chaîne de caractères substituée. On notera que la syntaxe générale pour récupérer des groupes dans les outils qui gèrent les *regex* est `\1`, `\2`, etc. Toutefois, Python nous oblige à mettre un deuxième *backslash* car il y a ici deux niveaux : un premier niveau Python où on veut mettre un *backslash* littéral (donc `\\`), puis un second niveau *regex* dans lequel on veut retrouver `\1`. Si cela est confus, retenez seulement qu'il faut mettre un `\\` devant le numéro de groupe.

Enfin, sachez que la réutilisation d'un groupe précédemment capturé est aussi utilisable lors d'une utilisation classique de *regex*. Par exemple :

```
>>> re.search("(pan)\\1", "bambi et panpan")
<_sre.SRE_Match object; span=(9, 15), match='panpan'>
>>> re.search("(pan)\\1", "le pistolet a fait pan !")
>>>
```

Dans la *regex* `(pan)\\1`, on capture d'abord le groupe `(pan)` grâce aux parenthèses (il s'agit du groupe 1 puisque c'est le premier jeu de parenthèses), immédiatement suivi du même groupe grâce au `\\1`. Dans cet exemple, on capture donc le mot `panpan` (lignes 1 et 2). Si, par contre, on a une seule occurrence du mot `pan`, cette *regex* ne fonctionne pas, ce qui est le cas ligne 3.

Bien sûr, si on avait eu un deuxième groupe, on aurait pu le réutiliser avec `\\2`, un troisième groupe avec `\\3`, etc.


Nous espérons vous avoir convaincu de la puissance du module *re* et des expressions régulières. Alors, plus de temps à perdre, à vos *regex* !


## Exercices

*Conseil* : pour ces exercices, créez des scripts puis exécutez-les dans un *shell*.


### Nettoyeur d'espaces

Le fichier [`cigale-fourmi.txt`](https://raw.githubusercontent.com/m09/langage-python/master/data/cigale-fourmi.txt) contient le célèbre poème de Jean de la Fontaine. Malheureusement, la personne qui l'a recopié a parfois mis plusieurs espaces au lieu d'un seul entre les mots.

Créez un script `cigale_fourmi.py` qui grâce à une *regex* et à la fonction `sub()` remplace plusieurs espaces par un seul espace dans le texte ci-dessus. Le nouveau texte « propre » sera enregistré dans un fichier `cigale-fourmi-propre.txt`.


### Le défi du dé-htmliseur (exercice +++)

Le format HTML permet d'afficher des pages web dans un navigateur. Il s'agit d'un langage à balise qui fonctionne avec des balises ouvrantes `<balise>` et des balises fermantes `</balise>`.

Créez un script `dehtmliseur.py` qui lit le fichier [`fichier-a-dehtmliser.html`](https://raw.githubusercontent.com/m09/langage-python/master/data/fichier-a-dehtmliser.html) au format HTML et qui renvoie à l'écran tout le texte de ce fichier sans les balises HTML.

Nous vous conseillons tout d'abord d'ouvrir le fichier HTML dans un éditeur de texte et de bien l'observer. N'hésitez pas à vous aider des sites mentionnés dans les ressources en ligne


### Nettoyeur de doublons (exercice +++)

Téléchargez le fichier [`breves-doublons.txt`](https://raw.githubusercontent.com/m09/langage-python/master/data/breves_doublons.txt) qui contient des mots répétés deux fois. Par exemple :

```default
Le cinéma est devenu parlant, la radio radio finira en images.
La sardine, c'est un petit petit poisson sans tête qui vit dans l'huile.
[...]
```

Écrivez un script `ote_doublons.py` qui lit le fichier `breves-doublons.txt` et qui supprime tous les doublons à l'aide d'une *regex*. Le script affichera le nouveau texte à l'écran.

*Conseil* : utilisez la méthode `.sub()`.
