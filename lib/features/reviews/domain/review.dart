/// Product review data
class Review {
  const Review({
    required this.score,
    required this.comment,
    required this.date,
  });
  final double score; // from 1 to 5
  final String comment;
  final DateTime date;

  @override
  String toString() =>
      '''Review(score: $score, comment: $comment, date: $date)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.score == score &&
        other.comment == comment &&
        other.date == date;
  }

  @override
  int get hashCode => score.hashCode ^ comment.hashCode ^ date.hashCode;
}
