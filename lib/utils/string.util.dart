String replaceLastChar(String originalString, String newLastChar) {
  return originalString.isEmpty
      ? originalString
      : originalString.replaceRange(originalString.length - 1, originalString.length, newLastChar);
}