class Term {
  final String key;
  final String value;

  Term(this.key, this.value);

  @override
  String toString() => "$key=$value";
}