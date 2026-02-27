
class ChatSuggestionModel {
  final String imagePath, title;
  final List<String> suggestions;


  const ChatSuggestionModel({
    required this.imagePath,
    required this.title,
    required this.suggestions,
  });

  static List<ChatSuggestionModel> suggestionsList = [
    ChatSuggestionModel(
      imagePath: "assets/images/explain.png",
      title: "Explain",
      suggestions: [
        "Explain Quantum physics",
        "What are wormholes explain like i am 5",
      ],
    ),

    ChatSuggestionModel(
      imagePath: "assets/images/edit-2.png",
      title: "Write & edit",
      suggestions: [
        "Write a tweet about global warming",
        "Write a poem about flower and love",
        "Write a rap song lyrics about",
      ],
    ),
    ChatSuggestionModel(
      imagePath: "assets/images/translate.png",
      title: "Translate",
      suggestions: [
        "How do you say “how are you” in korean?",
        "Write a poem about flower and love",
      ],
    ),
  ];
}
