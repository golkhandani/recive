import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';

enum ArtItemSortBy {
  idAsc,
  idDesc,
  ;
}

extension ConvertToGql on ArtItemSortBy {
  GArt_itemSortByInput toGQL() {
    switch (this) {
      case ArtItemSortBy.idAsc:
        return GArt_itemSortByInput.G_ID_ASC;
      case ArtItemSortBy.idDesc:
        return GArt_itemSortByInput.G_ID_DESC;
      default:
        return GArt_itemSortByInput.G_ID_ASC;
    }
  }
}
