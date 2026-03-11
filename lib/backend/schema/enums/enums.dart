import 'package:collection/collection.dart';

enum Category {
  amour,
  paix,
  confiance,
  anxiete,
  stress,
  general,
  motivation,
  opti,
  philosophie,
  soir,
  sarca,
  detend,
}

enum Soujets {
  confiance,
  amour,
  motivation,
  objectif,
  reussite,
  relation,
  positif,
  serein,
  apaisement,
  ambition,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (Category):
      return Category.values.deserialize(value) as T?;
    case (Soujets):
      return Soujets.values.deserialize(value) as T?;
    default:
      return null;
  }
}
