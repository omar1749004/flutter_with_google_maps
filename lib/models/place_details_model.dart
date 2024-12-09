class PlaceDetailsModel {
  final String formattedAddress;
  final String formattedPhoneNumber;
  final String internationalPhoneNumber;
  final String name;
  final bool openNow;
  final double rating;
  final List<AddressComponent> addressComponents;
  final Geometry geometry;
  final List<Photo> photos;
  final List<Review> reviews;

  PlaceDetailsModel({
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.internationalPhoneNumber,
    required this.name,
    required this.openNow,
    required this.rating,
    required this.addressComponents,
    required this.geometry,
    required this.photos,
    required this.reviews,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      formattedAddress: json['formatted_address'] ?? '',
      formattedPhoneNumber: json['formatted_phone_number'] ?? '',
      internationalPhoneNumber: json['international_phone_number'] ?? '',
      name: json['name'] ?? '',
      openNow: json['opening_hours']?['open_now'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      addressComponents: (json['address_components'] as List)
          .map((e) => AddressComponent.fromJson(e))
          .toList(),
      geometry: Geometry.fromJson(json['geometry']),
      photos: (json['photos'] as List).map((e) => Photo.fromJson(e)).toList(),
      reviews: (json['reviews'] as List).map((e) => Review.fromJson(e)).toList(),
    );
  }
}

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name'] ?? '',
      shortName: json['short_name'] ?? '',
      types: List<String>.from(json['types'] ?? []),
    );
  }
}

class Geometry {
  final Location location;
  final Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
      viewport: Viewport.fromJson(json['viewport']),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }
}

class Photo {
  final String photoReference;
  final int height;
  final int width;
  final List<String> htmlAttributions;

  Photo({
    required this.photoReference,
    required this.height,
    required this.width,
    required this.htmlAttributions,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photoReference: json['photo_reference'] ?? '',
      height: json['height'] ?? 0,
      width: json['width'] ?? 0,
      htmlAttributions: List<String>.from(json['html_attributions'] ?? []),
    );
  }
}

class Review {
  final String authorName;
  final String authorUrl;
  final String language;
  final String profilePhotoUrl;
  final String text;
  final int time;
  final double rating;

  Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.profilePhotoUrl,
    required this.text,
    required this.time,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      authorName: json['author_name'] ?? '',
      authorUrl: json['author_url'] ?? '',
      language: json['language'] ?? '',
      profilePhotoUrl: json['profile_photo_url'] ?? '',
      text: json['text'] ?? '',
      time: json['time'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}
