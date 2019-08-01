/// Get the enum from the string [value].
T enumFromString<T>(Iterable<T> enumValues, String value) {
  return enumValues.firstWhere(
    (type) =>
        type.toString().split(".").last.toLowerCase() == value.toLowerCase(),
    orElse: () => null,
  );
}

/// Get the string representation of the [enumValue].
String stringFromEnum<T>(T enumValue) {
  return enumValue.toString().split(".").last;
}
