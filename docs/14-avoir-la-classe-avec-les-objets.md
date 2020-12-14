# Avoir la classe avec les objets

La programmation orientée objet (POO) est un concept de programmation très puissant qui permet de structurer ses programmes d'une manière nouvelle. En POO, on définit un « objet » qui peut contenir des « attributs » ainsi que des « méthodes » qui agissent sur lui-même. Par exemple, on définit un objet « citron » qui contient les attributs « saveur » et « couleur », ainsi qu'une méthode « presser » permettant d'en extraire le jus. En Python, on utilise une « classe » pour construire un objet. Dans notre exemple, la classe correspondrait au « moule » utilisé pour construire autant d'objets citrons que nécessaire.

<div class="definition">

Une **classe** définit des **objets** qui sont des **instances** (des représentants) de cette classe. Dans ce chapitre on utilisera les mots *objet* ou *instance* pour désigner la même chose. Les objets peuvent posséder des **attributs** (variables associées aux objets) et des **méthodes** (qui sont des fonctions associées aux objets et qui peuvent agir sur ces derniers ou encore les utiliser).

</div>

Dans les chapitres précédents, nous avons déjà mentionné qu'en Python tout est objet. Une variable de type *int* est en fait un objet de type *int*, donc construit à partir de la classe *int*. Pareil pour les *float* et *string*. Mais également pour les *list*, *tuple*, *dict*, etc. Voilà pourquoi nous avons rencontré de nombreuses notations et mots de vocabulaire associés à la POO depuis le début de ce cours.

La POO permet de rédiger du code plus compact et mieux ré-utilisable. L'utilisation de classes évite l'utilisation de variables globales en créant ce qu'on appelle un *espace de noms* propre à chaque objet permettant d'y *encapsuler* des attributs et des méthodes. De plus, la POO amène de nouveaux concepts tels que le *polymorphisme* (capacité à redéfinir le comportement des opérateurs, nous avons déjà vu ces mots vous en souvenez-vous ?), ou bien encore l'*héritage* (capacité à définir une classe à partir d'une classe pré-existante et d'y ajouter de nouvelles fonctionnalités). Tous ces concepts seront définis dans ce chapitre.

Malgré tous ces avantages, la POO peut paraître difficile à aborder pour le débutant, spécialement dans la conception des programmes / algorithmes. Elle nécessite donc la lecture de nombreux exemples, mais surtout beaucoup de pratique. Bien structurer ses programmes en POO est un véritable art. Il existe même des langages qui formalisent la construction de programmes orientés objets, par exemple le langage [UML](https://fr.wikipedia.org/wiki/UML_(informatique)).

Dans ce chapitre nous allons vous présenter une introduction à la POO avec Python. Nous vous donnerons tous les éléments pour démarrer la construction de vos premières classes.

Après la lecture de ce chapitre, vous verrez d'un autre œil de nombreux exemples évoqués dans les chapitres précédents, et vous comprendrez sans doute de nombreuses subtilités qui avaient pu vous paraître absconses.

## Construction d'une classe

Nous allons voir dans cette rubrique comment définir une classe en reprenant notre exemple sur le citron que nous allons faire évoluer et complexifier. Attention, certains exemples sont destinés à vous montrer comment les classes fonctionnent mais leur utilisation n'aurait pas de sens dans un vrai programme. Ainsi, nous vous donnerons plus loin dans ce chapitre les pratiques recommandées.

### La classe minimale

En Python, le mot-clé `class` permet de créer sa propre classe, suivi du nom de cette classe. On se souvient, un nom de classe commence toujours par une majuscule (voir le +@sec:bonnes-pratiques-en-programmation-python). Comme d'habitude, cette ligne attend un bloc d'instructions indenté définissant le corps de la classe. Voyons un exemple simple dans l'interpréteur :

```{.python .number-lines}
>>> class Citron:
...     pass
...
>>> Citron
<class '__main__.Citron'>
>>> type(Citron)
<class 'type'>
>>> citron1 = Citron()
>>> citron1
<__main__.Citron object at 0x7ff2193a20f0>
>>>
```

Ligne 1. La classe `Citron` est définie. Pas besoin de parenthèses comme avec les fonctions dans un cas simple comme celui-là (nous verrons d'autres exemples plus loin où elles sont nécessaires).

Ligne 2. La classe ne contient rien, mais il faut mettre au moins une ligne, on met donc ici le mot-clé Python `pass` qui ne fait rien (comme dans une fonction qui ne fait rien).

Lignes 4 et 5. Quand on tape le nom de notre classe `Citron`, Python nous indique que cette classe est connue.

Lignes 6 et 7. Lorsqu'on regarde le type de notre classe `Citron`, Python nous indique qu'il s'agit d'un type au même titre que `type(int)`. Nous avons donc créé un nouveau type !

Ligne 8. On crée une instance de la classe `Citron`, c'est-à-dire qu'on fabrique un représentant ou objet de la classe `Citron` que nous nommons `citron1`.

Lignes 9 et 10. Lorsqu'on tape le nom de l'instance `citron1`, l'interpréteur nous rappelle qu'il s'agit d'un objet de type `Citron` ainsi que son adresse en mémoire.

Il est également possible de vérifier qu'une instance est bien issue d'une classe donnée avec la fonction `isinstance()` :

```python
>>> isinstance(citron1, Citron)
True
```

### Ajout d'un attribut d'instance

Reprenons notre classe `Citron` et l'instance `citron1` créée précédemment. Regardons les attributs et méthodes que cet objet possède, puis tentons de lui ajouter un attribut  :

```{.python .number-lines}
>>> dir(citron1)
['__class__', '__delattr__', '__dict__', [...], '__weakref__']
>>> citron1.couleur = "jaune"
>>> dir(citron1)
['__class__', '__delattr__', '__dict__', [...], '__weakref__', 'couleur']
>>> citron1.couleur
'jaune'
```

Lignes 1 et 2. L'objet possède de nombreuses méthodes ou attributs qui commencent et qui se terminent par deux caractères *underscores*. On se souvient que les *underscores* indiquent qu'il s'agit de méthodes ou attributs destinés au fonctionnement interne de l'objet. Nous reviendrons sur certains d'entre-eux dans la suite.

Ligne 3. Ici on ajoute un attribut `.couleur` à l'instance `citron1`. Notez bien la syntaxe `instance.attribut` et le point qui lie les deux.

Lignes 4 à 5. La fonction `dir()` nous montre que l'attribut `.couleur` a bien été ajouté à l'objet.

Lignes 6. La notation `instance.attribut` donne accès à l'attribut de l'objet.

L'attribut nommé `.__dict__` est particulièrement intéressant. Il s'agit d'un dictionnaire qui listera les attributs créés dynamiquement dans l'instance en cours :

```python
>>> citron1 = Citron()
>>> citron1.__dict__
{}
>>> citron1.couleur = "jaune"
>>> citron1.__dict__
{'couleur': 'jaune'}
```

L'ajout d'un attribut depuis l'extérieur de la classe (on parle aussi du côté « client ») avec une syntaxe `instance.nouvel_attribut = valeur`, créera ce nouvel attribut uniquement pour cette instance :

```python
citron1 = Citron()
citron1.couleur = "jaune"
>>> citron1.__dict__
{'couleur': 'jaune'}
>>> citron2 = Citron()
>>> citron2.__dict__
{}
```

Si on crée une nouvelle instance de `Citron`, ici `citron2`, elle n'aura pas l'attribut  
`couleur` à sa création.

<div class="definition">
Une **variable ou attribut d'instance** est une variable accrochée à une instance et qui est spécifique à cette instance. Cet attribut n'existe donc pas forcément pour toutes les instances d'une classe donnée, et d'une instance à l'autre il ne prendra pas forcément la même valeur. On peut retrouver tous les attributs d'instance d'une instance donnée avec une syntaxe `instance.__dict__`.
</div>

L'instruction `del` fonctionne bien sûr pour détruire un objet (par exemple  
`del citron1`), mais permet également de détruire un attribut d'instance. Si on reprend notre exemple `citron1` ci-dessus :

```python
>>> citron1.__dict__
{'couleur': 'jaune'}
>>> del citron1.couleur
>>> citron1.__dict__
{}
```

Dans la suite on montrera du code à tester dans un script, n'hésitez pas comme d'habitude à le tester vous-même.

### Les attributs de classe

Si on ajoute une variable dans une classe comme on créait une variable locale dans une fonction, on crée ce qu'on appelle un attribut de classe :

```python
class Citron:
    couleur = "jaune"
```

<div class="definition">
Une **variable de classe** ou **attribut de classe** est un attribut qui sera identique pour chaque instance. On verra plus bas que de tels attributs suivent des règles différentes par rapport aux attributs d'instance.
</div>

À l'extérieur ou à l’intérieur d'une classe, un attribut de classe peut se retrouver avec une syntaxe `NomClasse.attribut` :

```python
print(Citron.couleur)
```

Ce code affiche `jaune`. L'attribut de classe est aussi visible depuis n'importe quelle instance :

```python
class Citron:
    couleur = "jaune"


if __name__ == "__main__":
    citron1 = Citron()
    print(citron1.couleur)
    citron2 = Citron()
    print(citron2.couleur)
```

L'exécution de ce code affichera :

```python
jaune
jaune
```

<div class="attention">
Même si on peut retrouver un attribut de classe avec une syntaxe `instance.attribut`, un tel attribut ne peut pas être modifié avec une syntaxe  
`instance.attribut = nouvelle_valeur` (voir la rubrique *Différence entre les attributs de classe et d'instance*).
</div>

### Les méthodes

Dans notre classe on pourra aussi ajouter des fonctions.

<div class="definition">
Une fonction définie au sein d'une classe est appelée **méthode**. Pour exécuter une méthode à l'extérieur de la classe, la syntaxe générale est `instance.méthode()`. En général, on distingue attributs et méthodes (comme nous le ferons systématiquement dans ce chapitre). Toutefois il faut garder à l'esprit qu'une méthode est finalement un objet de type fonction. Ainsi, elle peut être vue comme un attribut également, concept que vous croiserez peut-être en consultant de la documentation externe.
</div>

Voici un exemple d'ajout d'une fonction, ou plus exactement d'une méthode, au sein d'une classe (attention à l'indentation !) :

```python
class Citron:
    def coucou(self):
        print("Coucou, je suis la mth .coucou() dans la classe Citron !")


if __name__ == "__main__":
    citron1 = Citron()
    citron1.coucou()
```

Lignes 2 et 3. On définit une méthode nommée `.coucou()` qui va afficher un petit message. Attention, cette méthode prend obligatoirement un argument que nous avons nommé ici `self`. Nous verrons dans les deux prochaines rubriques la signification de ce `self`. Si on a plusieurs méthodes dans une classe, on saute toujours une ligne entre elles afin de faciliter la lecture (comme pour les fonctions).

Ligne 7 et 8. On crée l'instance `citron1` de la classe `Citron`, puis on exécute la méthode `.coucou()` avec une syntaxe `instance.méthode()`.

Une méthode étant une fonction, elle peut bien sûr retourner une valeur :

```python
class Citron:
    def recup_saveur(self):
        return "acide"


if __name__ == "__main__":
    citron1 = Citron()
    saveur_citron1 = citron1.recup_saveur()
    print(saveur_citron1)
```

Vous l'aurez deviné, ce code affichera `acide` à l'écran. Comme pour les fonctions, une valeur retournée par une méthode est récupérable dans une variable, ici `saveur_citron1`.

### Le constructeur

Lors de l'instanciation d'un objet à partir d'une classe, il peut être intéressant de lancer des instructions comme par exemple initialiser certaines variables. Pour cela, on ajoute une méthode spéciale nommée `.__init__()` : cette méthode s'appelle le « constructeur » de la classe. Il s'agit d'une méthode spéciale dont le nom est entouré de doubles *underscores* : en effet, elle sert au fonctionnement interne de notre classe, et sauf cas extrêmement rare, elle n'est pas supposée être lancée comme une fonction classique par l'utilisateur de la classe. Ce constructeur est exécuté à chaque instanciation de notre classe, et ne renvoie pas de valeur, il ne possède donc pas de `return`.

<div class="remarque">
Pour les débutants, vous pouvez sauter cette remarque. Certains auteurs préfèrent nommer `.__init__()` « instantiateur » ou « initialisateur », pour signifier qu'il existe une autre méthode appelée `.__new__()` qui participe à la création d'une instance. Vous n'avez bien sûr pas à retenir ces détails pour continuer la lecture de ce chapitre, retenez simplement que nous avons décidé de nommer la méthode `.__init__()` « constructeur » dans cet ouvrage.
</div>

Pour bien comprendre comment cela fonctionne, nous allons suivre un exemple simple avec le site [*Python Tutor*](http://www.pythontutor.com) (déjà utilisé dans les chapitres @sec:fonctions et @sec:plus-sur-les-fonctions sur les fonctions). N'hésitez pas à copier/coller ce code dans *Python Tutor* pour le tester vous-même :

```python
class Citron:
    def __init__(self):
        self.couleur = "jaune"


if __name__ == "__main__":
    citron1 = Citron()
    print(citron1.couleur)
```

Étape 1 (voir +@fig:classe-constructeur1). Au départ, *Python Tutor* nous montre que la classe `Citron` a été mise en mémoire, elle contient pour l'instant la méthode `.__init__()`.

![Fonctionnement d'un constructeur (étape 1).](img/classe-constructeur1.png){ #fig:classe-constructeur1 width=90% }

Étape 2 (voir +@fig:classe-constructeur2). Nous créons ensuite l'instance `citron1` à partir de la classe `Citron`. Notre classe `Citron` contenant une méthode `.__init__()` (le constructeur), celle-ci est immédiatement exécutée au moment de l'instanciation. Cette méthode prend un argument nommé `self` : cet argument est **obligatoire**. Il s'agit en fait d'une référence vers l'instance en cours (instance que nous appellerons `citron1` de retour dans le programme principal, mais cela serait vrai pour n'importe quel autre nom d'instance). *Python Tutor* nous indique cela par une flèche pointant vers un espace nommé `Citron instance`. La signification du `self` est expliquée en détail dans la rubrique suivante.

![Fonctionnement d'un constructeur (étape 2).](img/classe-constructeur2.png){ #fig:classe-constructeur2 width=90% }

Étape 3 (voir @fig:classe-constructeur3). Un nouvel attribut est créé s’appelant `self.couleur`. La chaîne de caractères `couleur` est ainsi « accrochée » (grâce au caractère point) à l'instance en cours référencée par le `self`. *Python Tutor* nous montre cela par une flèche qui pointe depuis le `self` vers la variable `couleur` (qui se trouve elle-même dans l'espace nommé `Citron instance`). Si d'autres attributs étaient créés, ils seraient tous répertoriés dans cet espace `Citron instance`. Vous l'aurez compris, l'attribut `couleur` est donc une variable d'instance (voir rubrique *Ajout d'un attribut d'instance* ci-dessus). La méthode `.__init__()` étant intrinsèquement une fonction, *Python Tutor* nous rappelle qu'elle ne renvoie rien (d'où le `None` dans la case *Return value*) une fois son exécution terminée. Et comme avec les fonctions classiques, l'espace mémoire contenant les variables locales à cette méthode va être détruit une fois son exécution terminée.

![Fonctionnement d'un constructeur (étape 3).](img/classe-constructeur3.png){ #fig:classe-constructeur3 width=90% }

Étape 4 (voir figure @fig:classe-constructeur4). De retour dans le programme principal, *Python Tutor* nous indique que `citron1` est une instance de la classe `Citron` par une flèche pointant vers l'espace `Citron instance`. Cette instance contient un attribut nommé `couleur` auquel on accéde avec la syntaxe `citron1.couleur` dans le `print()`. Notez que si l'instance s'était appelée `enorme_citron`, on aurait utilisé `enorme_citron.couleur` pour accéder à l'attribut `couleur`.

![Fonctionnement d'un constructeur (étape 4).](img/classe-constructeur4.png){ #fig:classe-constructeur4 width=90% }

<div class="conseils">
Dans la mesure du possible, nous vous conseillons de créer tous les attributs d'instance dont vous aurez besoin dans le constructeur `.__init__()` plutôt que dans toute autre méthode. Ainsi ils seront visibles dans toute la classe dès l'instanciation.
</div>

### Passage d'argument(s) à l'instanciation

Lors de l'instanciation, il est possible de passer des arguments au constructeur. Comme pour les fonctions, on peut passer des arguments positionnels ou par mot-clé et en créer autant que l'on veut (voir +@sec:fonctions). Voici un exemple :

```python
class Citron:
    def __init__(self, masse, couleur="jaune"):
        self.masse = masse
        self.couleur = couleur


if __name__ == "__main__":
    citron1 = Citron(100)
    print("citron1:", citron1.__dict__)
    citron2 = Citron(150, couleur="blanc")
    print("citron2:", citron2.__dict__)
```

On a ici un argument positionnel (`masse`) et un autre par mot-clé (`couleur`). Le code donnera la sortie suivante :

```default
citron1: {'masse': 100, 'couleur': 'jaune'}
citron2: {'masse': 150, 'couleur': 'blanc'}
```

### Mieux comprendre le rôle du `self`

Cette rubrique va nous aider à mieux comprendre le rôle du `self` à travers quelques exemples simples. Regardons le code suivant dans lequel nous créons une nouvelle méthode `.affiche_attributs()`:

```{.python .number-lines}
class Citron:
    def __init__(self, couleur="jaune"):
        self.couleur = couleur
        var = 2

    def affiche_attributs(self):
        print(self)
        print(self.couleur)
        print(var)


if __name__ == "__main__":
    citron1 = Citron()
    citron1.affiche_attributs()
```

Ligne 3. On crée l'attribut `couleur` que l'on accroche à l'instance avec le `self`.

Ligne 4. Nous créons cette fois-ci une variable `var` sans l'accrocher au `self`.

Ligne 6. Nous créons une nouvelle méthode dans la classe `Citron` qui se nomme  
`.affiche_attributs()`. Comme pour le constructeur, cette méthode prend comme premier argument une variable obligatoire, que nous avons à nouveau nommée `self`. Il s'agit encore une fois d'une référence vers l'objet ou instance créé(e). On va voir plus bas ce qu'elle contient exactement.

<div class="attention">
On peut appeler cette référence comme on veut, toutefois nous vous conseillons vivement de l'appeler `self` car c'est une convention générale en Python. Ainsi, quelqu'un qui lira votre code comprendra immédiatement de quoi il s'agit.
</div>

Ligne 7. Cette ligne va afficher le contenu de la variable `self`.

Lignes 8 et 9. On souhaite que notre méthode `.affiche_attributs()` affiche ensuite l'attribut de classe `.couleur` ainsi que la variable `var` créée dans le constructeur `.__init__()`.

L'exécution de ce code donnera :

```{.default .number-lines}
$ python classe_exemple1.py
<__main__.Citron object at 0x7f4e5fb71438>
jaune
Traceback (most recent call last):
  File "classe_exemple1.py", line 14, in <module>
    citron1.affiche_attributs()
  File "classe_exemple1.py", line 9, in affiche_attributs
    print(var)
NameError: name 'var' is not defined
```

Ligne 2. La méthode `.affiche_attributs()` montre que le `self` est bien une référence vers l'instance (ou objet) `citron1` (ou vers n'importe quelle autre instance, par exemple si on crée `citron2 = Citron()` le `self` sera une référence vers `citron2`).

Ligne 3. La méthode `.affiche_attributs()` affiche l'attribut `.couleur` qui avait été créé précédemment dans le constructeur. Vous voyez ici l'intérêt principal de l'argument `self` passé en premier à chaque méthode d'une classe : il « accroche » n'importe quel attribut qui sera visible partout dans la classe, y compris dans une méthode où il n'a pas été défini.

Lignes 4 à 9. La création de la variable `var` dans la méthode `.__init__()` sans l'accrocher à l'objet `self` fait qu'elle n'est plus accessible en dehors de `.__init__()`. C'est exactement comme pour les fonctions classiques, `var` est finalement une variable locale au sein de la méthode `.__init__()` et n'est plus visible lorsque l'exécution de cette dernière est terminée (cf. chapitres @sec:fonctions et @sec:plus-sur-les-fonctions sur les fonctions). Ainsi, Python renvoie une erreur car `var` n'existe pas lorsque `.affiche_attributs()` est en exécution.

En résumé, le `self` est nécessaire lorsqu'on a besoin d'accéder à différents attributs dans les différentes méthodes d'une classe. Le `self` est également nécessaire pour appeler une méthode de la classe depuis une autre méthode :

```python
class Citron:
    def __init__(self, couleur="jaune"):
        self.couleur = couleur
        self.affiche_message()

    def affiche_message(self):
        print("Le citron c'est trop bon !")


if __name__ == "__main__":
    citron1 = Citron("jaune pâle")
```

Ligne 4. Nous appelons ici la méthode `.affiche_message()` depuis le constructeur. Pour appeler cette méthode interne à la classe `Citron`, on doit utiliser une syntaxe `self.méthode()`. Le `self` sert donc pour accéder aux attributs mais aussi aux méthodes, ou plus généralement à tout ce qui est accroché à la classe.

Lignes 6 et 7. La méthode `.affiche_message()` est exécutée. On peut se poser la question *Pourquoi passer l'argument self à cette méthode alors qu'on ne s'en sert pas dans celle-ci ?*

<div class="attention">
Même si on ne se sert d'aucun attribut dans une méthode, l'argument `self` (ou quel que soit son nom) est **strictement obligatoire**. En fait, la notation `citron1.affiche_message()` est équivalente à `Citron.affiche_message(citron1)`.
Testez les deux pour voir ! Dans cette dernière instruction, on appelle la méthode accrochée à la classe `Citron` et on lui passe explicitement l'instance `citron1` en tant qu'argument. La notation `citron1.affiche_message()` contient donc en filigrane un argument, à savoir, la référence vers l'instance `citron1` que l'on appelle `self` au sein de la méthode.
</div>

*Conseil :* c'est la première notation `citron1.affiche_attributs()` (ou plus généralement `instance.méthode()`), plus compacte, qui sera toujours utilisée.

Ligne 11. On crée l'instance `citron1` en lui passant l'argument `"jaune pâle"`. La variable d'instance `couleur` prendra ainsi cette valeur au lieu de celle par défaut (`"jaune"`). À noter, l'instanciation affichera le message `Le citron c'est trop bon !` puisque la méthode `.affiche_attributs()` est appelée dans le constructeur `.__init__()`.

Afin de bien comprendre les différentes étapes des codes de cette rubrique, nous vous conseillons de les retester de votre côté dans *Python Tutor*.

### Différence entre les attributs de classe et d'instance

On a vu ci-dessus comment créer un attribut de classe, il suffit de créer une variable au sein de la classe (en dehors de toute méthode). En général, les attributs de classe contiennent des propriétés générales à la classe puisqu'ils vont  prendre la même valeur quelle que soit l'instance.

Au contraire, les attributs d'instance sont spécifiques à chaque instance. Pour en créer, on a vu qu'il suffisait de les initialiser dans la méthode `.__init__()` en utilisant une syntaxe `self.nouvel_attribut = valeur`. On a vu aussi dans la rubrique *Ajout d'un attribut d'instance* que l'on pouvait ajouter un attribut d'instance de l'extérieur avec une syntaxe `instance.nouvel_attribut = valeur` .

Bien que les deux types d'attributs soient fondamentalement différents au niveau de leur finalité, il existe des similitudes lorsqu'on veut accéder à leur valeur. Le code suivant illustre cela :

```{.python .number-lines}
class Citron:
    forme = "ellipsoïde" # attribut de classe
    saveur = "acide" # attribut de classe

    def __init__(self, couleur="jaune", taille="standard", masse=0):
        self.couleur = couleur # attribut d'instance
        self.taille = taille # attribut d'instance
        self.masse = masse # attribut d'instance (masse en gramme)

    def augmente_masse(self, valeur):
        self.masse += valeur


if __name__ == "__main__":
    citron1 = Citron()
    print("Attributs de classe :", citron1.forme, citron1.saveur)
    print("Attributs d'instance :", citron1.taille, citron1.couleur,
          citron1.masse)
    citron1.augmente_masse(100)
    print("Attributs d'instance :", citron1.taille, citron1.couleur,
          citron1.masse)
```

Lignes 2 et 3. Nous créons deux variables de classe qui seront communes à toutes les instances (disons qu'un citron sera toujours ellipsoïde et acide !).

Lignes 6 à 8. Nous créons trois variables d'instance qui seront spécifiques à chaque instance (disons que la taille, la couleur et la masse d'un citron peuvent varier !), avec des valeurs par défaut.

Lignes 10 et 11. On crée une nouvelle méthode `.augmente_masse()` qui augmente l'attribut d'instance `.masse`.

Ligne 14 à 21. Dans le programme principal, on instancie la classe `Citron` sans passer d'argument (les valeurs par défaut `"jaune"`, `"standard"` et `0` seront donc prises), puis on imprime les attributs.

La figure @fig:classe-var-instance montre l'état des variables après avoir exécuté ce code grâce au site [*Python Tutor*](http://www.pythontutor.com).

![Illustration de la signification des attributs de classe et d'instance avec *Python Tutor*.](img/classe-var-instance.png){#fig:classe-var-instance width=90%}

*Python Tutor* montre bien la différence entre les variables de classe `forme` et `saveur` qui apparaissent directement dans les attributs de la classe `Citron` lors de sa définition et les trois variables d'instance `couleur`, `taille` et `masse` qui sont liées à l'instance `citron1`. Pour autant, on voit dans la dernière instruction `print()` qu'on peut accéder de la même manière aux variables de classe ou d'instance, lorsqu'on est à l'extérieur, avec une syntaxe `instance.attribut`.

Au sein des méthodes, on accède également de la même manière aux attributs de classe ou d'instance, avec une syntaxe `self.attribut` :

```python
class Citron:
    saveur = "acide" # attribut de classe

    def __init__(self, couleur="jaune"):
        self.couleur = couleur # attribut d'instance

    def affiche_attributs(self):
        print("attribut de classe: {}, attribut d'instance: {}"
              .format(self.saveur, self.couleur))


if __name__ == "__main__":
    citron1 = Citron()
    citron1.affiche_attributs()
```

Ce code va afficher la phrase :

```default
attribut de classe: acide, attribut d'instance: jaune
```

En résumé, qu'on ait des attributs de classe ou d'instance, on peut accéder à eux de l'extérieur par `instance.attribut` et de l'intérieur par `self.attribut`.

Qu'en est-il de la manière de modifier ces deux types d'attributs ? Les attributs d'instance peuvent se modifier sans problème de l'extérieur avec une syntaxe `instance.attribut_d_instance = nouvelle_valeur` et de l'intérieur avec une syntaxe `self.attribut_d_instance = nouvelle_valeur`. Ce n'est pas du tout le cas avec les attributs de classe.

<div class="attention">
Les attributs de classe ne peuvent pas être modifiés ni à l'extérieur d'une classe via une syntaxe `instance.attribut_de_classe = nouvelle_valeur`, ni à l'intérieur d'une classe via une syntaxe `self.attribut_de_classe = nouvelle_valeur`. Puisqu'ils sont destinés à être identiques pour toutes les instances, cela est logique de ne pas pouvoir les modifier via une instance. Les attributs de classe Python ressemblent en quelque sorte aux attributs statiques du C++.
</div>

Regardons l'exemple suivant illustrant cela :

```{.python .number-lines}
class Citron:
    saveur = "acide"

if __name__ == "__main__":
    citron1 = Citron()
    print(citron1.saveur)
    citron1.saveur = "sucrée"
    print(citron1.saveur) # on regarde ici avec Python Tutor
    del citron1.saveur
    print(citron1.saveur) # on regarde ici avec Python Tutor
    del citron1.saveur
```

À la ligne 7, on pourrait penser qu'on modifie l'attribut de classe `saveur` avec une syntaxe `instance.attribut_de_classe = nouvelle_valeur`. Que se passe-t-il exactement ? La +@fig:classe-var-instance3 nous montre l'état des variables grâce au site *Python Tutor*. Celui-ci indique que la ligne 7 a en fait créé un nouvel attribut d'instance `citron1.saveur` (contenant la valeur `sucrée`) qui est bien distinct de l'attribut de classe auquel on accédait avant par le même nom ! Tout ceci est dû à la manière dont Python gère les **espaces de noms** (voir rubrique *Espaces de noms*). Dans ce cas, l'attribut d'instance est **prioritaire** sur l'attribut de classe.

![Illustration avec *Python Tutor* de la non destruction d'un attribut de classe (étape 1).](img/classe-var-instance2.png){#fig:classe-var-instance2 width=90%}

À la ligne 9, on détruit finalement l'attribut d'instance `citron1.saveur` qui contenait la valeur `sucrée`. *Python Tutor* nous montre que `citron1.saveur` n'existe pas dans l'espace `Citron instance` qui est vide ; ainsi, Python utilisera l'attribut de classe `.saveur` qui contient toujours la valeur `acide` (cf. +@fig:classe-var-instance3).

![Illustration avec *Python Tutor* de la non destruction d'un attribut de classe (étape 2).](img/classe-var-instance3.png){ #fig:classe-var-instance3 width=90% }

La ligne 11 va tenter de détruire l'attribut de classe `.saveur`. Toutefois, Python interdit cela, ainsi l'erreur suivante sera générée :

```python
Traceback (most recent call last):
  File "./test.py", line 10, in <module>
    del(citron1.saveur)
AttributeError: saveur
```

En fait, la seule manière de modifier un attribut de classe est d'utiliser une syntaxe  
`NomClasse.attribut_de_classe = nouvelle_valeur`,  
dans l'exemple ci-dessus cela aurait été `Citron.saveur = "sucrée"`. De même, pour sa destruction, il faudra utiliser la même syntaxe : `del Citron.saveur`.

<div class="conseils">
Même si on peut modifier un attribut de classe, nous vous déconseillons de le faire. Une utilité des attributs de classe est par exemple de définir des constantes (mathématique ou autre), donc cela n'a pas de sens de vouloir les modifier ! Il est également déconseillé de créer des attributs de classe avec des objets modifiables comme des listes et des dictionnaires, cela peut avoir des effets désastreux non désirés. Nous verrons plus bas un exemple concret d'attribut de classe qui est très utile, à savoir le concept d'objet de type *property*.

Si vous souhaitez avoir des attributs modifiables dans votre classe, créez plutôt des attributs d'instance dans le `.__init__()`.
</div>

## Espace de noms

Nous faisons ici une petite digression sur le concept d'**espace de noms**, car il est important de bien le comprendre lorsqu'on étudie les classes. Nous avons déjà croisé ce concept dans le +@sec:plus-sur-les-fonctions, et nous le recroiserons dans le +@sec:creation-de-modules. De quoi s'agit-il ?

<div class="definition">
Dans la [documentation officielle](https://docs.python.org/fr/3/tutorial/classes.html#python-scopes-and-namespaces), un espace de noms est défini comme suit : « *a namespace is a mapping from names to objects* ». Un espace de noms, c'est finalement une correspondance entre des noms et des objets. Un espace de noms peut être vu aussi comme une capsule dans laquelle on trouve des noms d'objets. Par exemple, le programme principal ou une fonction représentent chacun un espace de noms, un module aussi, et bien sûr une classe ou l'instance d'une classe également.
</div>

Différents espaces de noms peuvent contenir des objets de même nom sans que cela ne pose de problème. Parce qu'ils sont chacun dans un espace différent, ils peuvent cohabiter sans risque d'écrasement de l'un par l'autre. Par exemple, à chaque fois que l'on appelle une fonction, un espace de noms est créé pour cette fonction. *Python Tutor* nous montre cet espace sous la forme d'une zone dédiée (voir les chapitres @sec:fonctions et @sec:plus-sur-les-fonctions). Si cette fonction appelle une autre fonction, un nouvel espace est créé, bien distinct de la fonction appelante (ce nouvel espace peut donc contenir un objet de même nom). En définitive, ce qui va compter, c'est de savoir quelles règles Python va utiliser pour chercher dans les différents espaces de noms pour finalement accéder à un objet.

Nous allons dans cette rubrique refaire le point sur ce que l'on a appris dans cet ouvrage sur les espaces de noms en Python, puis se pencher sur les spécificités de ce concept dans les classes.

### Rappel sur la règle LGI

Comme vu dans le +@sec:fonctions, la règle LGI peut être résumée ainsi : *Local > Global > Interne*. Lorsque Python rencontre un objet, il utilise cette règle de priorité pour accéder à la valeur de celui-ci. Si on est dans une fonction (ou une méthode), Python va d'abord chercher l'espace de noms *local* à cette fonction. S'il ne trouve pas de nom il va ensuite chercher l'espace de noms du programme principal (ou celui du module), donc des variables *globales* s'y trouvant. S'il ne trouve pas de nom, il va chercher dans les commandes *internes* à Python (on parle des [*Built-in Functions*](https://docs.python.org/fr/3/library/functions.html) comme par exemple `print()`) et des [*Built-in Constants*](https://docs.python.org/fr/3/library/constants.html)). Si aucun objet n'est trouvé, Python renvoie une erreur.

### Gestion des noms dans les modules

Les modules représentent aussi un espace de noms en soi. Afin d'illustrer cela, jetons un coup d’œil à ce programme `test-var-module.py` :

```{.python .number-lines}
import mod

i = 1000000
j = 2

print("Dans prog principal i:", i)
print("Dans prog principal j:", j)

mod.fct()
mod.fct2()

print("Dans prog principal i:", i)
print("Dans prog principal j:", j)
```

Le module `mod.py` contient les instructions suivantes :

```.python
def fct():
    i = -27478524
    print("Dans module, i local:", i)


def fct2():
    print("Dans module, j global:", j)


i = 3.14
j = -76
```

L'exécution de `test_var_module.py` donnera :

```.default
$ python ./test_var_module.py
Dans prog principal i: 1000000
Dans prog principal j: 2
Dans module, i local: -27478524
Dans module, j global: -76
Dans prog principal i: 1000000
Dans prog principal j: 2
```

Lignes 3 et 4. On a bien les valeurs de `i` et `j` définies dans le programme principal de `test.py`.

Lignes 9 et 10. Lorsqu'on exécute `mod.fct()`, la valeur de `i` sera celle définie localement dans cette fonction. Lorsqu'on exécute `mod.fct2()`, la valeur de `j` sera celle définie de manière globale dans le module.

Lignes 12 et 13. De retour dans notre programme principal, les variables `i` et `j` existent toujours et n'ont pas été modifiées par l'exécution de fonctions du module `mod.py`.

En résumé, lorsqu'on lance une méthode d'un module, c'est l'espace de noms de celui-ci qui est utilisé. Bien sûr, toutes les variables du programme principal / fonction / méthode appelant ce module sont conservées telles quelles, et on les retrouve intactes lorsque l'exécution de la fonction du module est terminée. Un module a donc son propre espace de noms qui est bien distinct de tout programme principal / fonction / méthode appelant un composant de ce module. Enfin, les variables globales créées dans notre programme principal ne sont pas accessibles dans le module lorsque celui-ci est en exécution.

### Gestion des noms avec les classes

On vient de voir qu'un module avait son propre espace de noms, mais qu'en est-il des classes ? En utilisant les exemples vus depuis le début de ce chapitre, vous avez certainement la réponse. Une classe possède par définition son propre espace de noms qui ne peut être en aucun cas confondu avec celui d'une fonction ou d'un programme principal. Reprenons un exemple simple :

```python
class Citron:
    def __init__(self, saveur="acide", couleur="jaune"):
        self.saveur = saveur
        self.couleur = couleur
        print("Dans __init__(), vous venez de créer un citron:",
              self.affiche_attributs())

    def affiche_attributs(self):
        return "{}, {}".format(self.saveur, self.couleur)


if __name__ == "__main__":
    saveur = "sucrée"
    couleur = "orange"
    print("Dans prog principal: {}, {}".format(saveur, couleur))
    citron1 = Citron("très acide", "jaune foncé")
    print("Dans citron1.affiche_attributs():", citron1.affiche_attributs())
    print("Dans prog principal: {}, {}".format(saveur, couleur))
```

Lorsqu'on exécutera ce code, on obtiendra :

```default
Dans prog principal: sucrée, orange
Dans __init__(), vous venez de créer un citron: jaune foncé, très acide
Dans citron1.affiche_attributs(): jaune foncé, très acide
Dans prog principal: sucrée, orange
```

Les deux variables globales `saveur` et `couleur` du programme principal ne peuvent pas être confondues avec les variables d'instance portant le même nom. Au sein de la classe, on utilisera pour récupérer ces dernières `self.saveur` et `self.couleur`. À l'extérieur, on utilisera `instance.saveur` et `instance.couleur`. Il n'y a donc aucun risque de confusion possible avec les variables globales `saveur` et `couleur`, on accède à chaque variable de la classe avec un nom distinct (qu'on soit à l'intérieur ou à l'extérieur de la classe).

Ceci est également vrai pour les méthodes. Si par exemple, on a une méthode avec un certain nom, et une fonction du module principal avec le même nom, regardons ce qui se passe :

```python
class Citron:
    def __init__(self):
        self.couleur = "jaune"
        self.affiche_coucou()
        affiche_coucou()

    def affiche_coucou(self):
        print("Coucou interne !")


def affiche_coucou():
    print("Coucou externe")


if __name__ == "__main__":
    citron1 = Citron()
    citron1.affiche_coucou()
    affiche_coucou()
```

Lorsqu'on va exécuter le code, on obtiendra :

```default
Coucou interne !
Coucou externe
Coucou interne !
Coucou externe
```

À nouveau, il n'y a pas de conflit possible pour l'utilisation d'une méthode ou d'une fonction avec le même nom. À l'intérieur de la classe on utilise `self.affiche_coucou()` pour la méthode et `affiche_coucou()` pour la fonction. À l'extérieur de la classe, on utilise `instance.affiche_coucou()` pour la méthode et `affiche_coucou()` pour la fonction.

Dans cette rubrique, nous venons de voir une propriété des classes extrêmement puissante : **une classe crée automatiquement son propre espace de noms**. Cela permet d'encapsuler à l'intérieur tous les attributs et méthodes dont on a besoin, sans avoir aucun risque de conflit de nom avec l'extérieur (variables locales, globales ou provenant de modules). L'utilisation de classes évitera ainsi l'utilisation de variables globales qui, on l'a vu aux chapitres @sec:fonctions et @sec:plus-sur-les-fonctions sur les fonctions, sont à proscrire absolument. Tout cela concourt à rendre le code plus lisible.

### Gestion des noms entre les attributs de classe et d'instance

Si vous lisez cette rubrique sur l'espace de noms sans avoir lu ce chapitre depuis le début, nous vous conseillons vivement de lire attentivement la rubrique *Différence entre les attributs de classe et d'instance*. La chose importante à retenir sur cette question est la suivante : si un attribut de classe et un attribut d'instance ont le même nom, c'est l'attribut d'instance qui est **prioritaire**.

<div class="details">
Il existe d'autres règles concernant les espace de noms. L'une d'elle, que vous pourriez rencontrer, concerne la gestion des noms avec des fonctions imbriquées. Et oui, Python autorise cela ! Par exemple :

```python
def fonction1():
    [...]

    def fct_dans_fonction1():
        [...]
```

Là encore, il existe certaines règles de priorités d'accès aux objets spécifiques à ce genre de cas, avec l'apparition d'un nouveau mot-clé nommé `nonlocal`. Toutefois ces aspects vont au-delà du présent ouvrage. Pour plus d'informations sur les fonctions imbriquées et la directive `nonlocal`, vous pouvez consulter la [documentation officielle](https://docs.python.org/fr/3/tutorial/classes.html#python-scopes-and-namespaces).

D'autres subtilités concerneront la gestion des noms en cas de définition d'une nouvelle classe héritant d'une classe mère. Ces aspects sont présentés dans la rubrique *Héritage* de ce chapitre.
</div>

## Polymorphisme

Nous allons voir maintenant des propriétés très importantes des classes en Python, le polymorphisme dans cette rubrique et l'héritage dans la suivante. Ces deux concepts donnent un surplus de puissance à la POO par rapport à la programmation classique.

Commençons par le polymorphisme. Dans la vie, celui-ci évoque la capacité à prendre plusieurs apparences, qu'en est-il en programmation ?

<div class="definition">
En programmation, le polymorphisme est la capacité d'une fonction (ou méthode) à se comporter différemment en fonction de l'objet qui lui est passé. Une fonction donnée peut donc avoir plusieurs définitions.
</div>

Prenons un exemple concret de polymorphisme : la fonction Python `sorted()` va trier par ordre ASCII si l'argument est une chaîne de caractères, et elle va trier par ordre croissant lorsque l'argument est une liste d'entiers :

```python
>>> sorted("citron")
['c', 'i', 'n', 'o', 'r', 't']
>>> sorted([1, -67, 42, 0, 81])
[-67, 0, 1, 42, 81]
```

Le polymorphisme est intimement lié au concept de *redéfinition des opérateurs* que nous avons déjà croisé à plusieurs reprises dans ce livre.

<div class="definition">
La redéfinition des opérateurs est la capacité à redéfinir le comportement d'un opérateur en fonction des opérandes utilisées (on rappelle dans l'expression `1 + 1`, `+` est l'opérateur d'addition et les deux `1` sont les opérandes).
</div>

Un exemple classique de redéfinition des opérateurs concerne l'opérateur `+`. Si les opérandes sont de type numérique, il fait une addition, si elles sont des chaînes de caractère il fait une concaténation :

```python
>>> 2 + 2
4
>>> "ti" + "ti"
'titi'
```

Nous verrons dans la rubrique suivante sur *l'héritage* qu'il est également possible de redéfinir des méthodes d'une classe, c'est-à-dire leur donner une nouvelle définition.

Comment Python permet-il ces prouesses que sont le polymorphisme et la redéfinition des opérateurs ? Et bien, il utilise des méthodes dites *magiques*.

<div class="definition">
Une méthode magique (*magic method*) est une méthode spéciale dont le nom est entouré de double *underscores*. Par exemple, la méthode `.__init__()` est une méthode magique. Ces méthodes sont, la plupart du temps, destinées au fonctionnement interne de la classe. Nombre d'entre elles sont destinées à changer le comportement de fonctions ou opérateurs internes à Python avec les instances d'une classe que l'on a créée.
</div>

Nous allons prendre un exemple concret. Imaginons que suite à la création d'une classe, nous souhaitions que Python affiche un message personnalisé lors de l'utilisation de la fonction `print()` avec une instance de cette classe. La méthode magique qui permettra cela est nommée `.__str__()` : elle redéfinit le comportement d'une instance avec la fonction `print()`.

```{.python .number-lines}
class CitronBasique:
    def __init__(self, couleur="jaune", taille="standard"):
        self.couleur = "jaune"
        self.taille = "standard"


class CitronCool:
    def __init__(self, couleur="jaune", taille="standard"):
        self.couleur = couleur
        self.taille = taille

    def __str__(self):
        return ("Votre citron est de couleur {} et de taille {} 8-)"
               .format(self.couleur, self.taille))


if __name__ == "__main__":
    citron1 = CitronBasique()
    print(citron1)
    citron2 = CitronCool("jaune foncée", "minuscule")
    print(citron2)
```

Lignes 1 à 4. Création d'une classe `CitronBasique` dans laquelle il n'y a qu'un constructeur.

Lignes 7 à 14. Création d'une classe `CitronCool` où nous avons ajouté la nouvelle méthode `.__str__()`. Cette dernière renvoie une chaîne de caractères contenant la description de l'instance.

Lignes 18 à 21. On crée une instance de chaque classe, et on utilise la fonction `print()` pour voir leur contenu.

L'exécution de ce code affichera la sortie suivante :

```default
<__main__.CitronBasique object at 0x7ffe23e717b8>
Votre citron est de couleur jaune foncée et de taille minuscule 8-)
```

L'utilisation de la fonction `print()` sur l'instance `citron1` construite à partir de la classe `CitronBasique` affiche le message abscons que nous avons déjà croisé. Par contre, pour l'instance `citron2` de la classe `CitronCool`, le texte correspond à celui retourné par la méthode magique `.__str__()`. Nous avons donc redéfini comment la fonction `print()` se comportait avec une instance de la classe `CitronCool`. Notez que `str(citron2)` donnerait le même message que `print(citron2)`.

Ce mécanisme pourra être reproduit avec de très nombreux opérateurs et fonctions de bases de Python. En effet, il existe une multitude de méthodes magiques, en voici quelques unes :

- `.__repr__()` : redéfinit le message obtenu lorsqu'on tape le nom de l'instance dans l'interpréteur ;
- `.__add__()` : redéfinit le comportement de l'opérateur `+` ;
- `.__mul__()` : redéfinit le comportement de l'opérateur `*` ;
- `.__del__()` : redéfinit le comportement de la fonction `del`.

Si on conçoit une classe produisant des objets séquentiels (comme des listes ou des *tuples*), il existe des méthodes magiques telles que :

- `.__len__()` : redéfinit le comportement de la fonction `len()` ;
- `.__getitem__()` : redéfinit le comportement pour récupérer un élément ;
- `.__getslice__()` : redéfinit le comportement avec les tranches.

Certaines méthodes magiques font des choses assez impressionnantes. Par exemple, la méthode `.__call__()` crée des instances que l'on peut appeler comme des fonctions ! Dans cet exemple, nous allons vous montrer que l'on peut ainsi créer un moyen inattendu pour mettre à jour des attributs d'instance :

```python
class Citronnier:
    def __init__(self, nbcitrons, age):
        self.nbcitrons, self.age = nbcitrons, age

    def __call__(self, nbcitrons, age):
        self.nbcitrons, self.age = nbcitrons, age

    def __str__(self):
        return "Ce citronnier a {} ans et {} citrons" \
               .format(self.age, self.nbcitrons)


if __name__ == "__main__":
    citronnier1 = Citronnier(10, 3)
    print(citronnier1)
    citronnier1(30, 4)
    print(citronnier1)
```

À la ligne 15, on utilise une notation `instance(arg1, arg2)`, ce qui va automatiquement appeler la méthode magique `.__call__()` qui mettra à jour les deux attributs d'instance `nbcitrons` et `age` (lignes 5 et 6). Ce code affichera la sortie suivante :

```default
Ce citronnier a 3 ans et 10 citrons
Ce citronnier a 4 ans et 30 citrons
```

<div class="details">
Nous vous avons montré l'idée qu'il y avait derrière le polymorphisme, et avec cela vous avez assez pour vous jeter à l'eau et commencer à construire vos propres classes. L'apprentissage de toutes les méthodes magiques va bien sûr au-delà du présent ouvrage. Toutefois, si vous souhaitez aller plus loin, nous vous conseillons la [page de Rafe Kettler](https://rszalski.github.io/magicmethods) qui est particulièrement complète et très bien faite.
</div>

## Héritage

### Prise en main

L'héritage peut évoquer la capacité qu'ont nos parents à nous transmettre certains traits physiques ou de caractère (ne dit-on pas, j'ai hérité ceci ou cela de ma mère ou de mon père ?). Qu'en est-il en programmation ?

<div class="definition">
En programmation, l'héritage est la capacité d'une classe d'hériter des propriétés d'une classe pré-existante. On parle de classe mère et de classe fille. En Python, l'héritage peut être multiple lorsqu'une classe fille hérite de plusieurs classes mères.
</div>

En Python, lorsque l'on veut créer une classe héritant d'une autre classe, on ajoutera après le nom de la classe fille le nom de la ou des classe(s) mère(s) entre parenthèses :

```python
class Mere1:
    # contenu de la classe mère 1


class Mere2:
    # contenu de la classe mère 2


class Fille1(Mere1):
    # contenu de la classe fille 1


class Fille2(Mere1, Mere2):
    # contenu de la classe fille 2
```

Dans cet exemple, la classe `Fille1` hérite de la classe `Mere1` et la classe `Fille2` hérite des deux classes `Mere1` et `Mere2`. Dans le cas de la classe `Fille2`, on parle d'héritage multiple. Voyons maintenant un exemple concret :

```{.python .number-lines}
class Mere:
    def bonjour(self):
        return "Vous avez le bonjour de la classe mère !"


class Fille(Mere):
    def salut(self):
        return "Un salut de la classe fille !"


if __name__ == "__main__":
    fille = Fille()
    print(fille.salut())
    print(fille.bonjour())
```

Lignes 1 à 3. On définit une classe `Mere` avec une méthode `.bonjour()`.

Lignes 6 à 8. On définit une classe `Fille` qui hérite de la classe `Mere`. Cette classe fille contient une nouvelle méthode `.salut()`.

Lignes 12 à 14. Après instanciation de la classe `Fille`, on utilise la méthode `.salut()`, puis la méthode `.bonjour()` héritée de la classe mère.

Ce code affiche la sortie suivante :

```default
Un salut de la classe fille !
Vous avez le bonjour de la classe mère !
```

Nous commençons à entrevoir la puissance de l'héritage. Si on possède une classe avec de nombreuses méthodes et que l'on souhaite en ajouter de nouvelles, il suffit de créer une classe fille héritant d'une classe mère.

En revenant à notre exemple, une instance de la classe `Fille` sera automatiquement une instance de la classe `Mere`. Regardons dans l'interpréteur :

```python
>>> fille = Fille()
>>> isinstance(fille, Fille)
True
>>> isinstance(fille, Mere)
True
```

Si une méthode de la classe fille possède le même nom que celle de la classe mère, c'est la première qui prend la priorité. Dans ce cas, on dit que la méthode est *redéfinie* (en anglais on parle de *method overriding*), tout comme on parlait de *redéfinition des opérateurs* un peu plus haut. C'est le même mécanisme, car la redéfinition des opérateurs revient finalement à redéfinir une méthode magique (comme par exemple la méthode `.__add__()` pour l'opérateur `+`).

Voyons un exemple :

```python
class Mere:
    def bonjour(self):
        return "Vous avez le bonjour de la classe mère !"


class Fille2(Mere):
    def bonjour(self):
        return "Vous avez le bonjour de la classe fille !"


if __name__ == "__main__":
    fille = Fille2()
    print(fille.bonjour())
```

Ce code va afficher `Vous avez le bonjour de la classe fille !`. La méthode `.bonjour()` de la classe fille a donc pris la priorité sur celle de la classe mère. Ce comportement provient de la gestion des espaces de noms par Python, il est traité en détail dans la rubrique suivante.

<div class="remarque">
À ce point, nous pouvons faire une note de sémantique importante. Python utilise le mécanisme de *redéfinition de méthode* (*method overriding*), c'est-à-dire qu'on redéfinit une méthode héritée d'une classe mère. Il ne faut pas confondre cela avec la *surcharge de fonction* (*function overloading*) qui désigne le fait d'avoir plusieurs définitions d'une fonction selon le nombres d'arguments et/ou leur type (la surcharge n'est pas supportée par Python contrairement à d'autres langages orientés objet).
</div>

### Ordre de résolution des noms

Vous l'avez compris, il y aura un ordre pour la résolution des noms d'attributs ou de méthodes en fonction du ou des héritage(s) de notre classe (à nouveau, cela provient de la manière dont Python gère les espaces de noms). Prenons l'exemple d'une classe déclarée comme suit `class Fille(Mere1, Mere2):`. Si on invoque un attribut ou une méthode sur une instance de cette classe, Python cherchera d'abord dans la classe `Fille`. S'il ne trouve pas, il cherchera ensuite dans la première classe mère (`Mere1` dans notre exemple). S'il ne trouve pas, il cherchera dans les ancêtres de cette première mère (si elle en a), et ce en remontant la filiation (d'abord la grand-mère, puis l'arrière grand-mère, etc). S'il n'a toujours pas trouvé, il cherchera dans la deuxième classe mère (`Mere2` dans notre exemple) puis dans tous ses ancêtres. Et ainsi de suite, s'il y a plus de deux classes mères. Bien sûr, si aucun attribut ou méthode n'est trouvé, Python renverra une erreur.

Il est en général possible d'avoir des informations sur l'ordre de résolution des méthodes d'une classe en évoquant la commande `help()` sur celle-ci ou une de ses instances. Par exemple, si l'on crée une instance de la classe principale du module *Tkinter* :

```python
>>> import tkinter as tk
>>> racine = tk.Tk()
```

En invoquant la commande `help(racine)`, l'interpréteur nous montre :

```
Help on class Tk in module tkinter:

class Tk(Misc, Wm)
 |  Toplevel widget of Tk which represents mostly the main window
 |  of an application. It has an associated Tcl interpreter.
 |
 |  Method resolution order:
 |      Tk
 |      Misc
 |      Wm
 |      builtins.object
[...]
```

On voit tout de suite que la classe `Tk` hérite de deux autres classes `Misc` et `Wm`. Ensuite, le *help* indique l'ordre de résolution des méthodes : d'abord la classe `Tk` elle-même, ensuite ses deux mères `Misc` puis `Wm`, et enfin une dernière classe nommée `builtins.object` dont nous allons voir la signification maintenant.

<div class="remarque">
En Python, il existe une classe interne nommée `object` qui est en quelque sorte la classe ancêtre de tous les objets. Toutes les classes héritent de `object`.
</div>

Pour vous en convaincre, nous pouvons recréer une classe vide :

```python
>>> class Citron:
...     pass
```

Puis ensuite regarder l'aide sur l'une de ses instances :

```default
Help on class Citron in module __main__:

class Citron(builtins.object)
 |  Data descriptors defined here:
 |
 |  __dict__
 |      dictionary for instance variables (if defined)
[...]
```

L'aide nous montre que `Citron` a hérité de `builtins.object` bien que nous ne l'ayons pas déclaré explicitement. Cela se fait donc de manière implicite.

<div class="remarque">
Le module *builtins* possède toutes les fonctions internes à Python. Il est donc pratique pour avoir une liste de toutes ces fonctions internes en un coup d'œil. Regardons cela avec les deux instructions `import builtins` puis `dir(builtins)` :

```python
>>> import builtins
>>> dir(builtins)
['ArithmeticError', 'AssertionError', 'AttributeError', [...]
'ascii', 'bin', 'bool', 'bytearray', 'bytes', 'callable', 'chr', [...]
'list', 'locals', 'map', 'max', 'memoryview', 'min', 'next', 'object', [...]
'str', 'sum', 'super', 'tuple', 'type', 'vars', 'zip']
```

Au début, on y trouve les exceptions commençant par une lettre majuscule (cf. +@sec:gestion-des-exceptions), puis les fonctions Python de base tout en minuscule. On retrouve par exemple `list` ou `str`, mais il y a aussi `object`. Toutefois ces fonctions étant chargées de base dans l'interpréteur, l'importation de `builtins` n'est pas obligatoire : par exemple `list` revient au même que `builtins.list`, ou `object` revient au même que `builtins.object`.
</div>

En résumé, la syntaxe `class Citron:` sera équivalente à  
`class Citron(builtins.object):`  
ou à `class Citron(object):`.

Ainsi, même si on crée une classe `Citron` vide (contenant seulement une commande `pass`), elle possède déjà tout une panoplie de méthodes héritées de la classe `object`. Regardez l'exemple suivant :

```python
>>> class Citron:
...     pass
...
>>> c = Citron()
>>> dir(c)
['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__',
'__format__', '__ge__', '__getattribute__', '__gt__', '__hash__',
'__init__', '__le__', '__lt__', '__module__', '__ne__', '__new__',
'__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__',
'__str__', '__subclasshook__', '__weakref__']
>>> o = object()
>>> dir(o)
['__class__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__',
'__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__le__',
'__lt__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__',
'__setattr__', '__sizeof__', '__str__', '__subclasshook__']
```

La quasi-totalité des attributs / méthodes de base de la classe `Citron` sont donc hérités de la classe *object*. Par exemple, lorsqu'on instancie un objet Citron `c = Citron()`, Python utilisera la méthode `.__init__()` héritée de la classe *object* (puisque nous ne l'avons pas définie dans la classe `Citron`).

### Un exemple concret d'héritage

Nous allons maintenant prendre un exemple un peu plus conséquent pour illustrer la puissance de l'héritage en programmation. D'abord quelques mots à propos de la conception. Imaginons que nous souhaitions créer plusieurs classes correspondant à nos fruits favoris, par exemple le citron (comme par hasard !), l'orange, le kaki, etc. Chaque fruit a ses propres particularités, mais il y a aussi de nombreux points communs. Nous pourrions donc concevoir une classe `Fruit` permettant, par exemple, d'instancier un fruit et ajouter des méthodes d'affichage commune à n'importe quel fruit, et ajouter (ou toute autre méthode) pouvant être utilisée pour n'importe quel fruit. Nous pourrions alors créer des classes comme `Citron`, `Orange`, etc., héritant de la classe `Fruit` et ainsi nous économiser des lignes de code identiques à ajouter pour chaque fruit. Regardons l'exemple suivant que nous avons garni de `print()` pour bien comprendre ce qui se passe :

```{.python .number-lines}
class Fruit:
    def __init__(self, taille=None, masse=None, saveur=None, forme=None):
        print("(2) Je suis dans le constructeur de la classe Fruit")
        self.taille = taille
        self.masse = masse
        self.saveur = saveur
        self.forme = forme
        print("Je viens de créer self.taille, self.masse, self.saveur "
              "et self.forme")

    def affiche_conseil(self, type_fruit, conseil):
        print("(2) Je suis dans la méthode .affiche_conseil() de la "
              "classe Fruit\n")
        return ("Instance {}\ntaille: {}, masse: {},\n"
                "saveur: {}, forme: {}\nconseil: {}\n"
                .format(type_fruit, self.taille, self.masse, self.saveur,
                        self.forme, conseil))


class Citron(Fruit):
    def __init__(self, taille=None, masse=None, saveur=None, forme=None):
        print("(1) Je rentre dans le constructeur de Citron, et je vais"
              "appeler\n"
              "le constructeur de la classe mère Fruit !")
        Fruit.__init__(self, taille, masse, saveur, forme)
        print("(3) J'ai fini dans le constructeur de Citron, "
              "les attributs sont: \nself.taille: {}, self.masse: {},\n"
              "self.saveur: {}, self.forme: {}\n"
              .format(self.taille, self.masse, self.saveur, self.forme))

    def __str__(self):
        print("(1) Je rentre dans la méthode .__str__() de la classe " \
              "Citron")
        print("Je vais lancer la méthode .affiche_conseil() héritée " \
              "de la classe Fruit")
        return self.affiche_conseil("Citron", "Bon en tarte :-p !")


if __name__ == "__main__":
    # on crée un citron
    citron1 = Citron(taille="petite", saveur="acide", forme="ellipsoïde",
                     masse=50)
    print(citron1)
```

Lignes 1 à 9. On crée la classe `Fruit` avec son constructeur qui initialisera tous les attributs d'instance décrivant le fruit.

Lignes 11 à 17. Création d'une méthode `.affiche_conseil()` qui retourne une chaîne contenant le type de fruit, les attributs d'instance du fruit, et un conseil de consommation.

Lignes 20 à 29. Création de la classe `Citron` qui hérite de la classe `Fruit`. Le constructeur de `Citron` prend les mêmes arguments que ceux du constructeur de `Fruit`. La ligne 24 est une étape importante que nous n'avons encore jamais vue : l'instruction `Fruit.__init__()` est un appel au constructeur de la classe mère (cf. explications plus bas). Notez bien que le premier argument passé au constructeur de la classe mère sera systématiquement l'instance en cours `self`. Le `print()` en lignes 26-29 illustre qu'après l'appel du constructeur de la classe mère  tous les attributs d'instance (`self.taille`, `self.poids`, etc.) ont bel et bien été créés.

Lignes 31 à 36. On définit la méthode `.__str__()` qui va modifier le comportement de notre classe avec `print()`. Celle-ci fait également appel à une méthode hértitée de la classe mère nommée `.affiche_conseil()`. Comme on a l'a héritée, elle est directement accessible avec un `self.méthode()` (et de l'extérieur ce serait `instance.méthode()`).

Lignes 39 à 43. Dans le programme principal, on instancie un objet `Citron`, puis on utilise `print()` sur l'instance.

L'exécution de ce code affichera la sortie suivante :

```default
(1) Je rentre dans le constructeur de Citron, et je vais appeler
le constructeur de la classe mère Fruit !
(2) Je suis dans le constructeur de la classe Fruit
Je viens de créer self.taille, self.masse, self.saveur et self.forme
(3) J'ai fini dans le constructeur de Citron, les attributs sont:
self.taille: petite, self.masse: 50,
self.saveur: acide, self.forme: ellipsoïde

(1) Je rentre dans la méthode .__str__() de la classe Citron
Je vais lancer la méthode .affiche_conseil() héritée de la classe Fruit
(2) Je suis dans la méthode .affiche_conseil() de la classe Fruit

Instance Citron
taille: petite, masse: 50,
saveur: acide, forme: ellipsoïde
conseil: Bon en tarte :-p !
```

Prenez bien le temps de suivre ce code pas à pas pour bien en comprendre toutes les étapes.

Vous pourrez vous poser la question « *Pourquoi utilise-t-on en ligne 24 la syntaxe* `Fruit.__init__()` *?* ». Cette syntaxe est souvent utilisée lorsqu'une classe hérite d'une autre classe pour faire appel au constructeur de la classe mère. La raison est que nous souhaitons appeler une méthode de la classe mère qui a le même nom qu'une méthode de la classe fille. Dans ce cas, si on utilisait `self.__init__()`, cela correspondrait à la fonction de notre classe fille Citron. En mettant systématiquement une syntaxe   `ClasseMere.__init__()` on indique sans ambiguïté qu'on appelle le constructeur de la classe mère, en mettant explicitement son nom.

<div class="remarque">
Si vous utilisez des ressources externes, il se peut que vous rencontriez une syntaxe `super().__init__()`. La fonction Python interne `super()` appelle automatiquement la classe mère sans que vous ayez à donner son nom. Même si cela peut paraître pratique, nous vous conseillons d'utiliser dans un premier temps la syntaxe  
`ClasseMere.__init__()` qui est selon nous plus lisible (on voit explicitement le nom de la classe employée, même s'il y a plusieurs classes mères).
</div>

Ce mécanisme n'est pas obligatoirement utilisé, mais il est très utile lorsqu'une classe fille a besoin d'initialiser des attributs définis dans la classe mère. On le croise donc souvent car :

- Cela donne la garantie que toutes les variables de la classe mère sont bien initialisées. On réduit ainsi les risques de dysfonctionnement des méthodes héritées de la classe mère.
- Finalement, autant ré-utiliser les « moulinettes » de la classe mère, c'est justement à ça que sert l'héritage ! Au final, on écrit moins de lignes de code.

<div class="conseils">
Pour les deux raisons citées ci-dessus, nous vous conseillons de systématiquement utiliser le constructeur de la classe mère lors de l'instanciation.
</div>

Vous avez à présent bien compris le fonctionnement du mécanisme de l'héritage. Dans notre exemple, nous pourrions créer de nouveaux fruits avec un minimum d'effort. Ceux-ci pourraient hériter de la classe mère `Fruit` à nouveau, et nous n'aurions pas à réécrire les mêmes méthodes pour chaque fruit, simplement à les appeler. Par exemple :

```python
class Kaki(Fruit):
    def __init__(self, taille=None, masse=None, saveur=None, forme=None):
        Fruit.__init__(self, taille, masse, saveur, forme)

    def __str__(self):
        return Fruit.affiche_conseil(self, "Kaki",
                                     "Bon à manger cru, miam !")


class Orange(Fruit):
    def __init__(self, taille=None, masse=None, saveur=None, forme=None):
        Fruit.__init__(self, taille, masse, saveur, forme)

    def __str__(self):
        return Fruit.affiche_conseil(self, "Orange", "Trop bon en jus !")
```

Cet exemple illuste la puissance de l'héritage et du polymorphisme et la facilité avec laquelle on les utilise en Python. Pour chaque fruit, on utilise la méthode  
`.affiche_conseil()` définie dans la classe mère sans avoir à la réécrire. Bien sûr cet exemple reste simpliste et n'est qu'une « mise en bouche ».

<div class="details">
À ce stade, nous pouvons émettre deux remarques :

L'héritage et le polymorphisme donnent toute la puissance à la POO. Toutefois, concevoir ses classes sur un projet, surtout au début de celui-ci, n'est pas chose aisée. Nous vous conseillons de lire d'autres ressources et de vous entraîner sur un maximum d'exemples.
Si vous souhaitez allez plus loin sur la POO, nous vous conseillons de lire des ressources supplémentaires. En langue française, vous trouverez les livres de [Gérard Swinnen](https://inforef.be/swi/python.htm), [Bob Cordeau et Laurent Pointal](https://perso.limsi.fr/pointal/python:courspython3), et [Vincent Legoff](https://openclassrooms.com/fr/courses/235344-apprenez-a-programmer-en-python).
</div>

## Accès et modifications des attributs depuis l'extérieur

### Le problème

On a vu jusqu'à maintenant que Python était très permissif concernant le changement de valeur de n'importe quel attribut depuis l'extérieur. On a vu aussi qu'il était même possible de créer de nouveaux attributs depuis l'extérieur ! Dans d'autres langages orientés objet ceci n'est pas considéré comme une bonne pratique. Il est plutôt recommandé de définir une *interface*, c'est-à-dire tout un jeu de méthodes accédant ou modifiant les attributs. Ainsi, le concepteur de la classe a la garantie que celle-ci est utilisée correctement du « côté client ».

<div class="remarque">
Cette stratégie d'utiliser uniquement l'interface de la classe pour accéder aux attributs provient des langages orientés objet comme Java et C++. Les méthodes accédant ou modifiant les attributs s'appellent aussi des *getters* et *setters* (en français on dit accesseurs et mutateurs). Un des avantages est qu'il est ainsi possible de vérifier l'intégrité des données grâce à ces méthodes : si par exemple on souhaitait avoir un entier seulement, ou bien une valeur bornée, on peut facilement ajouter des tests dans le *setter* et renvoyer une erreur à l'utilisateur de la classe s'il n'a pas envoyé le bon type (ou la bonne valeur dans l'intervalle imposé).
</div>

Regardons à quoi pourrait ressembler une telle stratégie en Python :

```{.python .number-lines}
class Citron:
    def __init__(self, couleur="jaune", masse=0):
        self.couleur = couleur
        self.masse = masse  # masse en g

    def get_couleur(self):
        return self.couleur

    def set_couleur(self, value):
        self.couleur = value

    def get_masse(self):
        return self.masse

    def set_masse(self, value):
        if value < 0:
            raise ValueError("Z'avez déjà vu une masse négative ???")
        self.masse = value


if __name__ == "__main__":
    # définition de citron1
    citron1 = Citron()
    print(citron1.get_couleur(), citron1.get_masse())
    # on change les attributs de citron1 avec les setters
    citron1.set_couleur("jaune foncé")
    citron1.set_masse(100)
    print(citron1.get_couleur(), citron1.get_masse())
```

Lignes 6 à 10. On définit deux méthodes *getters* pour accéder à chaque attribut.

Lignes 12 à 18. On définit deux méthodes *setters* pour modifier chaque attribut. Notez qu'en ligne 16 nous testons si la masse est négative, si tel est le cas nous générons une erreur avec le mot-clé `raise` (cf. +@sec:gestion-des-exceptions). Ceci représente un des avantages des *setters* : contrôler la validité des attributs (on pourrait aussi vérifier qu'il s'agit d'un entier, etc.).

Lignes 22 à 28. Après instanciation, on affiche la valeur des attributs avec les deux fonctions *getters*, puis on les modifie avec les *setters* et on les réaffiche à nouveau.

L'exécution de ce code donnera la sortie suivante :

```default
jaune 0
jaune foncé 100
```

Si on avait mis `citron1.set_masse(-100)` en ligne 26, la sortie aurait été la suivante :

```default
jaune 0
Traceback (most recent call last):
  File "./getter_setter.py", line 26, in <module>
    citron1.set_masse(-100)
  File "./getter_setter.py", line 17, in set_masse
    raise ValueError("Z'avez déjà vu une masse négative ???")
ValueError: Z'avez déjà vu une masse négative ???
```

La fonction interne `raise` nous a permis de générer une erreur car l'utilisateur de la classe (c'est-à-dire nous dans le programme principal) n'a pas rentré une valeur correcte.

On comprend bien l'utilité d'une stratégie avec des *getters* et *setters* dans cet exemple. Toutefois, en Python, on peut très bien accéder et modifier les attributs même si on a des *getters* et des *setters* dans la classe. Imaginons la même classe `Citron` que ci-dessus, mais on utilise le programme principal suivant (notez que nous avons simplement ajouter les lignes 9 à 12 ci-dessous) :

```python
if __name__ == "__main__":
    # définition de citron1
    citron1 = Citron()
    print(citron1.get_couleur(), citron1.get_masse())
    # on change les attributs de citron1 avec les setters
    citron1.set_couleur("jaune foncé")
    citron1.set_masse(100)
    print(citron1.get_couleur(), citron1.get_masse())
    # on les rechange sans les setters
    citron1.couleur = "pourpre profond"
    citron1.masse = -15
    print(citron1.get_couleur(), citron1.get_masse())
```

Cela donnera la sortie suivante :

```default
jaune 0
jaune foncé 100
pourpre profond -15
```

Malgré la présence des *getters* et des *setters*, nous avons réussi à accéder et à modifier la valeur des attributs. De plus, nous avons pu mettre une valeur aberrante (masse négative) sans que cela ne génère une erreur !

Vous vous posez sans doute la question : mais dans ce cas, quel est l'intérêt de mettre des *getters* et des *setters* en Python ? La réponse est très simple : cette  stratégie n'est pas une manière « pythonique » d'opérer (voir le +@sec:bonnes-pratiques-en-programmation-python pour la définition de « pythonique »). En Python, la lisibilité est la priorité. Souvenez-vous du Zen de Python « *Readability counts* » (voir  le +@sec:bonnes-pratiques-en-programmation-python).

De manière générale, une syntaxe avec des *getters* et *setters* du côté client surcharge la lecture. Imaginons que l'on ait une instance nommée `obj` et que l'on souhaite faire la somme de ses trois attributs `x`, `y` et `z` :

```python
# pythonique
obj.x + obj.y + obj.z

# non pythonique
obj.get_x() + obj.get_y() + obj.get_z()
```

La méthode pythonique est plus « douce » à lire, on parle aussi de *syntactic sugar* ou littéralement en français « *sucre syntaxique* ». De plus, à l'intérieur de la classe, il faut définir un *getter* et un *setter* pour chaque attribut, ce qui multiple les lignes de code.

Très bien. Donc en Python, on n'utilise pas comme dans les autres langages orientés objet les *getters* et les *setters*  ? Mais, tout de même, cela avait l'air une bonne idée de pouvoir contrôler comment un utilisateur de la classe interagit avec certains attributs (par exemple, rentre-t-il une bonne valeur ?). N'existe-t-il pas un moyen de faire ça en Python ? La réponse est : bien sûr il existe un moyen pythonique, la classe `property`. Nous allons voir cette nouvelle classe dans la prochaine rubrique et nous vous dirons comment opérer systématiquement pour accéder, modifier, voire détruire, chaque attribut d'instance de votre classe.

### La solution : la classe `property`

Dans la rubrique précédente, on vient de voir que les *getters* et *setters* traditionnels rencontrés dans d'autres langages orientés objet ne représentent pas une pratique pythonique. En Python, pour des raisons de lisibilité, il faudra dans la mesure du possible conserver une syntaxe `instance.attribut` pour l'accès aux attributs d'instance, et une syntaxe `instance.attribut = nouvelle_valeur` pour les modifier.

Toutefois, si on souhaite contrôler l'accès, la modification (voire la destruction) de certains attributs stratégiques, Python met en place une classe nommée `property`. Celle-ci permet de combiner le maintien de la syntaxe lisible `instance.attribut`, tout en utilisant en filigrane des fonctions pour accéder, modifier, voire détruire l'attribut (à l'image des *getters* et *setters* évoqués ci-dessus, ainsi que des *deleters* ou encore destructeurs en français). Pour faire cela, on utilise la fonction Python interne `property()` qui crée un objet (ou instance) `property` :

```python
attribut = property(fget=accesseur, fset=mutateur, fdel=destructeur)
```

Les arguments passés à `property()` sont systématiquement des méthodes dites *callback*, c'est-à-dire des noms de méthodes que l'on a définies précédemment dans notre classe, mais on ne précise ni argument, ni parenthèse, ni `self`. Avec cette ligne de code, `attribut` est un objet de type *property* qui fonctionne de la manière suivante à l'extérieur de la classe :

- L'instruction `instance.attribut` appellera la méthode `.accesseur()`.
- L'instruction `instance.attribut = valeur` appellera la méthode  
`.mutateur()`.
- L'instruction `del instance.attribut` appellera la méthode  
`.destructeur()`.

L'objet `attribut` est de type *property*, et la vraie valeur de l'attribut est stockée par Python dans une variable d'instance qui s'appellera par exemple `_attribut` (même nom mais commençant par un *underscore* unique, envoyant un message à l'utilisateur qu'il s'agit d'une variable associée au comportement interne de la classe).

Comment cela fonctionne-t-il concrètement dans un code ? Regardons cet exemple (nous avons mis des `print()` un peu partout pour bien comprendre ce qui se passe) :

```{.python .number-lines}
class Citron:
    def __init__(self, masse=0):
        print("(2) J'arrive dans le .__init__()")
        self.masse = masse

    def get_masse(self):
        print("Coucou je suis dans le get")
        return self._masse

    def set_masse(self, valeur):
        print("Coucou je suis dans le set")
        if valeur < 0:
            raise ValueError("Z'avez déjà vu une masse négative ?"
                             "C'est nawak")
        self._masse = valeur

    masse = property(fget=get_masse, fset=set_masse)


if __name__ == "__main__":
     print("(1) Je suis dans le programme principal, "
           "je vais instancier un Citron")
     citron = Citron(masse=100)
     print("(3) Je reviens dans le programme principal")
     print("La masse de notre citron est {} g".format(citron.masse))
     # on mange le citron
     citron.masse = 25
     print("La masse de notre citron est {} g".format(citron.masse))
     print(citron.__dict__)
```

Pour une fois, nous allons commenter les lignes dans le désordre :

Ligne 17. Il s'agit de la commande clé pour mettre en place le système : `masse` devient ici un objet de type *property* (si on regarde son contenu avec une syntaxe `NomClasse.attribut_property`, donc ici `Citron.masse`, Python nous renverra quelque chose de ce style : `<property object at 0x7fd3615aeef8>`). Qu'est-ce que cela signifie ? Et bien la prochaine fois qu'on voudra accéder au contenu de cet attribut `.masse`, Python appellera la méthode `.get_masse()`, et quand on voudra le modifier, Python appellera la méthode `.set_masse()` (ceci sera valable de l'intérieur ou de l'extérieur de la classe). Comme il n'y a pas de méthode destructeur (passée avec l'argument `fdel`), on ne pourra pas détruire cet attribut : un `del c.masse` conduirait à une erreur de ce type : `AttributeError: can't delete attribute`.

Ligne 4. Si vous avez bien suivi, cette commande `self.masse = masse` dans le constructeur va appeler automatiquement la méthode `.set_masse()`. Attention, dans cette commande, la variable `masse` à droite du signe `=` est une variable *locale* passée en argument. Par contre, `self.masse` sera l'objet de type *property*. Si vous avez bien lu la rubrique *Différence entre les attributs de classe et d’instance*, l'objet `masse` créé en ligne 16 est un attribut de classe, on peut donc y accéder avec une syntaxe `self.masse` au sein d'une méthode.

<div class="conseils">
Notez bien l'utilisation de `self.masse` dans le constructeur (en ligne 4) plutôt que `self._masse`. Comme `self.masse` appelle la méthode `.set_masse()`, cela permet de contrôler si la valeur est correcte dès l'instanciation. C'est donc une pratique que nous vous recommandons. Si on avait utilisé `self._masse`, il n'y aurait pas eu d'appel à la fonction mutateur et on aurait pu mettre n'importe quoi, y compris une valeur aberrante, lors de l'instanciation.
</div>

Lignes 6 à 15. Dans les méthodes accesseur et mutateur, on utilise la variable  
`self._masse` qui contiendra la vraie valeur de la masse du citron (cela serait vrai pour tout autre objet de type *property*).

<div class="attention">
Dans les méthodes accesseur et mutateur il ne faut surtout pas utiliser `self.masse` à la place de `self._masse`. Pourquoi ? Par exemple, dans l'accesseur, si on met `self.masse` cela signifie que l'on souhaite accéder à la valeur de l'attribut (comme dans le constructeur !). Ainsi, Python rappellera l'accesseur et retombera sur `self.masse`, ce qui rappellera l'accesseur et ainsi de suite : vous l'aurez compris, cela partira dans une récursion infinie et mènera à une erreur du type `RecursionError: maximum recursion depth exceeded`. Cela serait vrai aussi si vous aviez une fonction destructeur, il faudrait utiliser `self._masse`).
</div>

L'exécution de ce code donnera :

```default
(1) Dans le programme principal, je vais instancier un Citron
(2) J'arrive dans le .__init__()
Coucou je suis dans le set
(3) Je reviens dans le programme principal
Coucou je suis dans le get
La masse de notre citron est 100 g
Coucou je suis dans le set
Coucou je suis dans le get
La masse de notre citron est 25 g
{'_masse': 25}
```

Cette exécution montre qu'à chaque appel de `self.masse` ou `citron.masse` on va utiliser les méthodes accesseur ou mutateur. La dernière commande qui affiche le contenu de `citron.__dict__` montre que la vraie valeur de l'attribut est stockée dans la variable d'instance `._masse` (`instance._masse` de l'extérieur et `self._masse` de l'intérieur).

<div class="details">
Il existe une autre syntaxe considérée comme plus élégante pour mettre en place les objets *property*. Il s'agit des *décorateurs* `@property`, `@attribut.setter` et `@attribut.deleter`. Toutefois, la notion de décorateur va au-delà du présent ouvrage. Si vous souhaitez plus d'informations, vous pouvez consulter par exemple le [site programiz](https://www.programiz.com/python-programming/property) ou le livre de [Vincent Legoff](https://openclassrooms.com/fr/courses/235344-apprenez-a-programmer-en-python).
</div>

## Bonnes pratiques pour construire et manipuler ses classes

Nous allons voir dans cette rubrique certaines pratiques que nous vous recommandons lorsque vous construisez vos propres classes.

### L'accès aux attributs

On a vu dans la rubrique *Accès et modifications des attributs depuis l'extérieur* que nous avions le moyen de contrôler cet accès avec la classe *property*. Toutefois, cela peut parfois alourdir inutilement le code, ce qui va à l'encontre de certains préceptes de la PEP 20 comme « *Sparse is better than dense* », « *Readability counts* », etc. (voir le +@sec:bonnes-pratiques-en-programmation-python).

<div class="conseils">
Si on souhaite contrôler ce que fait le client de la classe pour certains attributs « délicats » ou « stratégiques », on peut utiliser la classe *property*. Toutefois, nous vous conseillons de ne l'utiliser que lorsque cela se révèle vraiment nécessaire, donc avec parcimonie. Le but étant de ne pas surcharger le code inutilement. Cela va dans le sens des recommandations des développeurs de Python (comme décrit dans la PEP8).
</div>

Les objets *property* ont deux avantages principaux :

- ils permettent de garder une lisibilité du côté client avec une syntaxe  
`instance.attribut` ;
- même si un jour vous décidez de modifier votre classe et de mettre en place un contrôle d'accès à certains attributs avec des objets *property*, cela ne changera rien du côté client. Ce dernier utilisera toujours `instance.attribut` ou  
`instance.attribut = valeur`. Tout cela contribuera à une meilleure maintenance du code client utilisant votre classe.

Certains détracteurs disent qu'il est parfois difficile de déterminer qu'un attribut est contrôlé avec un objet *property*. La réponse à cela est simple, dites-le clairement dans la documentation de votre classe via les *docstrings* (voir la rubrique ci-dessous).

### Note sur les attributs publics et non publics

Certains langages orientés objet mettent en place des attributs dits *privés* dont l'accès est impossible de l'extérieur de la classe. Ceux-ci existent afin d'éviter qu'un client n'aille perturber ou casser quelque chose dans la classe. Les arguments auxquels l'utilisateur a accès sont dits *publics*.

<div class="attention">
En Python, il n'existe pas d'attributs privés comme dans d'autres langages orientés objet. L'utilisateur a accès à tous les attributs quels qu'ils soient, même s'ils contiennent un ou plusieurs caractère(s) *underscore(s)* (cf. ci-desssous) !
</div>

Au lieu de ça, on parle en Python d'attributs publics et *non publics*.

<div class="definition">

En Python les attributs non publics sont des attributs dont le nom commence par un ou deux caractère(s) *underscore*. Par exemple, `_attribut`, ou `__attribut`.

</div>

La présence des *underscores* dans les noms d'attributs est un signe clair que le client ne doit pas y toucher. Toutefois, cela n'est qu'une convention, et comme dit ci-dessus le client peut tout de même modifier ces attributs.

Par exemple, reprenons la classe `Citron` de la rubrique précédente dont l'attribut `.masse` est contrôlé avec un objet *property* :

```python
>>> citron = Citron()
Coucou je suis dans le set
>>> citron.masse
Coucou je suis dans le get
0
>>> citron.masse = -16
Coucou je suis dans le set
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 10, in set_masse
ValueError: Z'avez déjà vu une masse négative ? C'est nawak
>>> citron.masse = 16
Coucou je suis dans le set
>>> citron.masse
Coucou je suis dans le get
16
>>> citron._masse
16
>>> citron._masse = -8364
>>> citron.masse
Coucou je suis dans le get
-8364
>>>
```

Malgré l'objet `property`, nous avons pu modifier l'attribut non public `._masse` directement !

Il existe également des attributs dont le nom commence par deux caractères *underscores*. Nous n'avons encore jamais croisé ce genre d'attribut. Ces derniers mettent en place le *name mangling*.

<div class="definition">
Le [*name mangling*](https://en.wikipedia.org/wiki/Name_mangling), ou encore substantypage ou déformation de nom en français, correspond à un mécanisme de changement du nom d'un attribut selon si on est à l'intérieur ou à l'extérieur d'une classe.
</div>

Regardons un exemple :

```
class Citron:
    def __init__(self):
        self.__mass = 100

    def get_mass(self):
        return self.__mass


if __name__ == "__main__":
    citron1 = Citron()
    print(citron1.get_mass())
    print(citron1.__mass)
```

Ce code va donner la sortie suivante :

```
100
Traceback (most recent call last):
  File "./pyscripts/mangling.py", line 11, in <module>
    print(citron1.__mass)
AttributeError: 'Citron' object has no attribute '__mass'
```

La ligne 12 du code a donc conduit à une erreur : Python prétend ne pas connaître l'attribut `.__mass`. On pourrait croire que cela constitue un mécanisme de protection des attributs. En fait il n'en est rien, car on va voir que l'attribut est toujours accessible et modifiable. Si on modifiait le programme principal comme suit :

```
if __name__ == "__main__":
    citron1 = Citron()
    print(citron1.__dict__)
```

On obtiendrait en sortie le dictionnaire `{'_Citron__mass': 100}`.

Le *name mangling* est donc un mécanisme qui transforme le nom `self.__attribut` à l'intérieur de la classe en `instance._NomClasse__attribut` à l'extérieur de la classe. Ce mécanisme a été conçu initialement pour pouvoir retrouver des noms d'attributs identiques lors de l'héritage. Si par exemple une classe mère et une classe fille ont chacune un attribut nommé `__attribut`, le *name mangling* permet d'éviter les conflits de nom. Par exemple :

```python
class Fruit:
    def __init__(self):
        self.__mass = 100


class Citron(Fruit):
    def __init__(self):
        Fruit.__init__(self)
        self.__mass = 200

    def print_masse(self):
        print(self._Fruit__mass)
        print(self.__mass)


if __name__ == "__main__":
    citron1 = Citron()
    citron1.print_masse()
```

Ce code affiche `100` puis `200`. La ligne 12 a permis d'accéder à l'attribut `.__mass` de la classe mère `Fruit`, et la ligne 13 a permis d'accéder à l'attribut `.__mass` de la classe `Citron`.


Le *name mangling* n'est donc pas un mécanisme de « protection » d'un attribut, il n'a pas été conçu pour ça. Les concepteurs de Python le disent clairement dans la PEP 8: « *Generally, double leading underscores should be used only to avoid name conflicts with attributes in classes designed to be subclassed* ».

Donc en Python, on peut tout détruire, même les attributs délicats contenant des *underscores*. Pourquoi Python permet-il un tel paradoxe ? Et bien selon le concepteur Guido van Rossum : « *We’re all consenting adults here* », nous sommes ici entre adultes, autrement dit nous savons ce que nous faisons !

<div class="conseils">
En résumé, n'essayez pas de mettre des barrières inutiles vers vos attributs. Cela va à l'encontre de la philosophie Python. Soignez plutôt la documentation et faites confiance aux utilisateurs de votre classe !
</div>

### Classes et *docstrings*

Les classes peuvent bien sûr contenir des *docstrings* comme les fonctions et les modules. C'est d'ailleurs une pratique vivement recommandée. Voici un exemple sur notre désormais familière classe `Citron` :

```python
class Citron:
    """Voici la classe Citron.

    Il s'agit d'une classe assez impressionnante qui crée des objets
    citrons.
    Par défaut une instance de Citron contient l'attribut de classe
    saveur.
    """
    saveur = "acide"

    def __init__(self, couleur="jaune", taille="standard"):
        """Constructeur de la classe Citron.

        Ce constructeur prend deux arguments par mot-clé
        couleur et taille."""
        self.couleur = couleur
        self.taille = taille

    def __str__(self):
        """Redéfinit le comportement avec print()."""
        return "saveur: {}, couleur: {}, taille: {}".format(
            saveur, couleur, taille)

    def affiche_coucou(self):
        """Méthode inutile qui affiche coucou."""
        print("Coucou !")
```

Si on fait `help(Citron)` dans l'interpréteur, on obtient :

```default
Help on class Citron in module __main__:

class Citron(builtins.object)
 |  Citron(couleur='jaune', taille='standard')
 |
 |  Voici la classe Citron.
 |
 |  Il s'agit d'une classe assez impressionnante qui crée des objets
 |  citrons.
 |  Par défaut une instance de Citron contient l'attribut de classe
 |  saveur.
 |
 |  Methods defined here:
 |
 |  __init__(self, couleur='jaune', taille='standard')
 |      Constructeur de la classe Citron.
 |
 |      Ce constructeur prend deux arguments par mot-clé
 |      couleur et taille.
 |
 |  __str__(self)
 |      Redéfinit le comportement avec print().
 |
 |  affiche_coucou(self)
 |      Méthode inutile qui affiche coucou.
 |
 [...]
 |
 |  Data and other attributes defined here:
 |
 |  saveur = 'acide'
```

Python formate automatiquement l'aide comme il le fait avec les modules (voir +@sec:creation-de-modules). Comme nous l'avons dit dans le +@sec:bonnes-pratiques-en-programmation-python, n'oubliez pas que les *docstrings* sont destinées aux utilisateurs de votre classe. Elle doivent donc contenir tout ce dont un utilisateur a besoin pour comprendre ce que fait la classe et comment l'utiliser.

Notez que si on instancie la classe `citron1 = Citron()` et qu'on invoque l'aide sur l'instance `help(citron1)`, on obtient la même page d'aide. Comme pour les modules, si on invoque l'aide pour une méthode de la classe  
`help(citron1.affiche_coucou)`, on obtient l'aide pour cette méthode seulement.

Toutes les *docstrings* d'une classe sont en fait stockées dans un attribut spécial nommé `instance.__doc__`. Cet attribut est une chaîne de caractères contenant la *docstring* générale de la classe. Ceci est également vrai pour les modules, méthodes et fonctions. Si on reprend notre exemple ci-dessus :

```python
>>> citron1 = Citron()
>>> print(citron1.__doc__)
Voici la classe Citron.

    Il s'agit d'une classe assez impressionnante qui crée des objets
    citrons.
    Par défaut une instance de Citron contient l'attribut de classe
    saveur.

>>> print(citron1.affiche_coucou.__doc__)
Méthode inutile qui affiche coucou.
```

L'attribut `.__doc__` est automatiquement créé par Python au moment de la mise en mémoire de la classe (ou module, méthode, fonction, etc.).

### Autres bonnes pratiques

Voici quelques points en vrac auxquels nous vous conseillons de faire attention :

- Une classe ne se conçoit pas sans méthode. Si on a besoin d'une structure de données séquentielles ou si on veut donner des noms aux variables (plutôt qu'un indice), utilisez plutôt les dictionnaires. Une bonne alternative peut être les *namedtuples* (cf. rubrique suivante).
- Nous vous déconseillons de mettre comme paramètre par défaut une liste vide (ou tout autre objet séquentiel modifiable) :

    ```python
    def __init__(self, liste=[]):
    self.liste = liste
    ```

Si vous créez des instances sans passer d'argument lors de l'instanciation, toutes ces instances pointeront vers la même liste. Cela peut avoir des effets désastreux.

- Ne mettez pas non plus une liste vide (ou tout autre objet séquentiel modifiable) comme attribut de classe.

	```
	class Citron:
        liste = []
	```

Ici chaque instance pourra modifier la liste, ce qui n'est pas souhaitable. Souvenez vous, la modification des attributs de classe doit se faire par une syntaxe `Citron.attribut = valeur` (et non pas via les instances).

- Comme abordé dans la rubrique *Différence entre les attributs de classe et d'instance*, nous vous conseillons de ne jamais modifier les attributs de classe. Vous pouvez néanmois les utiliser comme constantes.
- Si vous avez besoin d'attributs modifiables, utilisez des attributs d'instance et initialisez les dans la méthode `.__init__()` (et nulle part ailleurs). Par exemple, si vous avez besoin d'une liste comme attribut, créez la plutôt dans le constructeur :

	```
	class Citron:
    def __init__(self):
        self.liste = []
	```

Ainsi, vous aurez des listes réellement indépendantes pour chaque instance.

### Pour finir les *namedtuples*

Imaginons que l'on souhaite stocker des éléments dans un container, que l'on puisse retrouver ces éléments avec une syntaxe `container.element` et que ces éléments soit non modifiables. On a vu ci-dessus, les classes ne sont pas faites pour cela, il n'est pas conseillé de les utiliser comme des containers inertes, on les conçoit en général afin d'y créer aussi des méthodes. Dans ce cas, les [*namedtuples*](https://docs.python.org/fr/3/library/collections.html#collections.namedtuple) sont faits pour vous ! Ce type de container est issu du très utile module *collections* que nous avions évoqué au +@sec:dictionnaires-n-uplets-et-ensembles.

```
>>> import collections
>>> Citron = collections.namedtuple("Citron", "masse couleur saveur forme")
>>> Citron
<class '__main__.Citron'>
>>> citron = Citron(10, "jaune", "acide", "ellipsoide")
>>> citron
Citron(masse=10, couleur='jaune', saveur='acide', forme='ellipsoide')
>>> citron.masse
10
>>> citron.forme
'ellipsoide'
```

Lignes 2 à 4. La fonction `namedtuple()` renvoie une classe qui sert à créer de nouveaux objets citrons. Attention cette classe est différente de celles que l'on a rencontrées jusqu'à maintenant, car elle hérite de la classe `builtins.tuple` (on peut le voir en faisant `help(Citron)`). En ligne 2, on passe en argument le nom de la classe souhaitée (i.e. `Citron`), puis une chaîne de caractères avec des mots séparés par des espaces qui correspondront aux attributs (on pourrait aussi passer une liste `["masse", "couleur", "saveur", "forme"]`).

Ligne 5. On instancie un nouvel objet `citron`.

Lignes 6 à 11. On peut retrouver les différents attributs avec une syntaxe `instance.attribut`.

Mais dans *namedtuple*, il y a *tuple* ! Ainsi, l'instance `citron` hérite de tous les attributs des tuples :

```
>>> citron[0]
10
>>> citron[3]
'ellipsoide'
>>> citron.masse = 100
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: can't set attribute
>>> for elt in citron:
...     print(elt)
...
10
jaune
acide
ellipsoide
```

Lignes 1 à 4. On peut retrouver les attributs également par indice.

Lignes 5 à 8. Les attributs / éléments sont non modifiables !

Lignes 9 à 15. Les *namedtuples* sont itérables.

Enfin, il est possible de convertir un *namedtuple* en dictionnaire (ordonné) avec la méthode `._asdict()` :

```
>>> citron._asdict()
OrderedDict([('masse', 10), ('couleur', 'jaune'), ('saveur', 'acide'), ('forme', 'ellipsoide')])
```

Quand utiliser les *namedtuples* ? Vous souvenez-vous de la différence entre les listes et les dictionnaires ? Et bien là c'est un peu la même chose entre les *tuples* et les *namedtuples*. Les *namedtuples* permettent de créer un code plus lisible en remplaçant des numéros d'indice par des noms. Le fait qu'ils soient non modifiables peut aussi avoir un avantage par rapport à l'intégrité des données. Si vous trouvez les *namedtuples* limités, sachez que vous pouvez créer votre propre classe qui hérite d'un *namedtuple* afin de lui ajouter de nouvelles méthodes « maison ».

<div class="details">

Pour aller plus loin, vous pouvez consulter le très bon [article](https://dbader.org/blog/writing-clean-python-with-namedtuples) de Dan Bader.

</div>

## Travaux pratiques

Les travaux pratiques sont disponibles [en ligne](https://colab.research.google.com/drive/1Tgp3kRsElRsRM2237hxAbRnV-Dy_-8G_#forceEdit=true&sandboxMode=true).
