import '/backend/schema/enums/enums.dart';

/// Affichage d'une catégorie d'affirmations : libellé, mascotte et accès.
class CategoryMeta {
  const CategoryMeta(this.category, this.label, this.image,
      {this.premium = true});

  final Category category;
  final String label;
  final String image;
  final bool premium;
}

/// Catégories proposées dans la page « Catégories », dans l'ordre d'affichage.
const kCategories = <CategoryMeta>[
  CategoryMeta(
      Category.general, 'Généralités', 'assets/images/Untitled_design_(58).png',
      premium: false),
  CategoryMeta(Category.calme, 'Trouver le calme',
      'assets/images/Untitled_design_(68).png'),
  CategoryMeta(Category.confiance, 'Confiance en soi',
      'assets/images/Untitled_design_-_2026-05-19T100230.162.png'),
  CategoryMeta(Category.attirer, 'Attirer l\'amour',
      'assets/images/Untitled_design_(98).png'),
  CategoryMeta(Category.foi, 'Foi', 'assets/images/Untitled_design_(94).png'),
  CategoryMeta(
      Category.sarca, 'Sarcasme', 'assets/images/Untitled_design_(66).png'),
  CategoryMeta(Category.carriere, 'Réussir sa carrière',
      'assets/images/Untitled_design_-_2026-05-19T095313.151.png'),
  CategoryMeta(Category.dev, 'Développement personnel',
      'assets/images/Untitled_design_(100).png'),
  CategoryMeta(Category.peine, 'Peine de coeur',
      'assets/images/Untitled_design_(99).png'),
  CategoryMeta(
      Category.coup, 'Coups durs', 'assets/images/Untitled_design_(95).png'),
  CategoryMeta(Category.depression, 'Combattre la dépression',
      'assets/images/Untitled_design_-_2026-05-19T101556.830.png'),
];

/// Catégories utilisées quand l'utilisateur n'en a choisi aucune.
const kDefaultCategories = [Category.general];

/// Valeur renvoyée par la feuille « Catégories » quand l'utilisateur ouvre
/// « Mes favoris » : la page principale affiche alors l'onglet Favoris.
const kOpenFavoritesResult = 'favorites';

/// Mascotte et libellé des favoris.
const kFavoritesLabel = 'Mes favoris';
const kFavoritesImage = 'assets/images/Untitled_design_(73).png';

CategoryMeta? categoryMetaFor(Category? category) {
  for (final meta in kCategories) {
    if (meta.category == category) {
      return meta;
    }
  }
  return null;
}
