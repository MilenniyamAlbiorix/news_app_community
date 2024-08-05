import 'dart:convert';

class TopHeadlines {
  final String? status;
  final String? requestId;
  final List<Datum>? data;

  TopHeadlines({
    this.status,
    this.requestId,
    this.data,
  });



  factory TopHeadlines.fromJson(Map<String, dynamic> json) => TopHeadlines(
    status: json["status"],
    requestId: json["request_id"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "request_id": requestId,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? title;
  final String? link;
  final String? snippet;
  final String? photoUrl;
  final DateTime? publishedDatetimeUtc;
  final String? sourceUrl;
  final String? sourceName;
  final String? sourceLogoUrl;
  final String? sourceFaviconUrl;
  final List<SubArticle>? subArticles;
  final String? storyId;

  Datum({
    this.title,
    this.link,
    this.snippet,
    this.photoUrl,
    this.publishedDatetimeUtc,
    this.sourceUrl,
    this.sourceName,
    this.sourceLogoUrl,
    this.sourceFaviconUrl,
    this.subArticles,
    this.storyId,
  });


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    link: json["link"],
    snippet: json["snippet"],
    photoUrl: json["photo_url"],
    publishedDatetimeUtc: json["published_datetime_utc"] == null ? null : DateTime.parse(json["published_datetime_utc"]),
    sourceUrl: json["source_url"],
    sourceName: json["source_name"] ?? "",
    sourceLogoUrl: json["source_logo_url"] ?? "",
    sourceFaviconUrl: json["source_favicon_url"] ?? "" ,
    subArticles: json["sub_articles"] == null ? [] : List<SubArticle>.from(json["sub_articles"]!.map((x) => SubArticle.fromJson(x))),
    storyId: json["story_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "snippet": snippet,
    "photo_url": photoUrl,
    "published_datetime_utc": publishedDatetimeUtc?.toIso8601String(),
    "source_url": sourceUrl ?? "",
    "source_name": sourceName ?? "",
    "source_logo_url": sourceLogoUrl ?? "",
    "source_favicon_url": sourceFaviconUrl ?? "",
    "sub_articles": subArticles == null ? [] : List<dynamic>.from(subArticles!.map((x) => x.toJson())),
    "story_id": storyId,
  };
}

class SubArticle {
  final String? title;
  final String? link;
  final String? photoUrl;
  final DateTime? publishedDatetimeUtc;
  final String? sourceUrl;
  final String? sourceLogoUrl;
  final String? sourceFaviconUrl;

  SubArticle({
    this.title,
    this.link,
    this.photoUrl,
    this.publishedDatetimeUtc,
    this.sourceUrl,
    this.sourceLogoUrl,
    this.sourceFaviconUrl,
  });

  factory SubArticle.fromRawJson(String str) => SubArticle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubArticle.fromJson(Map<String, dynamic> json) => SubArticle(
    title: json["title"],
    link: json["link"],
    photoUrl: json["photo_url"],
    publishedDatetimeUtc: json["published_datetime_utc"] == null ? null : DateTime.parse(json["published_datetime_utc"]),
    sourceUrl: json["source_url"],
    sourceLogoUrl: json["source_logo_url"],
    sourceFaviconUrl: json["source_favicon_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "photo_url": photoUrl,
    "published_datetime_utc": publishedDatetimeUtc?.toIso8601String(),
    "source_url": sourceUrl,
    "source_logo_url": sourceLogoUrl,
    "source_favicon_url": sourceFaviconUrl,
  };
}
