class BitcoinPrice {
  final double euro;
  final double usd;

  BitcoinPrice({required this.euro, required this.usd});

  factory BitcoinPrice.fromJson(Map<String, dynamic> json) {
    return BitcoinPrice(
      euro: json['EUR']["15m"],
      usd : json['USD']["15m"]
    );
  }
}