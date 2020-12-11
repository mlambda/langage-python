# Module *matplotlib*

Le module [*matplotlib*](https://matplotlib.org/) permet de générer des graphiques depuis Python. Il est l'outil complémentaire de *NumPy*, *scipy* ou *pandas* (que l'on verra juste après) lorsqu'on veut faire de l'analyse de données.

## Représentation sous forme de points

Dans cet exemple, nous considérons l'évolution de la concentration d'un produit dans le sang (exprimé en mg/L) en fonction du temps (exprimé en heure).

Nous avons les résultats suivants :

| Temps (h) | Concentration (mg/L) |
|:---------:|:--------------------:|
|     1     |          3.5         |
|     2     |          5.8         |
|     3     |          9.1         |
|     4     |         11.8         |
|     6     |         17.5         |
|     7     |         21.3         |
|     9     |         26.8         |

Nous allons maintenant représenter l'évolution de la concentration en fonction du temps :

```{.python .number-lines}
import matplotlib.pyplot as plt


temps = [1, 2, 3, 4, 6, 7, 9]
concentration = [5.5, 7.2, 11.8, 13.6, 19.1, 21.7, 29.4]
plt.scatter(temps, concentration, marker="o", color="blue")
plt.xlabel("Temps (h)")
plt.ylabel("Concentration (mg/L)")
plt.title("Concentration de produit en fonction du temps")
plt.show()
```

Vous devriez obtenir une fenêtre graphique **interactive** qui vous permet de manipuler le graphe (se déplacer, zoomer, enregistrer comme image, etc.) et qui ressemble à celle de la +@fig:concentration-vs-temps-show.

![Fenêtre interactive de *matplotlib*.](img/concentration-vs-temps-show.png "Fenêtre interactive de matplotlib"){#fig:concentration-vs-temps-show width=70%}

Revenons maintenant sur le code.

Ligne 1. Tout d'abord, on importe le sous-module `pyplot` du module *matplotlib* et on lui donne l'alias `plt` pour l'utiliser plus rapidement ensuite (cet alias est standard, utilisez-la systématiquement).

Lignes 3 et 4. On définit les variables `temps` et `concentration` comme des listes. Les deux listes doivent avoir la même longueur (7 éléments dans le cas présent).

Ligne 5. La fonction `scatter()` permet de représenter des points sous forme de nuage de points. Les deux premiers arguments correspondent aux valeurs en abscisse et en ordonnée des points, fournis sous forme de listes. Des arguments facultatifs sont ensuite précisés comme le symbole (`marker`) et la couleur (`color`).

Lignes 6 et 7. Les fonctions `xlabel()` et `ylabel()` sont utilisées pour donner un nom aux axes.

Ligne 8. La fonction `title()` définit le titre du graphique.

Ligne 9. Enfin, la fonction `show()` affiche le graphique généré à l'écran.

## Représentation sous forme de courbe

On sait par ailleurs que l'évolution de la concentration du produit en fonction du temps peut-être modélisée par la fonction $f(x) = 2 + 3 \times x$. Représentons ce modèle avec les points expérimentaux et sauvegardons le graphique obtenu sous forme d'une image :

```{.python .number-lines}
import matplotlib.pyplot as plt
import numpy as np


temps = [1, 2, 3, 4, 6, 7, 9]
concentration = [5.5, 7.2, 11.8, 13.6, 19.1, 21.7, 29.4]
plt.scatter(temps, concentration, marker='o', color = 'blue')
plt.xlabel("Temps (h)")
plt.ylabel("Concentration (mg/L)")
plt.title("Concentration de produit en fonction du temps")
x = np.linspace(min(temps), max(temps), 50)
y = 2 + 3 * x
plt.plot(x, y, color='green', ls="--")
plt.grid()
plt.savefig('concentration-vs-temps.png', bbox_inches='tight', dpi=200)
```

Le résultat est représenté sur la figure @fig:concentration-vs-temps.

![Concentration du produit en fonction du temps.](img/concentration-vs-temps.png "Concentration du produit en fonction du temps"){  #fig:concentration-vs-temps width=70% }

Les étapes supplémentaires par rapport au graphique précédent (figure @fig:concentration-vs-temps-show) sont :

Ligne 1. On charge le module *numpy* sous le nom `np`.

Ligne 10. On crée la variable `x` avec la fonction `linspace()` du module *NumPy* qui renvoie une liste de valeurs régulièrement espacées entre deux bornes, ici entre le minimum (`min(temps)`) et le maximum (`max(temps)`) de la variable `temps`. Dans notre exemple, nous générons une liste de 50 valeurs. La variable `x` ainsi créée est du type *array*.

Ligne 11. On construit ensuite la variable `y` à partir de la formule modélisant l'évolution de la concentration en fonction du temps. Cette manipulation n'est possible que parce que `x` est du type *array*. Cela ne fonctionnerait pas avec une liste classique.

Ligne 12. La fonction `plot()` permet de construire une courbe à partir des coordonnées en abscisse et en ordonnées des points à représenter. On indique ensuite des arguments facultatifs comme le style de la ligne (`ls`) et sa couleur (`color`).

Ligne 13. La fonction `grid()` affiche une grille.

Ligne 14. Enfin, la fonction `savefig()` enregistre le graphique produit sous la forme d'une image au format png. Des arguments par mot-clé définissent la manière de générer les marges autour du graphique (`bbox_inches`) et la résolution de l'image (`dpi`).

## Représentation sous forme de diagramme en bâtons

On souhaite maintenant représenter graphiquement la distribution des différentes bases dans une séquence d'ADN.

```{.python .number-lines}
import numpy as np
import matplotlib.pyplot as plt

sequence = "ACGATCATAGCGAGCTACGTAGAA"
bases = ["A", "C", "G", "T"]
distribution = []
for base in bases:
    distribution.append(sequence.count(base))

x = np.arange(len(bases))
plt.bar(x, distribution)
plt.xticks(x, bases)
plt.xlabel("Bases")
plt.ylabel("Nombre")
plt.title("Distribution des bases\n dans la séquence {}".format(sequence))
plt.savefig('distribution-bases.png', bbox_inches="tight", dpi=200)
```

On obtient alors le graphique de la figure @fig:distribution-bases.

![Distribution des bases.](img/distribution-bases.png "Distribution des bases"){#fig:distribution-bases width=70%}

Prenons le temps d'examiner les différentes étapes du script précédent :

Lignes 4 à 6. On définit les variables `sequence`, `bases` et `distribution` qu'on utilise ensuite.

Lignes 7 et 8. On calcule la distribution des différentes bases dans la séquence. On utilise pour cela la méthode `count()` qui renvoie le nombre de fois qu'une chaîne de caractères (les différentes bases) se trouve dans une autre (la séquence).

Ligne 10. On définit la position en abscisse des barres. Dans cet exemple, la variable `x` vaut `array([0, 1, 2, 3])`.

Ligne 11. La fonction `bar()` construit le diagramme en bâtons. Elle prend en argument la position des barres (`x`) et leurs hauteurs (`distribution`).

Ligne 12. La fonction `xtics()` redéfinit les étiquettes (c'est-à-dire le nom des bases) sur l'axe des abscisses.

Lignes 13 à 15. On définit les légendes des axes et le titre du graphique. On insère un retour à la ligne `\n` dans le titre pour qu'il soit réparti sur deux lignes.

Ligne 16. Enfin, on enregistre le graphique généré au format png.

On espère que ces courts exemples vous auront convaincu de l'utilité du module *matplotlib*. Sachez qu'il peut faire bien plus, par exemple générer des histogrammes ou toutes sortes de graphiques utiles en analyse de données. Le site de *matplotlib* fournit de nombreux [exemples détaillés](https://matplotlib.org/gallery/index.html), n'hésitez pas à le consulter.
