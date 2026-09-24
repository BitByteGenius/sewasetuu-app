/// Model representing expandable FAQ items
class ServiceFaqItem {
  final String id;
  final String question;
  final String answer;

  const ServiceFaqItem({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory ServiceFaqItem.fromJson(Map<String, dynamic> json) {
    return ServiceFaqItem(
      id: json['id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
      };
}
