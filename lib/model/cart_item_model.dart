class CartItemModel {
  final int id;
  final String name;
  final String image;
  final double price;
  int count;
  CartItemModel(
      {required this.id,
      required this.image,
      required this.price,
      required this.name,
      required this.count});
}
