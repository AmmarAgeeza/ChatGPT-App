class HomeModel {
  final String text;

  const HomeModel({required this.text});
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      HomeModel(text: json["candidates"][0]["content"]["parts"][0]["text"]);
}
