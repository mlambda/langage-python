"""Un script de multiplication."""


def multiplie_nombres(nombre1, nombre2):
    """Multiplication de deux nombres entiers.

    Cette fonction ne sert pas à grand chose.

    Parameters
    ----------
    nombre1 : int
        Le premier nombre entier.
    nombre2 : int
        Le second nombre entier.

        Avec une description plus longue.
        Sur plusieurs lignes.

    Returns
    -------
    int
        Le produit des deux nombres.

    """
    return nombre1 * nombre2


if __name__ == "__main__":
    print("2 x 3 = {}".format(multiplie_nombres(2, 3)))
    print("4 x 5 = {}".format(multiplie_nombres(4, 5)))
