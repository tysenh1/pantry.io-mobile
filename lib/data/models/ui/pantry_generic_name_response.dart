class PantryGenericNameResponse {
  String pantryId;
  String genericNameId;
  int weightPerPiece;
  String name;
  String primaryUnit;

  PantryGenericNameResponse({
    this.pantryId = '',
    this.genericNameId = '',
    this.weightPerPiece = 0,
    this.name = '',
    this.primaryUnit = '',
  });
}
