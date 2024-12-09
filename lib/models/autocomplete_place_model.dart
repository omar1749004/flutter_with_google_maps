  class PlaceAutoComplete {
  final String description;
  final List<MatchedSubstring> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final List<String> types;

  PlaceAutoComplete({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

  factory PlaceAutoComplete.fromJson(Map<String, dynamic> json) {
    return PlaceAutoComplete(
      description: json['description'],
      matchedSubstrings: (json['matched_substrings'] as List).map((substring) => 
      MatchedSubstring.fromJson(substring)).toList(),
      placeId: json['place_id'],
      reference: json['reference'],
      structuredFormatting: StructuredFormatting.fromJson(json['structured_formatting']),
      terms: (json['terms'] as List).map((term) => Term.fromJson(term)).toList(),
      types: List<String>.from(json['types']), // may be list of dynamic not itarable 
    );
  }
}

class MatchedSubstring {
  final int length;
  final int offset;

  MatchedSubstring({required this.length, required this.offset});

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(
      length: json['length'],
      offset: json['offset'],
    );
  }
}

class StructuredFormatting {
  final String mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'],
      mainTextMatchedSubstrings: (json['main_text_matched_substrings'] as List)
          .map((substring) => MatchedSubstring.fromJson(substring))
          .toList(),
      secondaryText: json['secondary_text'],
    );
  }
}

class Term {
  final int offset;
  final String value;

  Term({required this.offset, required this.value});

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      offset: json['offset'],
      value: json['value'],
    );
  }
}