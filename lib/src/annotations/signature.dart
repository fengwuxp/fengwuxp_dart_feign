/// mark request need signature
class Signature {
  ///  need sign fields，need dictionary sorting
  final List<String> fields;

  const Signature({List<String>? fields}) : this.fields = fields ?? const [];
}
