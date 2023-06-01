// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(
    json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  Flags flags;
  Name name;
  Map<String, Currency> currencies;
  List<String> capital;

  CountryModel({
    required this.flags,
    required this.name,
    required this.currencies,
    required this.capital,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        flags: Flags.fromJson(json["flags"]),
        name: Name.fromJson(json["name"]),
        currencies: Map.from(json["currencies"])
            .map((k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))),
        capital: List<String>.from(json["capital"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "flags": flags.toJson(),
        "name": name.toJson(),
        "currencies": Map.from(currencies)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "capital": List<dynamic>.from(capital.map((x) => x)),
      };
}

class Currency {
  String name;
  String symbol;

  Currency({
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Flags {
  String png;
  String svg;
  String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
        "alt": alt,
      };
}

class Name {
  String common;
  String official;
  Map<String, NativeName> nativeName;

  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
        nativeName: Map.from(json["nativeName"]).map(
            (k, v) => MapEntry<String, NativeName>(k, NativeName.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
        "nativeName": Map.from(nativeName)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class NativeName {
  String official;
  String common;

  NativeName({
    required this.official,
    required this.common,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) => NativeName(
        official: json["official"],
        common: json["common"],
      );

  Map<String, dynamic> toJson() => {
        "official": official,
        "common": common,
      };
}
