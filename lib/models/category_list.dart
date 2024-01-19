class Category {
  final String titre;
  final String image;

  Category(this.titre, this.image);
}

List<Category> categories = [
  Category('Développement mobile', 'assets/category/developpementMobile.jpeg'),
  Category('Langage de programmation', 'assets/category/langageProgrammation.jpeg'),
  Category('Marketing numérique', 'assets/category/marketingNumerique.jpeg'),
  Category('Santé et bien-être', 'assets/category/santeBien.jpeg'),
  Category('Mathématiques', 'assets/category/mathematiques.jpeg'),
  Category('Tests de logiciels', 'assets/category/testLogiciels.jpeg'),
  Category('Conception de jeu', 'assets/category/conceptionJeu.jpeg'),
  Category('Développement web', 'assets/category/developpementWeb.jpeg'),
];
