class PantryGenericNameResponse {
  int pantryId;
  int genericNameId;
  int weightPerPiece;
  String name;
  String primaryUnit;

  PantryGenericNameResponse({
    this.pantryId = 0,
    this.genericNameId = 0,
    this.weightPerPiece = 0,
    this.name = '',
    this.primaryUnit = '',
  });
}
