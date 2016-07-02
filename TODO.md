TODO
====

- Pour les "verses", remplacer les blockquote par des span class="vers"

- mettre une classe "externe" aux liens pointant vers une url extérieure

- supprimer le (hrule) avant les footnotes.

Quand tu auras fait ce qui précède
----------------------------------

- purement cosmétique, mais tant qu'on y est: supprimer le align="justify" dans les p qui sont dans les footnotes (ça doit se régler par du css)

- Comment faire pour que les appels de note ne soient pas renvoyés en début de ligne suivante? (qu'ils soient collés au mot précédent ou précédés d'un espace insécable, je n'arrive pas à les faire tenir)

Textes
------

  * Se procurer auprès de David Hart les originaux français des quelques textes de la collection Jean-Claude Paul-Dejean.

  * Pour information, mes usages de relecture-correction:

    - si différence dans les mots du texte de deux éditions (ex: journal ou œuvre publiée du vivant de Bastiat, vs œuvres complètes posthumes), adopter dernier texte publié du vivant de Bastiat et signaler différence en note.
    - si coquille évidente (exemple "abstacle"), corriger sans signaler. On ne fait pas une édition critique de manuscrits médiévaux où la moindre faute de copiste a un intérêt pour l'histoire du texte.
    - si différence d'orthographe ou de ponctuation, adopter la plus actuelle/correcte/élégante, sans signaler. Paillottet rajoute souvent des virgules, on s'en fiche, on ne fait pas paillottet.org.
    - Pour la même raison, les notes de Paillottet seront, selon leur utilité, conservées, supprimées ou modifiées (les renvois n'ont plus besoin d'avoir une indication de tome et de page: vive les liens hypertexte!).
    - à part ça, fidélité totale à l'orthographe et aux conventions typographiques d'origine (et mort aux "sic").


Infrastructure
--------------
  
  * Vu que j'utilise de plus en plus de javascript, rajouter peut-être un message d'alerte pour les navigateurs qui bloquent le javascript, ou prévoir une alternative.

  * Fix exscribe, so it's obvious where the error is.

  * Comprendre pourquoi Exscribe se met aléatoirement à faire des listes de "COMPILING DEFPARAMETER machin" pour chaque fichier compilé, et puis s'arrête quand je déplace les defparameters dans un autre fichier, et puis recommence sur un coup de tête.

  * Faire en sorte que Exscribe comprenne la syntaxe :journal (:titre titre1 :date date1) :journal (:titre titre2 :date date2) et puisse ranger les articles de titre1 (respectivement 2) par leur date1 (respectivement 2).

  * Je ne suis pas convaincue par le footer actuel. Je pense qu'il faudrait répartir les choses ainsi:
    - la référence au tome et à la page figurerait dans le volet gauche avec intro/plan. (c'est fait, reste à supprimer celles de bas de page)
    - les mentions de copistes et les liens vers "Le libéralisme, le vrai" devraient être renvoyées vers une page "mentions légales" ou "qui sommes-nous" ou "crédits" ou "à propos", accessible par un lien placé dans le footer ou le header.
    - il faudrait aussi supprimer le (hrule) du bas, vu que certaines sidenotes le traversent.

Trucs de Laura que Faré a le droit de regarder
----------------------------------------------

  * Ordre des priorités:

Structure

    1) Headers fixes élastiques
    2) Volet gauche (en haut de page sur les petits écrans) avec intro/résumé (+ éventuellement, plan) pour chaque texte
    le volet doit scroller au même rythme que la page, et rester fixe une fois arrivé en bas; idem dans l'autre sens.
    3) Sidenotes/footnotes responsives : prendre en compte la taille d'écran en cm, et pas en pixels.
    4) Sommaires thématique, chronologique etc., et liens entre eux
    5) Refonte radicale de la page d'accueil

Contenu

    1) Relecture/indexation personnes; (en cours: 61%)
    2) Enrichissement de l'index des personnes (informations biographiques, références des citations); même chose pour l'index des titres de journaux
    3) Création d'une database des personnes citées, et d'une fonctionnalité "filtre" (par époque, pays, profession…)
    4) Re-relecture avec:
      a) repérage et traduction des phrases latines + référencement des allusions bibliques;
      b) repérage des événements historiques cités, pour en faire un index chronologique;
      c) repérage de phrases bien tournées, susceptibles d'être affichées aléatoirement en page d'accueil;
      d) constitution du plan des textes les plus longs, pour l'afficher en sidebar gauche, + chapeaux introductifs;
      e) inventaire complet de tous les thèmes, tropes, figures, types d'arguments, leitmotivs (dans un tableur à part, dans un premier temps), pour servir à la constitution d'un index thématique et de pages thématiques (ou de simples renvois), et d'une sorte d'arborescence logique des arguments.

  * Page d'accueil: lien direct vers les œuvres, au lieu de devoir cliquer 50 fois pour accéder au sommaire.
  Différents accès:
    1) œuvres mises en vedette (cqovecqonvp, la loi, sophismes, pamphlets)
    2) accès par 4 types: livres et brochures / journaux / correspondance / ébauches non publiées (où classer les documents adressés aux électeurs ou au Conseil général des Landes?)
    3) liens vers accès par thèmes / par ordre chrono
    4) lien vers sources: principalement sommaire Guillaumin (et Lettres d'un habitant des Landes) + page dédiée aux œuvres ni dans Guillaumin ni dans LHL

  * Responsive design. (par ex, Menu de gauche avec intro + plan: sur les petits écrans, s'affichera au-dessus du text (éventuellement abrégé, avec un clic pour afficher tout); les notes seront marginales sur les grands écrans et en bas de page sur les petits (work in progress).)
 

Trucs de Laura, par Laura et pour Laura
---------------------------------------

  * Ajouter tableaux dans: Répartition de l'impôt foncier dans les Landes (au moins 40 tableaux... T_T)
  impot_foncier_landes: liens vers "page truc", à faire

  * Faire une maquette du site futur idéal (page d'accueil, sommaires, page de texte)
