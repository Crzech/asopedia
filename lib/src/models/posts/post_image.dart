// To parse this JSON data, do
//
//     final embedeData = embedeDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class EmbedeData {
    EmbedeData({
        @required this.wpFeaturedmedia,
    });

    List<WpFeaturedmedia> wpFeaturedmedia;

    factory EmbedeData.fromRawJson(String str) => EmbedeData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmbedeData.fromJson(Map<String, dynamic> json) => EmbedeData(
        wpFeaturedmedia:  json.containsKey('wp:featuredmedia') 
        ? List<WpFeaturedmedia>.from(json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x)))
        : []
    );

    Map<String, dynamic> toJson() => {
        "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
    };
}

class WpFeaturedmedia {
    WpFeaturedmedia({
        @required this.id,
        @required this.date,
        @required this.slug,
        @required this.type,
        @required this.link,
        @required this.author,
        @required this.altText,
        @required this.mediaType,
        @required this.mimeType,
        @required this.mediaDetails,
    });

    int id;
    DateTime date;
    String slug;
    String type;
    String link;
    int author;
    String altText;
    String mediaType;
    String mimeType;
    MediaDetails mediaDetails;

    factory WpFeaturedmedia.fromRawJson(String str) => WpFeaturedmedia.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) => WpFeaturedmedia(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        slug: json["slug"],
        type: json["type"],
        link: json["link"],
        author: json["author"],
        altText: json["alt_text"],
        mediaType: json["media_type"],
        mimeType: json["mime_type"],
        mediaDetails: MediaDetails.fromJson(json["media_details"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "slug": slug,
        "type": type,
        "link": link,
        "author": author,
        "alt_text": altText,
        "media_type": mediaType,
        "mime_type": mimeType,
        "media_details": mediaDetails.toJson(),
    };
}

class MediaDetails {
    MediaDetails({
        @required this.width,
        @required this.height,
        @required this.file,
        @required this.sizes,
    });

    int width;
    int height;
    String file;
    Sizes sizes;

    factory MediaDetails.fromRawJson(String str) => MediaDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
        width: json["width"],
        height: json["height"],
        file: json["file"],
        sizes: Sizes.fromJson(json["sizes"]),
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "file": file,
        "sizes": sizes.toJson(),
    };
}

class Sizes {
    Sizes({
        @required this.medium,
        @required this.large,
        @required this.thumbnail,
        @required this.mediumLarge,
        @required this.postThumbnail,
        @required this.full,
    });

    ImageProperties medium;
    ImageProperties large;
    ImageProperties thumbnail;
    ImageProperties mediumLarge;
    ImageProperties postThumbnail;
    ImageProperties full;

    factory Sizes.fromRawJson(String str) => Sizes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        medium: json.containsKey('medium') ? ImageProperties.fromJson(json["medium"]) : null,
        large: json.containsKey('large') ? ImageProperties.fromJson(json["large"]) : null,
        thumbnail: json.containsKey('thumbnail') ? ImageProperties.fromJson(json["thumbnail"]) : null,
        mediumLarge: json.containsKey('medium_large') ? ImageProperties.fromJson(json["medium_large"]) : null,
        postThumbnail: json.containsKey('postThumbnail') ? ImageProperties.fromJson(json["post-thumbnail"]) : null,
        full: json.containsKey('full') ? ImageProperties.fromJson(json["full"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "medium": medium.toJson(),
        "large": large.toJson(),
        "thumbnail": thumbnail.toJson(),
        "medium_large": mediumLarge.toJson(),
        "post-thumbnail": postThumbnail.toJson(),
        "full": full.toJson(),
    };
}

class ImageProperties {
    ImageProperties({
        @required this.file,
        @required this.width,
        @required this.height,
        @required this.mimeType,
        @required this.sourceUrl,
    });

    String file;
    int width;
    int height;
    String mimeType;
    String sourceUrl;

    factory ImageProperties.fromRawJson(String str) => ImageProperties.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ImageProperties.fromJson(Map<String, dynamic> json) => ImageProperties(
        file: json.containsKey('file') ?  json["file"] : null,
        width: json.containsKey('width') ?  json["width"] : null,
        height: json.containsKey('height') ?  json["height"] : null,
        mimeType: json.containsKey('mime_type') ?  json["mime_type"] : null,
        sourceUrl: json.containsKey('source_url') ?  json["source_url"] : null,
    );

    Map<String, dynamic> toJson() => {
        "file": file,
        "width": width,
        "height": height,
        "mime_type": mimeType,
        "source_url": sourceUrl,
    };
}
