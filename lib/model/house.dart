class House {
  String name;
  String address;
  String imageUrl;

  House(this.name, this.address, this.imageUrl);

  static List<House> generateRecommended() {
    return [
      House('The Moon House', 'A55, Bali, Indonesia',
          'assets/images/house01.jpeg'),
      House('The Star House', 'A55, Bali, Indonesia',
          'assets/images/house02.jpeg'),
    ];
  }

  static List<House> generateBestOffer() {
    return [
      House('The Moon Haouse', 'A55, Bali, Indonesia',
          'assets/images/offer1.jpeg'),
      House('The Moon Haouse', 'A55, Bali, Indonesia',
          'assets/images/offer2.jpeg'),
    ];
  }
}
