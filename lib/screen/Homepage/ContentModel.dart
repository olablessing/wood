class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(title: 'All Your Favourites', image: 'assets/images/Illustrations.png', discription: "Order from Wood Café with easy, on-demand delivery."),
  UnbordingContent(title: 'Free delivery offers', image: 'assets/images/Illustrations1.png', discription: "Free delivery for new customers via Apple Pay and others payment methods."),
  UnbordingContent(title: 'Choose your food', image: 'assets/images/Illustrations2.png', discription: "Easily find your type of food craving and you’ll get delivery in wide range."),
];
