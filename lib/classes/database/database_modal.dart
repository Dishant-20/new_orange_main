class Planets {
  late final int id;
  late final String categoryId;
  late final String categoryName;
  late final String categoryImage;
  late final String timeStamp;
  late final String totalItem;

  Planets({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.timeStamp,
    required this.totalItem,
  });

  Planets.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        categoryId = result["categoryId"],
        categoryName = result["categoryName"],
        categoryImage = result["categoryImage"],
        timeStamp = result["timeStamp"],
        totalItem = result["totalItem"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'timeStamp': timeStamp,
      'totalItem': totalItem
    };
  }
}
