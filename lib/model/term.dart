class Term {
  final int value;
  final String title;

  const Term(this.value, this.title);

  @override
  String toString() => "$value=$title";
}