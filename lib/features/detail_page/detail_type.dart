enum DetailType {
  news,
  event,
  place,
  category,
  unknown,
  ;

  static DetailType fromString(String str) {
    switch (str) {
      case 'news':
        return DetailType.news;
      case 'event':
        return DetailType.event;
      case 'place':
        return DetailType.place;
      case 'category':
        return DetailType.category;
      default:
        return DetailType.unknown;
    }
  }
}
