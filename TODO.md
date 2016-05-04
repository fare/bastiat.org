TODO
====

Textes
------

  * Importer tous les textes manquant dans Bastiat.org

  * Faire une autre passe de re-lecture en comparant aux éditions originales,
    et/ou en faisant une comparaison avec des numérisations indépendantes.


Infrastructure
--------------

  * Fix exscribe, so it's obvious where the error is.

  * Strong should be small-caps, as in the original edition, rather
    than bold (to have bold, use a bold tag).

  * Fonts: use an old one in the style of the original edition for
    Bastiat writings, another one for other text.

  * Réparer liens vers Gallica.

Trucs de Laura que Faré a le droit de regarder
----------------------------------------------

  * Faire une fonction qui associe à un nom de fichier le titre d'une oeuvre (je veux obtenir <a href="1profit_2pertes">Un profit contre deux pertes</a> en tapant juste ,(1profit_2pertes), et je ne veux pas avoir à définir une fonction par fichier.)

  * Dans le même esprit, assigner à chaque fichier une date dans un format standardisé, pour pouvoir faire deux liens "précédent" et "suivant" qui atteignent automatiquement l'article suivant dans l'ordre chronologique, sans avoir à définir la cible des liens à chaque fois.

  * Dans personnes.scr, définir une fonction lettre (lettre[b]) qui renvoie: un (hrule) + un (tag :a :name "b") + un (subtitle[B]) + un (alphabet) (en attendant de rendre l'alphabet fixe en haut de page)
 

Trucs de Laura, par Laura et pour Laura
---------------------------------------

  * Re-centrer un paragraphe dans "le Vol à la prime" (ou mieux, m'expliquer comment centrer un truc)
    [Faré: utiliser (p :align :center ...), ou (div :align :center ...) ?]

  * Ajouter tableaux dans: De l'avenir du commerce des vins; Démocratie et libre-échange
    (format image? car gros gros tableau)

  * Faire une maquette du site futur idéal (page d'accueil, sommaires, page de texte)

  * Trouver une police qui permette les chiffres en bas-de-casse.
    [Faré: j'ai une fonction subscriptize si ça aide, et peux faire d'autres fonctions du genre,
	si tu as les bons caractères dans unicode.]
