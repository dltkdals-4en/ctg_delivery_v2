class AssetPortfolio {
  String? kind; //primary key
  String? asset;
  String? safety;
  double? percent;
  int? money;

  AssetPortfolio({
    this.kind,
    this.asset,
    this.safety,
    this.percent,
    this.money,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kind': kind,
      'asset': asset,
      'safety': safety,
      'percent': percent,
      'money': money,
    };
  }
}