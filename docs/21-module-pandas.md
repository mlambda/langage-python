# Module *pandas*

Le module [*pandas*](https://pandas.pydata.org/) a été conçu pour l'analyse de données. Il est particulièrement puissant pour manipuler des données structurées sous forme de tableau.

Pour charger *pandas* dans la mémoire de Python, on utilise la commande `import` habituelle :

```python
>>> import pandas
```

Pandas est souvent chargé avec un nom raccourci, comme pour *NumPy* et *matplotlib* :

```python
>>> import pandas as pd
```


## *Series*

Le premier type de données apporté par *pandas* est la *series*, qui correspond à un vecteur à une dimension.

```python
>>> s = pd.Series([10, 20, 30, 40], index = ['a', 'b', 'c', 'd'])
>>> s
a    10
b    20
c    30
d    40
dtype: int64
```

Avec *pandas*, chaque élément de la série de données possède une étiquette qui permet d'appeler les éléments.
Ainsi, pour appeler le premier élément de la série, on peut utiliser son index,
comme pour une liste (0 pour le premier élément) ou son étiquette (ici, `"a"`) :

```python
>>> s[0]
10
>>> s["a"]
10
```

Bien sûr, on peut extraire plusieurs éléments, par leurs indices ou leurs étiquettes :

```python
>>> s[[1,3]]
b    20
d    40
dtype: int64
>>> s[["b","d"]]
b    20
d    40
dtype: int64
```

Les étiquettes permettent de modifier et d'ajouter des éléments :

```python
>>> s["c"] = 300
>>> s["z"] = 50
>>> s
a     10
b     20
c    300
d     40
z     50
dtype: int64
```

Enfin, on peut filtrer une partie de la *series* :

```python
>>> s[s>30]
c    300
d     40
z     50
dtype: int64
```

et même combiner plusieurs critères de sélection :

```python
>>> s[(s>20) & (s<100)]
d    40
z    50
dtype: int64
```

## *Dataframes*

Un autre type d'objet particulièrement intéressant introduit par *pandas*
sont les *dataframes*. Ceux-ci correspondent à des tableaux à deux dimensions
avec des étiquettes pour nommer les lignes et les colonnes.

<div class="remarque">
Si vous êtes familier avec le langage de programmation et d'analyse statistique R, les
*dataframes* de *pandas* se rapprochent de ceux trouvés dans R.
</div>

Voici comment créer un *dataframe* avec *pandas* à partir
de données fournies comme liste de lignes :

```{.python .number-lines}
>>> df = pd.DataFrame(columns=["a", "b", "c", "d"],
...                   index=["chat", "singe", "souris"],
...                   data=[np.arange(10, 14),
...                         np.arange(20, 24),
...                         np.arange(30, 34)])
>>> df
         a   b   c   d
chat    10  11  12  13
singe   20  21  22  23
souris  30  31  32  33
```

Ligne 1. Le *dataframe* est créé avec la fonction `DataFrame()` à laquelle
on fournit plusieurs arguments.
L'argument `columns` indique le nom des colonnes, sous forme d'une liste.

Ligne 2. L'argument `index` définit le nom des lignes, sous forme de liste.

Lignes 3-5. L'argument `data` fournit le contenu du *dataframe*, sous la forme
d'une liste de valeurs correspondantes à des lignes. Ainsi `np.arange(10, 14)`
 qui est équivalent à `[10, 11, 12, 13]` correspond à la première ligne du *dataframe*.

Le même *dataframe* peut aussi être créé à partir des valeurs fournies
en colonnes sous la forme d'un dictionnaire :

```{.python .number-lines}
>>> data = {"a": np.arange(10, 40, 10),
...         "b": np.arange(11, 40, 10),
...         "c": np.arange(12, 40, 10),
...         "d": np.arange(13, 40, 10)}
>>> df = pd.DataFrame.from_dict(data)
>>> df.index = ["chat", "singe", "souris"]
>>> df
         a   b   c   d
chat    10  11  12  13
singe   20  21  22  23
souris  30  31  32  33
```

Lignes 1-4. Le dictionnaire `data` contient les données en colonnes.
La clé associée à chaque colonne est le nom de la colonne.

Ligne 5. Le *dataframe* est créé avec la fonction `pd.DataFrame.from_dict()`
à laquelle on passe `data` en argument.

Ligne 6. On peut définir les étiquettes des lignes de n'importe quel *dataframe*
avec l'attribut `df.index`.

## Quelques propriétés

Les dimensions d'un *dataframe* sont données par l'attribut `.shape` :

```python
>>> df.shape
(3, 4)
```

Ici, le *dataframe* `df` a 3 lignes et 4 colonnes.

L'attribut `.columns` renvoie le nom des colonnes et permet aussi de renommer
les colonnes d'un *dataframe* :

```python
>>> df.columns
Index(['a', 'b', 'c', 'd'], dtype='object')
>>> df.columns = ["Paris", "Lyon", "Nantes", "Pau"]
>>> df
        Paris  Lyon  Nantes  Pau
chat       10    11      12   13
singe      20    21      22   23
souris     30    31      32   33
```

La méthode `.head(n)` renvoie les *n* premières lignes du *dataframe*
(par défaut, *n* vaut 5) :

```python
>>> df.head(2)
       Paris  Lyon  Nantes  Pau
chat      10    11      12   13
singe     20    21      22   23
```

## Sélection

Les mécanismes de sélection  fournis avec *pandas* sont très puissants.
En voici un rapide aperçu :

### Sélection de colonnes

On peut sélectionner une colonne par son étiquette :

```python
>>> df["Lyon"]
chat      11
singe     21
souris    31
```

ou plusieurs colonnes en même temps :

```python
>>> df[["Lyon", "Pau"]]
        Lyon  Pau
chat      11   13
singe     21   23
souris    31   33
```

Pour la sélection de plusieurs colonnes, les étiquettes d'intérêt sont rassemblées dans une liste.

### Sélection de lignes

Pour sélectionner une ligne, il faut utiliser l'instruction `.loc()`
et l'étiquette de la ligne :

```python
>>> df.loc["singe"]
Paris     20
Lyon      21
Nantes    22
Pau       23
Name: singe, dtype: int64
```

Ici aussi, on peut sélectionner plusieurs lignes :

```python
>>> df.loc[["singe", "chat"]]
       Paris  Lyon  Nantes  Pau
singe     20    21      22   23
chat      10    11      12   13
```

Enfin, on peut aussi sélectionner des lignes avec l'instruction `.iloc`
et l'indice de la ligne (la première ligne ayant l'indice 0) :

```python
>>> df.iloc[1]
Paris     20
Lyon      21
Nantes    22
Pau       23
Name: singe, dtype: int64
```

```python
>>> df.iloc[[1,0]]
       Paris  Lyon  Nantes  Pau
singe     20    21      22   23
chat      10    11      12   13
```

On peut également utiliser les tranches (comme pour les listes) :

```python
>>> df.iloc[0:2]
       Paris  Lyon  Nantes  Pau
chat      10    11      12   13
singe     20    21      22   23
```

### Sélection sur les lignes et les colonnes

On peut bien sûr combiner les deux types de sélection (en ligne et en colonne):

```python
>>> df.loc["souris", "Pau"]
33
>>> df.loc[["singe", "souris"], ['Nantes', 'Lyon']]
        Nantes  Lyon
singe       22    21
souris      32    31
```

Notez qu'à partir du moment où on souhaite effectuer une sélection sur des lignes,
il faut utiliser `loc` (ou `iloc` si on utilise les indices).

### Sélection par condition

Remémorons-nous d'abord le contenu du *dataframe* `df` :

```python
>>> df
        Paris  Lyon  Nantes  Pau
chat       10    11      12   13
singe      20    21      22   23
souris     30    31      32   33
```

Sélectionnons maintenant toutes les lignes pour lesquelles les effectifs à Pau sont supérieurs à 15 :

```python
>>> df[ df["Pau"]>15 ]
        Paris  Lyon  Nantes  Pau
singe      20    21      22   23
souris     30    31      32   33
```

De cette sélection, on ne souhaite garder que les valeurs pour Lyon :

```python
>>> df[ df["Pau"]>15 ]["Lyon"]
singe     21
souris    31
Name: Lyon, dtype: int64
```

On peut aussi combiner plusieurs conditions avec `&` pour l'opérateur **et** :

```python
>>> df[ (df["Pau"]>15) & (df["Lyon"]>25) ]
        Paris  Lyon  Nantes  Pau
souris     30    31      32   33
```

et `|` pour l'opérateur **ou** :

```python
>>> df[ (df["Pau"]>15) | (df["Lyon"]>25) ]
        Paris  Lyon  Nantes  Pau
singe      20    21      22   23
souris     30    31      32   33
```

## Combinaison de *dataframes*

En biologie, on a souvent besoin de combiner deux tableaux de chiffres à partir d'une colonne commune.

Par exemple, si on considère les deux *dataframes* suivants :

```python
>>> data1 = {"Lyon": [10, 23, 17], "Paris": [3, 15, 20]}
>>> df1 = pd.DataFrame.from_dict(data1)
>>> df1.index = ["chat", "singe", "souris"]
>>> df1
        Lyon  Paris
chat      10      3
singe     23     15
souris    17     20
```

et

```python
>>> data2 = {"Nantes": [3, 9, 14], "Strasbourg": [5, 10, 8]}
>>> df2 = pd.DataFrame.from_dict(data2)
>>> df2.index = ["chat", "souris", "lapin"]
>>> df2
        Nantes  Strasbourg
chat         3           5
souris       9          10
lapin       14           8
```

On souhaite combiner ces deux *dataframes*, c'est-à-dire connaître pour les 4 villes (Lyon, Paris, Nantes et Strasbourg) le nombre d'animaux. On remarque d'ores et déjà qu'il y a des singes à Lyon et Paris mais pas de lapin et qu'il y a des lapins à Nantes et Strasbourg mais pas de singe. Nous allons voir comment gérer cette situation.

*pandas* propose pour cela la fonction [`concat()`](https://pandas.pydata.org/pandas-docs/stable/merging.html) qui prend comme argument une liste de *dataframes* :

```python
>>> pd.concat([df1, df2])
        Lyon  Nantes  Paris  Strasbourg
chat    10.0     NaN    3.0         NaN
singe   23.0     NaN   15.0         NaN
souris  17.0     NaN   20.0         NaN
chat     NaN     3.0    NaN         5.0
souris   NaN     9.0    NaN        10.0
lapin    NaN    14.0    NaN         8.0
```

Ici, `NaN` indique des valeurs manquantes. Mais le résultat obtenu n'est pas celui que nous attendions puisque les lignes de deux *dataframes* ont été recopiées.

L'argument supplémentaire `axis=1` produit le résultat attendu :

```python
 >>> pd.concat([df1, df2], axis=1)
        Lyon  Paris  Nantes  Strasbourg
chat    10.0    3.0     3.0         5.0
lapin    NaN    NaN    14.0         8.0
singe   23.0   15.0     NaN         NaN
souris  17.0   20.0     9.0        10.0
```

Par défaut, *pandas* va conserver le plus de lignes possible. Si on ne souhaite conserver que les lignes communes aux deux *dataframes*, il faut ajouter l'argument `join="inner"` :

```python
>>> pd.concat([df1, df2], axis=1, join="inner")
        Lyon  Paris  Nantes  Strasbourg
chat      10      3       3           5
souris    17     20       9          10
```

Un autre comportement par défaut de `concat()` est que cette fonction va combiner les *dataframes* en se basant sur leurs index. Il est néanmoins possible de préciser, pour chaque *dataframe*, le nom de la colonne qui sera utilisée comme référence avec l'argument `join_axes`.

## Un exemple plus complet

Pour illustrer les possibilités de *pandas*, voici un exemple plus complet.

Le fichier `transferrin-report.csv` que vous pouvez télécharger
[ici](https://raw.githubusercontent.com/m09/langage-python/master/data/transferrin-report.csv)
contient une liste de structures de la [transferrine](https://fr.wikipedia.org/wiki/Transferrine).
Cette protéine est responsable du transport du fer dans l'organisme.

Si vous n'êtes pas familier avec le format de fichier `.csv`, nous vous conseillons
de consulter l'annexe A *Quelques formats de données rencontrés en biologie*.

Voyons maintenant comment explorer les données contenues
dans ce fichier avec *pandas*.

### Prise de contact avec le jeu de données

Une fonctionnalité très intéressante de *pandas* est d'ouvrir très facilement
un fichier au format `.csv` :

```python
>>> df = pd.read_csv("transferrin-report.csv")
```

Le contenu est chargé sous la forme d'un *dataframe* dans la variable `df`.

Le fichier contient 41 lignes de données plus une ligne d'en-tête. Cette dernière est automatiquement utilisée par *pandas* pour nommer les différentes colonnes. Voici un aperçu des premières lignes :

```python
>>> df.head()
  PDB ID              Source Deposit Date  Length       MW
0   1A8E        Homo sapiens   1998-03-24     329  36408.4
1   1A8F        Homo sapiens   1998-03-25     329  36408.4
2   1AIV       Gallus gallus   1997-04-28     686  75929.0
3   1AOV  Anas platyrhynchos   1996-12-11     686  75731.8
4   1B3E        Homo sapiens   1998-12-09     330  36505.5
```

Nous avons 5 colonnes de données :

- l'identifiant de la structure (`PDB ID`) ;
- l'organisme d'où provient cette protéine (`Source`) ;
- la date à laquelle cette structure a été déposée dans la *Protein Data Bank* (`Deposit Date`) ;
- le nombre d'acides aminés qui constituent la protéine (`Length`) ;
- et la masse molaire de la protéine (`MW`).

La colonne d'entiers tout à gauche est un index automatiquement créé par *pandas*.

Nous pouvons demander à *pandas* d'utiliser une colonne particulière comme index.
La colonne `PDB ID` s'y prête très bien car cette colonne ne contient que
des identifiants uniques :

```python
>>> df = pd.read_csv("transferrin-report.csv", index_col="PDB ID")
>>> df.head()
                    Source Deposit Date  Length       MW
PDB ID                                                  
1A8E          Homo sapiens   1998-03-24     329  36408.4
1A8F          Homo sapiens   1998-03-25     329  36408.4
1AIV         Gallus gallus   1997-04-28     686  75929.0
1AOV    Anas platyrhynchos   1996-12-11     686  75731.8
1B3E          Homo sapiens   1998-12-09     330  36505.5
```

Avant d'analyser un jeu de données, il est intéressant de l'explorer un peu. Par exemple, connaître ses dimensions :

```python
>>> df.shape
(41, 4)
```

Notre jeu de données contient donc 41 lignes et 4 colonnes. En effet, la colonne `PDB ID` est maintenant utilisée comme index et n'est donc plus prise en compte.

Il est aussi intéressant de savoir de quel type de données est constituée
chaque colonne :

```python
>>> df.dtypes
Source           object
Deposit Date     object
Length            int64
MW              float64
dtype: object
```

Les colonnes `Length` et `MW` contiennent des valeurs numériques, respectivement des entiers (`int64`) et des *floats* (`float64`). Le type `object` est un type par défaut.

La méthode `.info()` permet d'aller un peu plus loin dans l'exploration du jeu de données en combinant les informations produites par les propriétés `.shape` et `.dtypes` :

```python
>>> df.info()
<class 'pandas.core.frame.DataFrame'>
Index: 41 entries, 1A8E to 6CTC
Data columns (total 4 columns):
 #   Column        Non-Null Count  Dtype  
---  ------        --------------  -----  
 0   Source        41 non-null     object 
 1   Deposit Date  41 non-null     object 
 2   Length        41 non-null     int64  
 3   MW            41 non-null     float64
dtypes: float64(1), int64(1), object(2)
memory usage: 1.6+ KB
```

Avec l'argument `memory_usage="deep"`, cette méthode permet surtout de connaitre avec précision 
la taille de l'espace mémoire occupé par le *dataframe* :

```python
>>> df.info(memory_usage="deep")
<class 'pandas.core.frame.DataFrame'>
Index: 41 entries, 1A8E to 6CTC
Data columns (total 4 columns):
 #   Column        Non-Null Count  Dtype  
---  ------        --------------  -----  
 0   Source        41 non-null     object 
 1   Deposit Date  41 non-null     object 
 2   Length        41 non-null     int64  
 3   MW            41 non-null     float64
dtypes: float64(1), int64(1), object(2)
memory usage: 8.6 KB
```

Ici, le *dataframe* occupe 8,6 ko en mémoire.

### Conversion en date

Le type `object` correspond la plupart du temps à des chaînes de caractères.
C'est tout à fait légitime pour la colonne `Source`. Mais on sait par contre
que la colonne `Deposit Date` est une date sous la forme
*année-mois-jour*.

Si le format de date utilisé est homogène sur tout le jeu de données et non ambigu,
*pandas* va se débrouiller pour trouver automatiquement le format de date utilisé.
On peut alors explicitement demander à *pandas* de considérer la colonne
`Deposit Date` comme une date :

```python
>>> df["Deposit Date"] = pd.to_datetime(df["Deposit Date"])
```

L'affichage des données n'est pas modifié :

```python
>>> df.head()
                    Source Deposit Date  Length       MW
PDB ID                                                  
1A8E          Homo sapiens   1998-03-24     329  36408.4
1A8F          Homo sapiens   1998-03-25     329  36408.4
1AIV         Gallus gallus   1997-04-28     686  75929.0
1AOV    Anas platyrhynchos   1996-12-11     686  75731.8
1B3E          Homo sapiens   1998-12-09     330  36505.5
```

Mais le type de données de la colonne `Deposit Date` est maintenant une date (`datetime64[ns]`) :

```python
>>> df.dtypes
Source                  object
Deposit Date    datetime64[ns]
Length                   int64
MW                     float64
dtype: object
```

### Statistiques descriptives et table de comptage

Pour les colonnes qui contiennent des données numériques, on peut obtenir
rapidement quelques statistiques descriptives avec la méthode `.describe()` :

```python
>>> df.describe()
           Length            MW
count   41.000000     41.000000
mean   477.341463  52816.090244
std    175.710217  19486.594012
min    304.000000  33548.100000
25%    331.000000  36542.300000
50%    337.000000  37229.300000
75%    679.000000  75298.500000
max    696.000000  77067.900000
```

On apprend ainsi que la masse moléculaire (colonne `MW`) a une valeur moyenne de 52816.090244 avec un écart-type de 19486.594012 et que la plus petite valeur est 33548.100000 et la plus grande 77067.900000. Pratique !

La colonne `Source` contient des chaînes de caractères, on peut rapidement déterminer le nombre de protéines pour chaque organisme :

```python
>>> df["Source"].value_counts()
Homo sapiens             26
Gallus gallus            10
Anas platyrhynchos        2
Oryctolagus cuniculus     2
Sus scrofa                1
Name: Source, dtype: int64
```

Ainsi, 26 protéines sont d'origine humaine (`Homo sapiens`) et 10 proviennent de la poule (`Gallus gallus`).

### Statistiques par groupe

On peut aussi déterminer, pour chaque organisme, la taille et la masse moléculaire moyennes des transferrines :

```python
>>> df.groupby(["Source"]).mean()
                           Length            MW
Source                                         
Anas platyrhynchos     686.000000  75731.800000
Gallus gallus          509.300000  56324.080000
Homo sapiens           439.615385  48663.392308
Oryctolagus cuniculus  490.000000  54219.600000
Sus scrofa             696.000000  77067.900000
```

La méthode `.groupby()` rassemble d'abord les données suivant la colonne `Source` puis la méthode `.mean()` calcule la moyenne pour chaque groupe.

Si on souhaite obtenir deux statistiques (par exemple la valeur minimale et maximale) en une seule fois, il convient alors d'utiliser la méthode `.pivot_table()` plus complexe mais aussi beaucoup plus puissante :

```python
>>> df.pivot_table(index="Source", values=["Length", "MW"], aggfunc=[min, max])
                         min             max         
                      Length       MW Length       MW
Source                                               
Anas platyrhynchos       686  75731.8    686  75731.8
Gallus gallus            328  36105.8    686  75957.1
Homo sapiens             327  36214.2    691  76250.2
Oryctolagus cuniculus    304  33548.1    676  74891.1
Sus scrofa               696  77067.9    696  77067.9
```

L'argument `index` précise la colonne dont on agrège les données.

L'argument `values` indique sur quelles colonnes les statistiques sont calculées.

Enfin, `aggfunc` liste les statistiques calculées, ici la valeur minimale et maximale.

Notez que les valeurs renvoyées sont d'abord les valeurs minimales pour `Length` et `MW` puis les valeurs maximales pour `Length` et `MW`.

### Analyse de données numériques

On peut, sans trop de risque, émettre l'hypothèse que plus il y a d'acides aminés dans la protéine, plus sa masse moléculaire va être élevée.

Pour vérifier cela graphiquement, on représente la masse moléculaire de la protéine en fonction de sa taille (c'est-à-dire du nombre d'acides aminés).

```python
>>> import matplotlib.pyplot as plt
>>> plt.scatter(df["Length"], df["MW"])
<matplotlib.collections.PathCollection object at 0x7f62c2501780>
>>> plt.xlabel("Taille (nombre d'acides aminés)")
Text(0.5, 0, "Taille (nombre d'acides aminés)")
>>> plt.ylabel("Masse moléculaire (Dalton)")
Text(0, 0.5, 'Masse moléculaire (Dalton)')
>>> plt.savefig("transferrine1.png")
```

On obtient un graphique similaire à celui de la figure @fig:transferrine (A) avec deux groupes de points distincts (car certaines structures sont incomplètes).

![(A) Masse moléculaire en fonction de la taille. (B) Zoom.](img/transferrine.png){#fig:transferrine}

On peut zoomer sur le groupe de points le plus à gauche en ne sélectionnant que les protéines constituées de moins de 400 résidus :

```python
>>> dfz = df[df["Length"]<400]
```

Puis en créant un deuxième graphique :  

```python
>>> plt.clf()
>>> plt.scatter(dfz["Length"], dfz["MW"])
<matplotlib.collections.PathCollection object at 0x7f85bb4852e8>
>>> plt.xlabel("Taille (nombre d'acides aminés)")
Text(0.5, 0, "Taille (nombre d'acides aminés)")
>>> plt.ylabel("Masse moléculaire (Dalton)")
Text(0, 0.5, 'Masse moléculaire (Dalton)')
>>> plt.savefig("transferrine2.png")
```

Ligne 1. L'instruction `plt.clf()` efface le graphe précédent mais conserve les noms des axes des abscisses et des ordonnées.

Le graphique @fig:transferrine (B) obtenu met en évidence une relation linéaire entre le nombre de résidus d'une protéine et sa masse moléculaire.

En réalisant une régression linéaire, on détermine les paramètres de la droite qui passent le plus proche possible des points du graphique.

```python
>>> from scipy.stats import linregress
>>> lr = linregress(dfz["Length"], dfz["MW"])
>>> lr
LinregressResult(slope=116.18244897959184, intercept=-1871.6131972789153,
rvalue=0.993825553885062, pvalue=1.664932379936294e-22,
stderr=2.765423239336685)
```

Ce modèle linaire nous indique qu'un résidu a une masse d'environ 116 Dalton, ce qui est cohérent. On peut également comparer ce modèle aux différentes protéines :

```python
>>> plt.clf()
>>> plt.scatter(dfz["Length"], dfz["MW"])
<matplotlib.collections.PathCollection object at 0x7f85b97bfef0>
>>> plt.plot(dfz["Length"], dfz["Length"]*lr.slope+lr.intercept, ls=":")
[<matplotlib.lines.Line2D object at 0x7f85b933e208>]
>>> plt.xlabel("Taille (nombre d'acides aminés)")
Text(0.5, 0, "Taille (nombre d'acides aminés)")
>>> plt.ylabel("Masse moléculaire (Dalton)")
Text(0, 0.5, 'Masse moléculaire (Dalton)')
>>> plt.savefig("transferrine3.png")
```

On obtient ainsi le graphique de la +@fig:transferrine3.

![Masse moléculaire en fonction de la taille (zoom) avec un modèle linaire.](img/transferrine3.png){ #fig:transferrine3 width=70%}

### Analyse de données temporelles

Il peut être intéressant de savoir, pour chaque organisme, quand les premières et les dernières structures de transferrines ont été déposées dans la PDB.

La méthode `.pivot_table()` apporte un élément de réponse :

```python
>>> df.pivot_table(index="Source", values=["Deposit Date"], aggfunc=[min, max])
                               min          max
                      Deposit Date Deposit Date
Source                                         
Anas platyrhynchos      1995-08-03   1996-12-11
Gallus gallus           1993-09-15   2005-09-28
Homo sapiens            1992-02-10   2018-03-22
Oryctolagus cuniculus   1990-08-16   2001-07-24
Sus scrofa              2001-07-03   2001-07-03
```

Chez l'homme (`Homo sapiens`), la première structure de transferrine a été déposée dans la PDB le 10 février 1992 et la dernière le 22 mars 2018.

Une autre question est de savoir combien de structures de transferrines ont été déposées en fonction du temps.

La méthode `.value_counts()` peut être utilisée mais elle ne renvoie que le nombre de structures déposées dans la PDB pour un jour donné. Par exemple, deux structures ont été déposées le 4 septembre 2000.

```python
>>> df["Deposit Date"].value_counts().head()
1999-01-07    2
2000-09-04    2
2002-11-18    2
2003-03-10    1
2001-07-24    1
Name: Deposit Date, dtype: int64
```

Si on souhaite une réponse plus globale, par exemple, à l'échelle de l'année, la méthode `.resample()` calcule le nombre de structures déposées par année (en fournissant l'argument `A`) :

```python
>>> df["Deposit Date"].value_counts().resample("A").count()
1990-12-31    1
1991-12-31    0
1992-12-31    1
1993-12-31    1
```

Les dates apparaissent maintenant comme le dernier jour de l'année mais désignent bien l'année complète. Dans cet exemple, une seule structure de transferrine a été déposée dans la PDB entre le 1er janvier 1990 et le 31 décembre 1990.

Pour connaître en quelle année le plus de structures ont été déposées dans la PDB, il faut trier les valeurs obtenus du plus grand au plus petit avec la méthode `.sort_values()`. Comme on ne veut  connaître que les premières dates (celles où il y a eu le plus de dépôts), on utilisera également la méthode `.head()` :

```python
>>> (df["Deposit Date"].value_counts()
...                    .resample("A")
...                    .count()
...                    .sort_values(ascending=False)
...                    .head())
2001-12-31    5
2003-12-31    4
1998-12-31    3
1999-12-31    3
2002-12-31    3
Name: Deposit Date, dtype: int64
```

En 2001, cinq structures de transferrine ont été déposées dans la PDB. La deuxième « meilleure » année est 2003 avec quatre structures.

Toutes ces méthodes, enchaînées les unes à la suite des autres, peuvent vous sembler complexes mais chacune d'elles correspond à une étape particulière du traitement des données. L'utilisation des parenthèses (ligne 1, juste avant `df["Deposit Date"]` et ligne 5, juste après `head()`) permet de répartir élégamment cette longue instruction sur plusieurs lignes.

Bien sûr, on aurait pu créer des variables intermédiaires pour chaque étape mais cela aurait été plus lourd :

```python
>>> date1 = df["Deposit Date"].value_counts()
>>> date2 = date1.resample("A")
>>> date3 = date2.count()
>>> date4 = date3.sort_values(ascending=False)
>>> date4.head()
2001-12-31    5
2003-12-31    4
1998-12-31    3
1999-12-31    3
2002-12-31    3
Name: Deposit Date, dtype: int64
```

<div class="details">
- Le livre de Nicolas Rougier [*From Python to Numpy*](https://www.labri.fr/perso/nrougier/from-python-to-numpy/) est une très bonne ressource pour explorer plus en détails les possibilités de *NumPy*. L'auteur y aborde notamment la notion puissante de « masque ».
- Les ouvrages *Python for Data Analysis* de Wes McKinney et *Pandas Cookbook* de Theodore Petrou sont d'excellentes références pour *pandas*.
</div>
