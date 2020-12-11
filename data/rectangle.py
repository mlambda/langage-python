class Rectangle:
    """Ceci est la classe Rectangle."""

    def __init__(self, longueur=0.0, largeur=0.0, couleur="blanc"):
        """Initialisation d'un objet.

        Définition des attributs avec des valeurs par défaut.
        """
        self.longueur = longueur
        self.largeur = largeur
        self.couleur = couleur

    def calcule_surface(self):
        """Méthode qui calcule la surface."""
        return self.longueur * self.largeur

    def change_carre(self, cote):
        """Méthode qui transforme un rectangle en carré."""
        self.longueur = cote
        self.largeur = cote


if __name__ == "__main__":
    # Insérez ici la suite de votre programme Python
    # qui va utiliser la classe Rectangle.
    
