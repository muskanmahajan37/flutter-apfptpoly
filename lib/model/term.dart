class Term {
  final int value;
  final String title;

  const Term(this.value, this.title);

  @override
  String toString() => "$value=$title";

  static List<Term> toList(String termString) {
    try {
      return termString
          .split(";")
          .map((termGroup) => termGroup.split("="))
          .toList()
          .map((termPair) => Term(int.parse(termPair[0]), termPair[1]))
          .toList();
    } catch (error) {
      return <Term>[];
    }
  }

  static String toListString(List<Term> terms) =>
      terms.map((term) => term.toString()).join(";") ?? "";
}
