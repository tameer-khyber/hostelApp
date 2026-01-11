class PropertyModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final List<ReviewModel> reviews;
  final String description;
  final List<String> images;
  final List<String> amenities;
  final List<String> rules;
  final String ownerName;
  final String ownerContact;
  final double ownerRating;
  final double latitude;
  final double longitude;

  PropertyModel(
    this.name,
    this.location,
    this.price,
    this.rating,
    this.imageUrl,
    {
      String? id,
      this.isFavorite = false,
      this.reviews = const [],
      this.description = "No description provided.",
      this.images = const [],
      this.amenities = const [],
      this.rules = const [],
      this.ownerName = "Unknown",
      this.ownerContact = "",
      this.ownerRating = 0.0,
      this.latitude = 0.0,
      this.longitude = 0.0,
    }
  ) : id = id ?? (DateTime.now().millisecondsSinceEpoch.toString() + name.hashCode.toString());
}

class ReviewModel {
  final String authorName;
  final String date;
  final double rating;
  final String text;
  final String? profileImage;

  ReviewModel({
    required this.authorName,
    required this.date,
    required this.rating,
    required this.text,
    this.profileImage,
  });
}
