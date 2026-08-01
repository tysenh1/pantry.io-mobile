enum GetRecipeSortOrder {
  nameAsc,
  nameDesc
}

final List<(GetRecipeSortOrder, String)> getRecipeSortOptions = [
  (GetRecipeSortOrder.nameAsc, 'A → Z'),
  (GetRecipeSortOrder.nameDesc, 'Z → A')
];