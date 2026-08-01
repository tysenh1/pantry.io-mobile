import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';

Future<void> seedAllData(AppDatabase db) async {
  await db.transaction(() async {
    // --- 1. SEED GENERIC NAMES ---
    final List<Map<String, dynamic>> genericNamesData = [
      // PROTEINS (IDs 1-24)
      {'id': 1, 'name': 'Chicken', 'unit': 'g', 'weight': 200.0},
      {'id': 2, 'name': 'Beef', 'unit': 'g', 'weight': 500.0},
      {'id': 3, 'name': 'Pork', 'unit': 'g', 'weight': 200.0},
      {'id': 4, 'name': 'Steak', 'unit': 'g', 'weight': 250.0},
      {'id': 5, 'name': 'Lamb', 'unit': 'g', 'weight': 250.0},
      {'id': 6, 'name': 'Turkey', 'unit': 'g', 'weight': 5000.0},
      {'id': 7, 'name': 'Duck', 'unit': 'g', 'weight': 2000.0},
      {'id': 8, 'name': 'Venison', 'unit': 'g', 'weight': 250.0},
      {'id': 9, 'name': 'Bacon', 'unit': 'g', 'weight': 25.0},
      {'id': 10, 'name': 'Sausage', 'unit': 'g', 'weight': 75.0},
      {'id': 11, 'name': 'Ham', 'unit': 'g', 'weight': 500.0},
      {'id': 12, 'name': 'Deli Meat', 'unit': 'g', 'weight': 1.0},
      {'id': 13, 'name': 'Salmon', 'unit': 'g', 'weight': 150.0},
      {'id': 14, 'name': 'White Fish', 'unit': 'g', 'weight': 150.0},
      {'id': 15, 'name': 'Tuna', 'unit': 'g', 'weight': 170.0},
      {'id': 16, 'name': 'Shrimp', 'unit': 'g', 'weight': 15.0},
      {'id': 17, 'name': 'Scallops', 'unit': 'g', 'weight': 30.0},
      {'id': 18, 'name': 'Mussels', 'unit': 'g', 'weight': 20.0},
      {'id': 19, 'name': 'Crab', 'unit': 'g', 'weight': 100.0},
      {'id': 20, 'name': 'Lobster', 'unit': 'g', 'weight': 500.0},
      {'id': 21, 'name': 'Egg', 'unit': 'g', 'weight': 50.0},
      {'id': 22, 'name': 'Tofu', 'unit': 'g', 'weight': 400.0},
      {'id': 23, 'name': 'Tempeh', 'unit': 'g', 'weight': 225.0},
      {'id': 24, 'name': 'Seitan', 'unit': 'g', 'weight': 225.0},

      // DAIRY & ALTERNATIVES (IDs 25-44)
      {'id': 25, 'name': 'Milk', 'unit': 'ml', 'weight': 1.0},
      {'id': 26, 'name': 'Heavy Cream', 'unit': 'ml', 'weight': 1.0},
      {'id': 27, 'name': 'Sour Cream', 'unit': 'g', 'weight': 1.0},
      {'id': 28, 'name': 'Yogurt', 'unit': 'g', 'weight': 170.0},
      {'id': 29, 'name': 'Butter', 'unit': 'g', 'weight': 227.0},
      {'id': 30, 'name': 'Ghee', 'unit': 'g', 'weight': 1.0},
      {'id': 31, 'name': 'Margarine', 'unit': 'g', 'weight': 1.0},
      {'id': 32, 'name': 'Cream Cheese', 'unit': 'g', 'weight': 226.0},
      {'id': 33, 'name': 'Cheddar Cheese', 'unit': 'g', 'weight': 28.0},
      {'id': 34, 'name': 'Mozzarella Cheese', 'unit': 'g', 'weight': 28.0},
      {'id': 35, 'name': 'Parmesan Cheese', 'unit': 'g', 'weight': 1.0},
      {'id': 36, 'name': 'Feta Cheese', 'unit': 'g', 'weight': 1.0},
      {'id': 37, 'name': 'Goat Cheese', 'unit': 'g', 'weight': 1.0},
      {'id': 38, 'name': 'Ricotta Cheese', 'unit': 'g', 'weight': 1.0},
      {'id': 39, 'name': 'Swiss Cheese', 'unit': 'g', 'weight': 28.0},
      {'id': 40, 'name': 'Cottage Cheese', 'unit': 'g', 'weight': 1.0},
      {'id': 41, 'name': 'Almond Milk', 'unit': 'ml', 'weight': 1.0},
      {'id': 42, 'name': 'Soy Milk', 'unit': 'ml', 'weight': 1.0},
      {'id': 43, 'name': 'Oat Milk', 'unit': 'ml', 'weight': 1.0},
      {'id': 44, 'name': 'Coconut Milk', 'unit': 'ml', 'weight': 400.0},

      // VEGETABLES (IDs 45-82)
      {'id': 45, 'name': 'Onion', 'unit': 'g', 'weight': 150.0},
      {'id': 46, 'name': 'Garlic', 'unit': 'g', 'weight': 50.0},
      {'id': 47, 'name': 'Shallot', 'unit': 'g', 'weight': 25.0},
      {'id': 48, 'name': 'Scallion', 'unit': 'g', 'weight': 15.0},
      {'id': 49, 'name': 'Potato', 'unit': 'g', 'weight': 200.0},
      {'id': 50, 'name': 'Sweet Potato', 'unit': 'g', 'weight': 300.0},
      {'id': 51, 'name': 'Carrot', 'unit': 'g', 'weight': 60.0},
      {'id': 52, 'name': 'Celery', 'unit': 'g', 'weight': 450.0},
      {'id': 53, 'name': 'Broccoli', 'unit': 'g', 'weight': 300.0},
      {'id': 54, 'name': 'Cauliflower', 'unit': 'g', 'weight': 600.0},
      {'id': 55, 'name': 'Cabbage', 'unit': 'g', 'weight': 900.0},
      {'id': 56, 'name': 'Bok Choy', 'unit': 'g', 'weight': 200.0},
      {'id': 57, 'name': 'Spinach', 'unit': 'g', 'weight': 1.0},
      {'id': 58, 'name': 'Kale', 'unit': 'g', 'weight': 1.0},
      {'id': 59, 'name': 'Lettuce', 'unit': 'g', 'weight': 400.0},
      {'id': 60, 'name': 'Arugula', 'unit': 'g', 'weight': 1.0},
      {'id': 61, 'name': 'Bell Pepper', 'unit': 'g', 'weight': 150.0},
      {'id': 62, 'name': 'Chili Pepper', 'unit': 'g', 'weight': 15.0},
      {'id': 63, 'name': 'Jalapeno', 'unit': 'g', 'weight': 15.0},
      {'id': 64, 'name': 'Tomato', 'unit': 'g', 'weight': 120.0},
      {'id': 65, 'name': 'Cherry Tomato', 'unit': 'g', 'weight': 15.0},
      {'id': 66, 'name': 'Cucumber', 'unit': 'g', 'weight': 250.0},
      {'id': 67, 'name': 'Zucchini', 'unit': 'g', 'weight': 200.0},
      {'id': 68, 'name': 'Eggplant', 'unit': 'g', 'weight': 450.0},
      {'id': 69, 'name': 'Asparagus', 'unit': 'g', 'weight': 20.0},
      {'id': 70, 'name': 'Green Beans', 'unit': 'g', 'weight': 1.0},
      {'id': 71, 'name': 'Peas', 'unit': 'g', 'weight': 1.0},
      {'id': 72, 'name': 'Corn', 'unit': 'g', 'weight': 200.0},
      {'id': 73, 'name': 'Mushroom', 'unit': 'g', 'weight': 15.0},
      {'id': 74, 'name': 'Radish', 'unit': 'g', 'weight': 20.0},
      {'id': 75, 'name': 'Beet', 'unit': 'g', 'weight': 150.0},
      {'id': 76, 'name': 'Turnip', 'unit': 'g', 'weight': 200.0},
      {'id': 77, 'name': 'Parsnip', 'unit': 'g', 'weight': 120.0},
      {'id': 78, 'name': 'Fennel', 'unit': 'g', 'weight': 250.0},
      {'id': 79, 'name': 'Artichoke', 'unit': 'g', 'weight': 300.0},
      {'id': 80, 'name': 'Brussels Sprout', 'unit': 'g', 'weight': 20.0},
      {'id': 81, 'name': 'Leek', 'unit': 'g', 'weight': 200.0},
      {'id': 82, 'name': 'Ginger', 'unit': 'g', 'weight': 1.0},

      // FRUIT (IDs 83-105)
      {'id': 83, 'name': 'Apple', 'unit': 'g', 'weight': 150.0},
      {'id': 84, 'name': 'Banana', 'unit': 'g', 'weight': 120.0},
      {'id': 85, 'name': 'Orange', 'unit': 'g', 'weight': 130.0},
      {'id': 86, 'name': 'Lemon', 'unit': 'g', 'weight': 60.0},
      {'id': 87, 'name': 'Lime', 'unit': 'g', 'weight': 40.0},
      {'id': 88, 'name': 'Grapefruit', 'unit': 'g', 'weight': 300.0},
      {'id': 89, 'name': 'Strawberry', 'unit': 'g', 'weight': 12.0},
      {'id': 90, 'name': 'Blueberry', 'unit': 'g', 'weight': 1.0},
      {'id': 91, 'name': 'Raspberry', 'unit': 'g', 'weight': 1.0},
      {'id': 92, 'name': 'Blackberry', 'unit': 'g', 'weight': 1.0},
      {'id': 93, 'name': 'Grape', 'unit': 'g', 'weight': 5.0},
      {'id': 94, 'name': 'Watermelon', 'unit': 'g', 'weight': 5000.0},
      {'id': 95, 'name': 'Cantaloupe', 'unit': 'g', 'weight': 1500.0},
      {'id': 96, 'name': 'Pineapple', 'unit': 'g', 'weight': 900.0},
      {'id': 97, 'name': 'Mango', 'unit': 'g', 'weight': 200.0},
      {'id': 98, 'name': 'Peach', 'unit': 'g', 'weight': 150.0},
      {'id': 99, 'name': 'Pear', 'unit': 'g', 'weight': 180.0},
      {'id': 100, 'name': 'Plum', 'unit': 'g', 'weight': 65.0},
      {'id': 101, 'name': 'Cherry', 'unit': 'g', 'weight': 8.0},
      {'id': 102, 'name': 'Kiwi', 'unit': 'g', 'weight': 70.0},
      {'id': 103, 'name': 'Avocado', 'unit': 'g', 'weight': 200.0},
      {'id': 104, 'name': 'Pomegranate', 'unit': 'g', 'weight': 280.0},
      {'id': 105, 'name': 'Coconut', 'unit': 'g', 'weight': 400.0},

      // GRAINS, PASTA & BREAD (IDs 106-124)
      {'id': 106, 'name': 'White Rice', 'unit': 'g', 'weight': 1.0},
      {'id': 107, 'name': 'Brown Rice', 'unit': 'g', 'weight': 1.0},
      {'id': 108, 'name': 'Quinoa', 'unit': 'g', 'weight': 1.0},
      {'id': 109, 'name': 'Couscous', 'unit': 'g', 'weight': 1.0},
      {'id': 110, 'name': 'Barley', 'unit': 'g', 'weight': 1.0},
      {'id': 111, 'name': 'Oats', 'unit': 'g', 'weight': 1.0},
      {'id': 112, 'name': 'Flour', 'unit': 'g', 'weight': 1.0},
      {'id': 113, 'name': 'Cornmeal', 'unit': 'g', 'weight': 1.0},
      {'id': 114, 'name': 'Spaghetti', 'unit': 'g', 'weight': 1.0},
      {'id': 115, 'name': 'Short Pasta', 'unit': 'g', 'weight': 1.0},
      {'id': 116, 'name': 'Lasagna Noodle', 'unit': 'g', 'weight': 20.0},
      {'id': 117, 'name': 'Egg Noodle', 'unit': 'g', 'weight': 1.0},
      {'id': 118, 'name': 'Rice Noodle', 'unit': 'g', 'weight': 1.0},
      {'id': 119, 'name': 'Bread', 'unit': 'g', 'weight': 30.0},
      {'id': 120, 'name': 'Bun', 'unit': 'g', 'weight': 50.0},
      {'id': 121, 'name': 'Bagel', 'unit': 'g', 'weight': 100.0},
      {'id': 122, 'name': 'Tortilla', 'unit': 'g', 'weight': 45.0},
      {'id': 123, 'name': 'Pita', 'unit': 'g', 'weight': 60.0},
      {'id': 124, 'name': 'Breadcrumbs', 'unit': 'g', 'weight': 1.0},

      // BAKING & SWEETENERS (IDs 125-138)
      {'id': 125, 'name': 'Sugar', 'unit': 'g', 'weight': 1.0},
      {'id': 126, 'name': 'Brown Sugar', 'unit': 'g', 'weight': 1.0},
      {'id': 127, 'name': 'Powdered Sugar', 'unit': 'g', 'weight': 1.0},
      {'id': 128, 'name': 'Honey', 'unit': 'g', 'weight': 1.0},
      {'id': 129, 'name': 'Maple Syrup', 'unit': 'ml', 'weight': 1.0},
      {'id': 130, 'name': 'Molasses', 'unit': 'ml', 'weight': 1.0},
      {'id': 131, 'name': 'Vanilla Extract', 'unit': 'ml', 'weight': 1.0},
      {'id': 132, 'name': 'Yeast', 'unit': 'g', 'weight': 7.0},
      {'id': 133, 'name': 'Baking Powder', 'unit': 'g', 'weight': 1.0},
      {'id': 134, 'name': 'Baking Soda', 'unit': 'g', 'weight': 1.0},
      {'id': 135, 'name': 'Cocoa Powder', 'unit': 'g', 'weight': 1.0},
      {'id': 136, 'name': 'Chocolate', 'unit': 'g', 'weight': 1.0},
      {'id': 137, 'name': 'Chocolate Chips', 'unit': 'g', 'weight': 1.0},
      {'id': 138, 'name': 'Cornstarch', 'unit': 'g', 'weight': 1.0},

      // OILS & VINEGARS (IDs 139-147)
      {'id': 139, 'name': 'Olive Oil', 'unit': 'ml', 'weight': 1.0},
      {'id': 140, 'name': 'Vegetable Oil', 'unit': 'ml', 'weight': 1.0},
      {'id': 141, 'name': 'Coconut Oil', 'unit': 'ml', 'weight': 1.0},
      {'id': 142, 'name': 'Sesame Oil', 'unit': 'ml', 'weight': 1.0},
      {'id': 143, 'name': 'Balsamic Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'id': 144, 'name': 'Apple Cider Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'id': 145, 'name': 'White Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'id': 146, 'name': 'Rice Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'id': 147, 'name': 'Red Wine Vinegar', 'unit': 'ml', 'weight': 1.0},

      // CONDIMENTS & SAUCES (IDs 148-165)
      {'id': 148, 'name': 'Ketchup', 'unit': 'g', 'weight': 1.0},
      {'id': 149, 'name': 'Mustard', 'unit': 'g', 'weight': 1.0},
      {'id': 150, 'name': 'Mayonnaise', 'unit': 'g', 'weight': 1.0},
      {'id': 151, 'name': 'Soy Sauce', 'unit': 'ml', 'weight': 1.0},
      {'id': 152, 'name': 'Fish Sauce', 'unit': 'ml', 'weight': 1.0},
      {'id': 153, 'name': 'Oyster Sauce', 'unit': 'ml', 'weight': 1.0},
      {'id': 154, 'name': 'Hot Sauce', 'unit': 'ml', 'weight': 1.0},
      {'id': 155, 'name': 'Sriracha', 'unit': 'ml', 'weight': 1.0},
      {'id': 156, 'name': 'BBQ Sauce', 'unit': 'g', 'weight': 1.0},
      {'id': 157, 'name': 'Worcestershire', 'unit': 'ml', 'weight': 1.0},
      {'id': 158, 'name': 'Tahini', 'unit': 'g', 'weight': 1.0},
      {'id': 159, 'name': 'Miso', 'unit': 'g', 'weight': 1.0},
      {'id': 160, 'name': 'Pesto', 'unit': 'g', 'weight': 1.0},
      {'id': 161, 'name': 'Tomato Sauce', 'unit': 'ml', 'weight': 1.0},
      {'id': 162, 'name': 'Salsa', 'unit': 'g', 'weight': 1.0},
      {'id': 163, 'name': 'Peanut Butter', 'unit': 'g', 'weight': 1.0},
      {'id': 164, 'name': 'Almond Butter', 'unit': 'g', 'weight': 1.0},
      {'id': 165, 'name': 'Jam', 'unit': 'g', 'weight': 1.0},

      // CANNED & DRY LEGUMES (IDs 166-171)
      {'id': 166, 'name': 'Chickpeas', 'unit': 'g', 'weight': 425.0},
      {'id': 167, 'name': 'Black Beans', 'unit': 'g', 'weight': 425.0},
      {'id': 168, 'name': 'Kidney Beans', 'unit': 'g', 'weight': 425.0},
      {'id': 169, 'name': 'Pinto Beans', 'unit': 'g', 'weight': 425.0},
      {'id': 170, 'name': 'Lentils', 'unit': 'g', 'weight': 1.0},
      {'id': 171, 'name': 'Broth', 'unit': 'ml', 'weight': 1.0},

      // SPICES & HERBS (IDs 172-190)
      {'id': 172, 'name': 'Salt', 'unit': 'g', 'weight': 1.0},
      {'id': 173, 'name': 'Black Pepper', 'unit': 'g', 'weight': 1.0},
      {'id': 174, 'name': 'Cumin', 'unit': 'g', 'weight': 1.0},
      {'id': 175, 'name': 'Paprika', 'unit': 'g', 'weight': 1.0},
      {'id': 176, 'name': 'Smoked Paprika', 'unit': 'g', 'weight': 1.0},
      {'id': 177, 'name': 'Cinnamon', 'unit': 'g', 'weight': 1.0},
      {'id': 178, 'name': 'Chili Powder', 'unit': 'g', 'weight': 1.0},
      {'id': 179, 'name': 'Turmeric', 'unit': 'g', 'weight': 1.0},
      {'id': 180, 'name': 'Coriander', 'unit': 'g', 'weight': 1.0},
      {'id': 181, 'name': 'Cardamom', 'unit': 'g', 'weight': 1.0},
      {'id': 182, 'name': 'Nutmeg', 'unit': 'g', 'weight': 1.0},
      {'id': 183, 'name': 'Oregano', 'unit': 'g', 'weight': 1.0},
      {'id': 184, 'name': 'Basil', 'unit': 'g', 'weight': 1.0},
      {'id': 185, 'name': 'Thyme', 'unit': 'g', 'weight': 1.0},
      {'id': 186, 'name': 'Rosemary', 'unit': 'g', 'weight': 1.0},
      {'id': 187, 'name': 'Parsley', 'unit': 'g', 'weight': 1.0},
      {'id': 188, 'name': 'Cilantro', 'unit': 'g', 'weight': 1.0},
      {'id': 189, 'name': 'Dill', 'unit': 'g', 'weight': 1.0},
      {'id': 190, 'name': 'Bay Leaf', 'unit': 'g', 'weight': 1.0},
    ];

    // --- 2. SEED PANTRY ITEMS ---
    final List<Map<String, dynamic>> pantrySeed = [
      {'id': 1, 'name': 'Chicken Breast', 'qty': 1000.0, 'unit': 'g', 'staple': false, 'genericNameId': 1, 'weightPerPiece': null},
      {'id': 2, 'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g', 'staple': false, 'genericNameId': 2, 'weightPerPiece': null},
      {'id': 3, 'name': 'Eggs', 'qty': 600.0, 'unit': 'g', 'staple': true, 'genericNameId': 21, 'weightPerPiece': 50.0}, // 12 pcs * 50g
      {'id': 4, 'name': 'Salmon Fillet', 'qty': 300.0, 'unit': 'g', 'staple': false, 'genericNameId': 13, 'weightPerPiece': null},
      {'id': 5, 'name': 'Shrimp', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 16, 'weightPerPiece': null},
      {'id': 6, 'name': 'Spaghetti', 'qty': 500.0, 'unit': 'g', 'staple': true, 'genericNameId': 114, 'weightPerPiece': null},
      {'id': 7, 'name': 'White Rice', 'qty': 2000.0, 'unit': 'g', 'staple': true, 'genericNameId': 106, 'weightPerPiece': null},
      {'id': 8, 'name': 'Tortillas', 'qty': 360.0, 'unit': 'g', 'staple': false, 'genericNameId': 122, 'weightPerPiece': 45.0}, // 8 pcs * 45g
      {'id': 9, 'name': 'Brown Rice', 'qty': 1000.0, 'unit': 'g', 'staple': true, 'genericNameId': 107, 'weightPerPiece': null},
      {'id': 10, 'name': 'Bread Slices', 'qty': 700.0, 'unit': 'g', 'staple': true, 'genericNameId': 119, 'weightPerPiece': 35.0}, // 20 pcs * 35g
      {'id': 11, 'name': 'Lasagna Noodles', 'qty': 400.0, 'unit': 'g', 'staple': false, 'genericNameId': 116, 'weightPerPiece': null},
      {'id': 12, 'name': 'Garlic', 'qty': 25.0, 'unit': 'g', 'staple': true, 'genericNameId': 46, 'weightPerPiece': 5.0}, // 5 cloves * 5g
      {'id': 13, 'name': 'Onion', 'qty': 300.0, 'unit': 'g', 'staple': true, 'genericNameId': 45, 'weightPerPiece': 150.0}, // 2 pcs * 150g
      {'id': 14, 'name': 'Bell Peppers', 'qty': 450.0, 'unit': 'g', 'staple': false, 'genericNameId': 61, 'weightPerPiece': 150.0}, // 3 pcs * 150g
      {'id': 15, 'name': 'Broccoli', 'qty': 350.0, 'unit': 'g', 'staple': false, 'genericNameId': 53, 'weightPerPiece': 350.0}, // 1 head * 350g
      {'id': 16, 'name': 'Spinach', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 57, 'weightPerPiece': null},
      {'id': 17, 'name': 'Carrots', 'qty': 300.0, 'unit': 'g', 'staple': true, 'genericNameId': 51, 'weightPerPiece': 60.0}, // 5 pcs * 60g
      {'id': 18, 'name': 'Tomatoes', 'qty': 720.0, 'unit': 'g', 'staple': false, 'genericNameId': 64, 'weightPerPiece': 120.0}, // 6 pcs * 120g
      {'id': 19, 'name': 'Mushrooms', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 73, 'weightPerPiece': null},
      {'id': 20, 'name': 'Zucchini', 'qty': 600.0, 'unit': 'g', 'staple': false, 'genericNameId': 67, 'weightPerPiece': 200.0}, // 3 pcs * 200g
      {'id': 21, 'name': 'Olive Oil', 'qty': 1000.0, 'unit': 'ml', 'staple': true, 'genericNameId': 139, 'weightPerPiece': null},
      {'id': 22, 'name': 'Soy Sauce', 'qty': 250.0, 'unit': 'ml', 'staple': true, 'genericNameId': 151, 'weightPerPiece': null},
      {'id': 23, 'name': 'Butter', 'qty': 250.0, 'unit': 'g', 'staple': true, 'genericNameId': 29, 'weightPerPiece': null},
      {'id': 24, 'name': 'Cheddar Cheese', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 33, 'weightPerPiece': null},
      {'id': 25, 'name': 'Milk', 'qty': 2000.0, 'unit': 'ml', 'staple': true, 'genericNameId': 25, 'weightPerPiece': null},
      {'id': 26, 'name': 'Flour', 'qty': 2000.0, 'unit': 'g', 'staple': true, 'genericNameId': 112, 'weightPerPiece': null},
      {'id': 27, 'name': 'Sugar', 'qty': 1000.0, 'unit': 'g', 'staple': true, 'genericNameId': 125, 'weightPerPiece': null},
      {'id': 28, 'name': 'Honey', 'qty': 500.0, 'unit': 'g', 'staple': true, 'genericNameId': 128, 'weightPerPiece': null},
      {'id': 29, 'name': 'Tomato Sauce', 'qty': 800.0, 'unit': 'ml', 'staple': true, 'genericNameId': 161, 'weightPerPiece': null},
      {'id': 30, 'name': 'Coconut Milk', 'qty': 0.0, 'unit': 'ml', 'staple': false, 'genericNameId': 44, 'weightPerPiece': null},
      {'id': 31, 'name': 'Beef Steak', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 4, 'weightPerPiece': null},
      {'id': 32, 'name': 'Mozzarella Cheese', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 34, 'weightPerPiece': null},
      {'id': 33, 'name': 'Baking Powder', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 133, 'weightPerPiece': null},
      {'id': 34, 'name': 'Avocado', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 103, 'weightPerPiece': 150.0},
      {'id': 35, 'name': 'Peanut Butter', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 163, 'weightPerPiece': null},
      {'id': 36, 'name': 'Lime', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 87, 'weightPerPiece': 60.0},
      {'id': 37, 'name': 'Bun', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 120, 'weightPerPiece': 50.0},
      {'id': 38, 'name': 'Chocolate Snacks', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 136, 'weightPerPiece': null},
    ];

    // --- 3. SEED RECIPES ---
    final List<Map<String, dynamic>> recipesSeed = [
      {
        'id': 1,
        'name': 'Garlic Butter Chicken',
        'tags': ['Quick', 'High Protein', 'Low Carb'],
        'instr': '1. Dice chicken. 2. Sauté garlic in butter/oil. 3. Cook chicken until golden.',
        'ings': [
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 12, 'name': 'Garlic', 'qty': 3.0, 'unit': 'clove'}, // 3 cloves = 15g
          {'pantryId': 23, 'name': 'Butter', 'qty': 2.0, 'unit': 'tbsp'}, // 2 tbsp ~ 28.4g
          {'pantryId': 21, 'name': 'Olive Oil', 'qty': 2.5, 'unit': 'tbsp', 'optional': true}, // 2.5 tbsp ~ 33.8ml
        ],
      },
      {
        'id': 2,
        'name': 'Beef Tacos',
        'tags': ['Mexican', 'Family Style', 'Quick'],
        'instr': '1. Brown beef with onions. 2. Warm tortillas. 3. Assemble with cheese.',
        'ings': [
          {'pantryId': 2, 'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 8, 'name': 'Tortillas', 'qty': 4.0, 'unit': 'pcs'}, // 4 pcs = 180g
          {'pantryId': 13, 'name': 'Onion', 'qty': 0.5, 'unit': 'pcs'}, // 0.5 pcs = 75g
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 1.0, 'unit': 'cup', 'optional': true}, // 1 cup = 113g
        ],
      },
      {
        'id': 3,
        'name': 'Chicken & Broccoli Stir Fry',
        'tags': ['Asian', 'Healthy', 'One-Pan'],
        'instr': '1. Slice chicken and broccoli. 2. Stir fry. 3. Add soy sauce.',
        'ings': [
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 400.0, 'unit': 'g'},
          {'pantryId': 15, 'name': 'Broccoli', 'qty': 1.0, 'unit': 'head'}, // Fixed from pcs -> head (300g)
          {'pantryId': 22, 'name': 'Soy Sauce', 'qty': 3.0, 'unit': 'tbsp'}, // 3 tbsp = 48ml
          {'pantryId': 7, 'name': 'White Rice', 'qty': 1.0, 'unit': 'cup', 'optional': true}, // 1 cup ~ 185g
        ],
      },
      {
        'id': 4,
        'name': 'Red Chicken Curry',
        'tags': ['Spicy', 'Thai', 'Hearty'],
        'instr': '1. Simmer paste with coconut milk. 2. Add chicken and peppers.',
        'ings': [
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 30, 'name': 'Coconut Milk', 'qty': 1.0, 'unit': 'can'}, // 1 can = 400ml
          {'pantryId': 14, 'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs', 'optional': true},
        ],
      },
      {
        'id': 5,
        'name': 'Simple Spaghetti Aglio e Olio',
        'tags': ['Vegetarian', 'Italian', 'Pantry Staples'],
        'instr': '1. Boil spaghetti. 2. Sauté garlic in oil. 3. Toss pasta.',
        'ings': [
          {'pantryId': 6, 'name': 'Spaghetti', 'qty': 250.0, 'unit': 'g'},
          {'pantryId': 12, 'name': 'Garlic', 'qty': 4.0, 'unit': 'clove'}, // 4 cloves = 20g
          {'pantryId': 21, 'name': 'Olive Oil', 'qty': 4.0, 'unit': 'tbsp', 'optional': true}, // 4 tbsp ~ 60ml
        ],
      },
      {
        'id': 6,
        'name': 'Classic Steak and Peppers',
        'tags': ['High Protein', 'Dinner'],
        'instr': '1. Sear steak. 2. Sauté peppers/onions. 3. Serve together.',
        'ings': [
          {'pantryId': 31, 'name': 'Beef Steak', 'qty': 400.0, 'unit': 'g'},
          {'pantryId': 14, 'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 13, 'name': 'Onion', 'qty': 1.0, 'unit': 'pcs'},
          {'pantryId': 23, 'name': 'Butter', 'qty': 2.0, 'unit': 'tbsp', 'optional': true},
        ],
      },
      {
        'id': 7,
        'name': 'Margherita Pizza',
        'tags': ['Italian', 'Vegetarian', 'Comfort'],
        'instr': '1. Make dough. 2. Add sauce and mozzarella. 3. Bake at 450F.',
        'ings': [
          {'pantryId': 29, 'name': 'Tomato Sauce', 'qty': 1.0, 'unit': 'cup'}, // 1 cup = 245ml
          {'pantryId': 32, 'name': 'Mozzarella Cheese', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 26, 'name': 'Flour', 'qty': 2.5, 'unit': 'cup'}, // 2.5 cups = 300g
          {'pantryId': 21, 'name': 'Olive Oil', 'qty': 2.5, 'unit': 'tbsp', 'optional': true},
        ],
      },
      {
        'id': 8,
        'name': 'Fluffy Pancakes',
        'tags': ['Breakfast', 'Quick', 'Family'],
        'instr': '1. Mix dry. 2. Add wet. 3. Cook on medium heat.',
        'ings': [
          {'pantryId': 26, 'name': 'Flour', 'qty': 1.5, 'unit': 'cup'}, // 1.5 cups = 180g
          {'pantryId': 3, 'name': 'Eggs', 'qty': 2.0, 'unit': 'large'}, // 2 large = 100g
          {'pantryId': 25, 'name': 'Milk', 'qty': 1.0, 'unit': 'cup'}, // 1 cup ~ 244ml
          {'pantryId': 33, 'name': 'Baking Powder', 'qty': 2.0, 'unit': 'tsp'}, // Fixed chemical taste: 2 tsp ~ 9.2g
          {'pantryId': 27, 'name': 'Sugar', 'qty': 1.0, 'unit': 'tbsp', 'optional': true}, // 1 tbsp = 12.5g
        ],
      },
      {
        'id': 9,
        'name': 'Beef Chili',
        'tags': ['Hearty', 'Spicy', 'Freezer Friendly'],
        'instr': '1. Brown beef with onions. 2. Add tomatoes and peppers. 3. Simmer.',
        'ings': [
          {'pantryId': 2, 'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 18, 'name': 'Tomatoes', 'qty': 4.0, 'unit': 'pcs'},
          {'pantryId': 13, 'name': 'Onion', 'qty': 1.0, 'unit': 'pcs'},
          {'pantryId': 14, 'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs', 'optional': true},
        ],
      },
      {
        'id': 10,
        'name': 'California Roll',
        'tags': ['Japanese', 'Healthy', 'Fun'],
        'instr': '1. Cook sushi rice. 2. Roll nori with avocado and shrimp.',
        'ings': [
          {'pantryId': 7, 'name': 'White Rice', 'qty': 1.0, 'unit': 'cup'}, // 1 cup = 185g
          {'pantryId': 34, 'name': 'Avocado', 'qty': 1.0, 'unit': 'pcs'},
          {'pantryId': 5, 'name': 'Shrimp', 'qty': 100.0, 'unit': 'g', 'optional': true},
        ],
      },
      {
        'id': 11,
        'name': 'Classic Lasagna',
        'tags': ['Italian', 'Family Dinner', 'Make Ahead'],
        'instr': '1. Layer noodles, beef, sauce. 2. Bake 45 mins at 375F.',
        'ings': [
          {'pantryId': 2, 'name': 'Ground Beef', 'qty': 600.0, 'unit': 'g'},
          {'pantryId': 11, 'name': 'Lasagna Noodles', 'qty': 12.0, 'unit': 'sheet'}, // 12 sheets = 240g
          {'pantryId': 29, 'name': 'Tomato Sauce', 'qty': 1.0, 'unit': 'can'}, // 1 can = 425ml
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 2.5, 'unit': 'cup', 'optional': true}, // 2.5 cups ~ 280g
        ],
      },
      {
        'id': 12,
        'name': 'Veggie Stir Fry',
        'tags': ['Vegan', 'Quick', 'Healthy'],
        'instr': '1. Chop veggies. 2. High heat stir fry. 3. Add soy sauce.',
        'ings': [
          {'pantryId': 15, 'name': 'Broccoli', 'qty': 1.0, 'unit': 'head'}, // Fixed from pcs -> head
          {'pantryId': 14, 'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 22, 'name': 'Soy Sauce', 'qty': 2.0, 'unit': 'tbsp'}, // 2 tbsp = 32ml
          {'pantryId': 20, 'name': 'Zucchini', 'qty': 2.0, 'unit': 'pcs', 'optional': true},
        ],
      },
      {
        'id': 13,
        'name': 'Chicken Quesadilla',
        'tags': ['Mexican', 'Quick', 'Kid Friendly'],
        'instr': '1. Shred chicken. 2. Fill tortilla with cheese. 3. Pan fry.',
        'ings': [
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 1.0, 'unit': 'cup'}, // 1 cup = 113g
          {'pantryId': 8, 'name': 'Tortillas', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 13, 'name': 'Onion', 'qty': 4.0, 'unit': 'tbsp', 'optional': true}, // Replaced 0.25 pcs -> 4 tbsp (40g)
        ],
      },
      {
        'id': 14,
        'name': 'Chicken Fried Rice',
        'tags': ['Asian', 'One Pan', 'Leftovers'],
        'instr': '1. Stir fry chicken and rice. 2. Add soy and eggs.',
        'ings': [
          {'pantryId': 7, 'name': 'White Rice', 'qty': 1.5, 'unit': 'cup'}, // 1.5 cups ~ 277g
          {'pantryId': 3, 'name': 'Eggs', 'qty': 2.0, 'unit': 'large'},
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 22, 'name': 'Soy Sauce', 'qty': 2.5, 'unit': 'tbsp', 'optional': true}, // 2.5 tbsp = 40ml
        ],
      },
      {
        'id': 15,
        'name': 'Veggie Omelette',
        'tags': ['Breakfast', 'Quick', 'High Protein'],
        'instr': '1. Whisk eggs. 2. Sauté veggies. 3. Fold when set.',
        'ings': [
          {'pantryId': 3, 'name': 'Eggs', 'qty': 3.0, 'unit': 'large'},
          {'pantryId': 16, 'name': 'Spinach', 'qty': 1.5, 'unit': 'cup'}, // 1.5 cups = 45g
          {'pantryId': 13, 'name': 'Onion', 'qty': 4.0, 'unit': 'tbsp'}, // Replaced 0.25 pcs -> 4 tbsp (40g)
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 1.0, 'unit': 'slice', 'optional': true}, // 1 slice = 28g
        ],
      },
    ];

    final now = DateTime.now();

    final List<Map<String, dynamic>> historySeed = [
      // --- TODAY ---
      {
        'id': 1,
        'recipeId': 8, // Fluffy Pancakes
        'cookedAt': now.subtract(const Duration(hours: 6)),
        'multiplier': 1.0,
      },
      {
        'id': 2,
        'recipeId': 1, // Garlic Butter Chicken
        'cookedAt': now.subtract(const Duration(hours: 1)),
        'multiplier': 2.0,
      },

      // --- YESTERDAY ---
      {
        'id': 3,
        'recipeId': 15, // Veggie Omelette
        'cookedAt': now.subtract(const Duration(days: 1, hours: 8)),
        'multiplier': 1.0,
      },
      {
        'id': 4,
        'recipeId': 2, // Beef Tacos
        'cookedAt': now.subtract(const Duration(days: 1, hours: 2)),
        'multiplier': 2.0, // Double batch for a party
      },

      // --- 2 DAYS AGO ---
      {
        'id': 5,
        'recipeId': 5, // Simple Spaghetti Aglio e Olio
        'cookedAt': now.subtract(const Duration(days: 2, hours: 3)),
        'multiplier': 1.0,
      },

      // --- 3 DAYS AGO ---
      {
        'id': 6,
        'recipeId': 13, // Chicken Quesadilla
        'cookedAt': now.subtract(const Duration(days: 3, hours: 6)),
        'multiplier': 1.0,
      },
      {
        'id': 7,
        'recipeId': 14, // Chicken Fried Rice
        'cookedAt': now.subtract(const Duration(days: 3, hours: 1)),
        'multiplier': 1.0,
      },

      // --- 5 DAYS AGO ---
      {
        'id': 8,
        'recipeId': 3, // Chicken & Broccoli Stir Fry
        'cookedAt': now.subtract(const Duration(days: 5, hours: 4)),
        'multiplier': 0.5, // Half batch
      },
      {
        'id': 9,
        'recipeId': 7, // Margherita Pizza
        'cookedAt': now.subtract(const Duration(days: 5, hours: 2)),
        'multiplier': 1.0,
      },

      // --- 7 DAYS AGO (1 Week) ---
      {
        'id': 10,
        'recipeId': 8, // Fluffy Pancakes
        'cookedAt': now.subtract(const Duration(days: 7, hours: 9)),
        'multiplier': 2.0,
      },
      {
        'id': 11,
        'recipeId': 6, // Classic Steak and Peppers
        'cookedAt': now.subtract(const Duration(days: 7, hours: 3)),
        'multiplier': 1.0,
      },
      {
        'id': 12,
        'recipeId': 10, // California Roll
        'cookedAt': now.subtract(const Duration(days: 7, hours: 1)),
        'multiplier': 1.0,
      },

      // --- 10 DAYS AGO ---
      {
        'id': 13,
        'recipeId': 11, // Classic Lasagna
        'cookedAt': now.subtract(const Duration(days: 10, hours: 5)),
        'multiplier': 1.0,
      },
      {
        'id': 14,
        'recipeId': 9, // Beef Chili
        'cookedAt': now.subtract(const Duration(days: 10, hours: 2)),
        'multiplier': 1.0,
      },

      // --- 14 DAYS AGO (2 Weeks) ---
      {
        'id': 15,
        'recipeId': 4, // Red Chicken Curry
        'cookedAt': now.subtract(const Duration(days: 14, hours: 4)),
        'multiplier': 1.0,
      },
      {
        'id': 16,
        'recipeId': 12, // Veggie Stir Fry
        'cookedAt': now.subtract(const Duration(days: 14, hours: 1)),
        'multiplier': 1.0,
      },
    ];


    final List<Map<String, dynamic>> conversionsSeed = [
      // --- PROTEINS (IDs 1-24) ---
      {'genericNameId': 1, 'unit': 'cup', 'gramWeight': 140.0},
      {'genericNameId': 1, 'unit': 'breast', 'gramWeight': 175.0},
      {'genericNameId': 1, 'unit': 'tbsp', 'gramWeight': 9.0},
      {'genericNameId': 2, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 2, 'unit': 'tbsp', 'gramWeight': 9.0},
      {'genericNameId': 3, 'unit': 'cup', 'gramWeight': 145.0},
      {'genericNameId': 3, 'unit': 'chop', 'gramWeight': 150.0},
      {'genericNameId': 4, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 4, 'unit': 'slice', 'gramWeight': 30.0},
      {'genericNameId': 5, 'unit': 'cup', 'gramWeight': 145.0},
      {'genericNameId': 6, 'unit': 'cup', 'gramWeight': 140.0},
      {'genericNameId': 6, 'unit': 'slice', 'gramWeight': 15.0},
      {'genericNameId': 7, 'unit': 'cup', 'gramWeight': 140.0},
      {'genericNameId': 8, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 9, 'unit': 'pcs', 'gramWeight': 8.0},
      {'genericNameId': 9, 'unit': 'slice', 'gramWeight': 8.0},
      {'genericNameId': 9, 'unit': 'cup', 'gramWeight': 115.0},
      {'genericNameId': 10, 'unit': 'link', 'gramWeight': 75.0},
      {'genericNameId': 10, 'unit': 'patty', 'gramWeight': 50.0},
      {'genericNameId': 10, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 11, 'unit': 'cup', 'gramWeight': 140.0},
      {'genericNameId': 11, 'unit': 'slice', 'gramWeight': 28.0},
      {'genericNameId': 12, 'unit': 'slice', 'gramWeight': 15.0},
      {'genericNameId': 12, 'unit': 'cup', 'gramWeight': 140.0},
      {'genericNameId': 13, 'unit': 'fillet', 'gramWeight': 150.0},
      {'genericNameId': 13, 'unit': 'cup', 'gramWeight': 135.0},
      {'genericNameId': 14, 'unit': 'fillet', 'gramWeight': 150.0},
      {'genericNameId': 14, 'unit': 'cup', 'gramWeight': 135.0},
      {'genericNameId': 15, 'unit': 'can', 'gramWeight': 115.0},
      {'genericNameId': 15, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 16, 'unit': 'pcs', 'gramWeight': 15.0},
      {'genericNameId': 16, 'unit': 'cup', 'gramWeight': 145.0},
      {'genericNameId': 17, 'unit': 'pcs', 'gramWeight': 30.0},
      {'genericNameId': 17, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 18, 'unit': 'pcs', 'gramWeight': 20.0},
      {'genericNameId': 18, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 19, 'unit': 'cup', 'gramWeight': 135.0},
      {'genericNameId': 19, 'unit': 'leg', 'gramWeight': 100.0},
      {'genericNameId': 20, 'unit': 'tail', 'gramWeight': 150.0},
      {'genericNameId': 20, 'unit': 'cup', 'gramWeight': 145.0},
      {'genericNameId': 21, 'unit': 'pcs', 'gramWeight': 50.0},
      {'genericNameId': 21, 'unit': 'large', 'gramWeight': 50.0},
      {'genericNameId': 21, 'unit': 'cup', 'gramWeight': 243.0},
      {'genericNameId': 22, 'unit': 'block', 'gramWeight': 400.0},
      {'genericNameId': 22, 'unit': 'cup', 'gramWeight': 126.0},
      {'genericNameId': 23, 'unit': 'cup', 'gramWeight': 166.0},
      {'genericNameId': 23, 'unit': 'strip', 'gramWeight': 30.0},
      {'genericNameId': 24, 'unit': 'cup', 'gramWeight': 140.0},

      // --- DAIRY & ALTERNATIVES (IDs 25-44) ---
      {'genericNameId': 25, 'unit': 'cup', 'gramWeight': 244.0},
      {'genericNameId': 25, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 26, 'unit': 'cup', 'gramWeight': 238.0},
      {'genericNameId': 26, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 27, 'unit': 'cup', 'gramWeight': 230.0},
      {'genericNameId': 27, 'unit': 'tbsp', 'gramWeight': 14.5},
      {'genericNameId': 28, 'unit': 'cup', 'gramWeight': 245.0},
      {'genericNameId': 28, 'unit': 'container', 'gramWeight': 170.0},
      {'genericNameId': 28, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 29, 'unit': 'stick', 'gramWeight': 113.0},
      {'genericNameId': 29, 'unit': 'cup', 'gramWeight': 227.0},
      {'genericNameId': 29, 'unit': 'tbsp', 'gramWeight': 14.2},
      {'genericNameId': 29, 'unit': 'tsp', 'gramWeight': 4.7},
      {'genericNameId': 30, 'unit': 'cup', 'gramWeight': 205.0},
      {'genericNameId': 30, 'unit': 'tbsp', 'gramWeight': 12.8},
      {'genericNameId': 31, 'unit': 'stick', 'gramWeight': 113.0},
      {'genericNameId': 31, 'unit': 'cup', 'gramWeight': 227.0},
      {'genericNameId': 31, 'unit': 'tbsp', 'gramWeight': 14.2},
      {'genericNameId': 32, 'unit': 'block', 'gramWeight': 226.0},
      {'genericNameId': 32, 'unit': 'cup', 'gramWeight': 232.0},
      {'genericNameId': 32, 'unit': 'tbsp', 'gramWeight': 14.5},
      {'genericNameId': 33, 'unit': 'cup', 'gramWeight': 113.0},
      {'genericNameId': 33, 'unit': 'slice', 'gramWeight': 28.0},
      {'genericNameId': 34, 'unit': 'cup', 'gramWeight': 112.0},
      {'genericNameId': 34, 'unit': 'ball', 'gramWeight': 125.0},
      {'genericNameId': 34, 'unit': 'slice', 'gramWeight': 28.0},
      {'genericNameId': 35, 'unit': 'cup', 'gramWeight': 100.0},
      {'genericNameId': 35, 'unit': 'tbsp', 'gramWeight': 5.0},
      {'genericNameId': 36, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 36, 'unit': 'tbsp', 'gramWeight': 9.0},
      {'genericNameId': 37, 'unit': 'cup', 'gramWeight': 130.0},
      {'genericNameId': 37, 'unit': 'oz', 'gramWeight': 28.0},
      {'genericNameId': 38, 'unit': 'cup', 'gramWeight': 246.0},
      {'genericNameId': 38, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 39, 'unit': 'cup', 'gramWeight': 108.0},
      {'genericNameId': 39, 'unit': 'slice', 'gramWeight': 28.0},
      {'genericNameId': 40, 'unit': 'cup', 'gramWeight': 226.0},
      {'genericNameId': 40, 'unit': 'tbsp', 'gramWeight': 14.0},
      {'genericNameId': 41, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 41, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 42, 'unit': 'cup', 'gramWeight': 243.0},
      {'genericNameId': 42, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 43, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 43, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 44, 'unit': 'can', 'gramWeight': 400.0},
      {'genericNameId': 44, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 44, 'unit': 'tbsp', 'gramWeight': 15.0},

      // --- VEGETABLES (IDs 45-82) ---
      {'genericNameId': 45, 'unit': 'pcs', 'gramWeight': 150.0},
      {'genericNameId': 45, 'unit': 'cup', 'gramWeight': 160.0},
      {'genericNameId': 45, 'unit': 'tbsp', 'gramWeight': 10.0},
      {'genericNameId': 46, 'unit': 'clove', 'gramWeight': 5.0},
      {'genericNameId': 46, 'unit': 'pcs', 'gramWeight': 5.0},
      {'genericNameId': 46, 'unit': 'head', 'gramWeight': 30.0},
      {'genericNameId': 46, 'unit': 'tbsp', 'gramWeight': 8.0},
      {'genericNameId': 46, 'unit': 'tsp', 'gramWeight': 2.8},
      {'genericNameId': 47, 'unit': 'pcs', 'gramWeight': 25.0},
      {'genericNameId': 47, 'unit': 'cup', 'gramWeight': 160.0},
      {'genericNameId': 47, 'unit': 'tbsp', 'gramWeight': 10.0},
      {'genericNameId': 48, 'unit': 'pcs', 'gramWeight': 15.0},
      {'genericNameId': 48, 'unit': 'cup', 'gramWeight': 100.0},
      {'genericNameId': 48, 'unit': 'tbsp', 'gramWeight': 6.0},
      {'genericNameId': 49, 'unit': 'pcs', 'gramWeight': 200.0},
      {'genericNameId': 49, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 50, 'unit': 'pcs', 'gramWeight': 150.0},
      {'genericNameId': 50, 'unit': 'cup', 'gramWeight': 133.0},
      {'genericNameId': 51, 'unit': 'pcs', 'gramWeight': 60.0},
      {'genericNameId': 51, 'unit': 'cup', 'gramWeight': 128.0},
      {'genericNameId': 52, 'unit': 'stalk', 'gramWeight': 40.0},
      {'genericNameId': 52, 'unit': 'pcs', 'gramWeight': 40.0},
      {'genericNameId': 52, 'unit': 'cup', 'gramWeight': 101.0},
      {'genericNameId': 53, 'unit': 'head', 'gramWeight': 300.0},
      {'genericNameId': 53, 'unit': 'cup', 'gramWeight': 91.0},
      {'genericNameId': 54, 'unit': 'head', 'gramWeight': 600.0},
      {'genericNameId': 54, 'unit': 'cup', 'gramWeight': 100.0},
      {'genericNameId': 55, 'unit': 'head', 'gramWeight': 900.0},
      {'genericNameId': 55, 'unit': 'cup', 'gramWeight': 70.0},
      {'genericNameId': 56, 'unit': 'head', 'gramWeight': 200.0},
      {'genericNameId': 56, 'unit': 'cup', 'gramWeight': 70.0},
      {'genericNameId': 57, 'unit': 'cup', 'gramWeight': 30.0},
      {'genericNameId': 57, 'unit': 'bunch', 'gramWeight': 340.0},
      {'genericNameId': 58, 'unit': 'cup', 'gramWeight': 21.0},
      {'genericNameId': 58, 'unit': 'bunch', 'gramWeight': 130.0},
      {'genericNameId': 59, 'unit': 'head', 'gramWeight': 400.0},
      {'genericNameId': 59, 'unit': 'cup', 'gramWeight': 36.0},
      {'genericNameId': 60, 'unit': 'cup', 'gramWeight': 20.0},
      {'genericNameId': 61, 'unit': 'pcs', 'gramWeight': 150.0},
      {'genericNameId': 61, 'unit': 'cup', 'gramWeight': 149.0},
      {'genericNameId': 62, 'unit': 'pcs', 'gramWeight': 15.0},
      {'genericNameId': 62, 'unit': 'tbsp', 'gramWeight': 9.0},
      {'genericNameId': 63, 'unit': 'pcs', 'gramWeight': 15.0},
      {'genericNameId': 63, 'unit': 'tbsp', 'gramWeight': 10.0},
      {'genericNameId': 64, 'unit': 'pcs', 'gramWeight': 123.0},
      {'genericNameId': 64, 'unit': 'cup', 'gramWeight': 180.0},
      {'genericNameId': 64, 'unit': 'slice', 'gramWeight': 20.0},
      {'genericNameId': 65, 'unit': 'pcs', 'gramWeight': 15.0},
      {'genericNameId': 65, 'unit': 'cup', 'gramWeight': 149.0},
      {'genericNameId': 66, 'unit': 'pcs', 'gramWeight': 250.0},
      {'genericNameId': 66, 'unit': 'cup', 'gramWeight': 119.0},
      {'genericNameId': 67, 'unit': 'pcs', 'gramWeight': 200.0},
      {'genericNameId': 67, 'unit': 'cup', 'gramWeight': 113.0},
      {'genericNameId': 68, 'unit': 'pcs', 'gramWeight': 450.0},
      {'genericNameId': 68, 'unit': 'cup', 'gramWeight': 82.0},
      {'genericNameId': 69, 'unit': 'spear', 'gramWeight': 20.0},
      {'genericNameId': 69, 'unit': 'pcs', 'gramWeight': 20.0},
      {'genericNameId': 69, 'unit': 'bunch', 'gramWeight': 450.0},
      {'genericNameId': 69, 'unit': 'cup', 'gramWeight': 134.0},
      {'genericNameId': 70, 'unit': 'cup', 'gramWeight': 100.0},
      {'genericNameId': 71, 'unit': 'cup', 'gramWeight': 145.0},
      {'genericNameId': 72, 'unit': 'ear', 'gramWeight': 90.0},
      {'genericNameId': 72, 'unit': 'pcs', 'gramWeight': 90.0},
      {'genericNameId': 72, 'unit': 'cup', 'gramWeight': 154.0},
      {'genericNameId': 73, 'unit': 'pcs', 'gramWeight': 15.0},
      {'genericNameId': 73, 'unit': 'cup', 'gramWeight': 70.0},
      {'genericNameId': 74, 'unit': 'pcs', 'gramWeight': 9.0},
      {'genericNameId': 74, 'unit': 'cup', 'gramWeight': 116.0},
      {'genericNameId': 75, 'unit': 'pcs', 'gramWeight': 82.0},
      {'genericNameId': 75, 'unit': 'cup', 'gramWeight': 136.0},
      {'genericNameId': 76, 'unit': 'pcs', 'gramWeight': 120.0},
      {'genericNameId': 76, 'unit': 'cup', 'gramWeight': 130.0},
      {'genericNameId': 77, 'unit': 'pcs', 'gramWeight': 120.0},
      {'genericNameId': 77, 'unit': 'cup', 'gramWeight': 133.0},
      {'genericNameId': 78, 'unit': 'bulb', 'gramWeight': 235.0},
      {'genericNameId': 78, 'unit': 'cup', 'gramWeight': 87.0},
      {'genericNameId': 79, 'unit': 'pcs', 'gramWeight': 128.0},
      {'genericNameId': 80, 'unit': 'pcs', 'gramWeight': 19.0},
      {'genericNameId': 80, 'unit': 'cup', 'gramWeight': 88.0},
      {'genericNameId': 81, 'unit': 'pcs', 'gramWeight': 89.0},
      {'genericNameId': 81, 'unit': 'cup', 'gramWeight': 89.0},
      {'genericNameId': 82, 'unit': 'tbsp', 'gramWeight': 6.0},
      {'genericNameId': 82, 'unit': 'tsp', 'gramWeight': 2.0},
      {'genericNameId': 82, 'unit': 'inch', 'gramWeight': 11.0},

      // --- FRUIT (IDs 83-105) ---
      {'genericNameId': 83, 'unit': 'pcs', 'gramWeight': 182.0},
      {'genericNameId': 83, 'unit': 'cup', 'gramWeight': 109.0},
      {'genericNameId': 84, 'unit': 'pcs', 'gramWeight': 118.0},
      {'genericNameId': 84, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 84, 'unit': 'cup', 'gramWeight': 225.0},
      {'genericNameId': 85, 'unit': 'pcs', 'gramWeight': 131.0},
      {'genericNameId': 85, 'unit': 'cup', 'gramWeight': 180.0},
      {'genericNameId': 86, 'unit': 'pcs', 'gramWeight': 58.0},
      {'genericNameId': 86, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 86, 'unit': 'tsp', 'gramWeight': 2.0},
      {'genericNameId': 87, 'unit': 'pcs', 'gramWeight': 44.0},
      {'genericNameId': 87, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 87, 'unit': 'tsp', 'gramWeight': 2.0},
      {'genericNameId': 88, 'unit': 'pcs', 'gramWeight': 246.0},
      {'genericNameId': 88, 'unit': 'cup', 'gramWeight': 230.0},
      {'genericNameId': 89, 'unit': 'pcs', 'gramWeight': 18.0},
      {'genericNameId': 89, 'unit': 'cup', 'gramWeight': 144.0},
      {'genericNameId': 89, 'unit': 'cup', 'gramWeight': 166.0},
      {'genericNameId': 90, 'unit': 'cup', 'gramWeight': 148.0},
      {'genericNameId': 91, 'unit': 'cup', 'gramWeight': 123.0},
      {'genericNameId': 92, 'unit': 'cup', 'gramWeight': 144.0},
      {'genericNameId': 93, 'unit': 'pcs', 'gramWeight': 5.0},
      {'genericNameId': 93, 'unit': 'cup', 'gramWeight': 151.0},
      {'genericNameId': 94, 'unit': 'cup', 'gramWeight': 152.0},
      {'genericNameId': 94, 'unit': 'wedge', 'gramWeight': 286.0},
      {'genericNameId': 95, 'unit': 'cup', 'gramWeight': 160.0},
      {'genericNameId': 95, 'unit': 'wedge', 'gramWeight': 69.0},
      {'genericNameId': 96, 'unit': 'cup', 'gramWeight': 165.0},
      {'genericNameId': 96, 'unit': 'slice', 'gramWeight': 84.0},
      {'genericNameId': 97, 'unit': 'pcs', 'gramWeight': 336.0},
      {'genericNameId': 97, 'unit': 'cup', 'gramWeight': 165.0},
      {'genericNameId': 98, 'unit': 'pcs', 'gramWeight': 150.0},
      {'genericNameId': 98, 'unit': 'cup', 'gramWeight': 154.0},
      {'genericNameId': 99, 'unit': 'pcs', 'gramWeight': 178.0},
      {'genericNameId': 99, 'unit': 'cup', 'gramWeight': 140.0},
      {'genericNameId': 100, 'unit': 'pcs', 'gramWeight': 66.0},
      {'genericNameId': 100, 'unit': 'cup', 'gramWeight': 165.0},
      {'genericNameId': 101, 'unit': 'pcs', 'gramWeight': 8.0},
      {'genericNameId': 101, 'unit': 'cup', 'gramWeight': 154.0},
      {'genericNameId': 102, 'unit': 'pcs', 'gramWeight': 69.0},
      {'genericNameId': 102, 'unit': 'cup', 'gramWeight': 180.0},
      {'genericNameId': 103, 'unit': 'pcs', 'gramWeight': 150.0},
      {'genericNameId': 103, 'unit': 'cup', 'gramWeight': 150.0},
      {'genericNameId': 103, 'unit': 'cup', 'gramWeight': 230.0},
      {'genericNameId': 104, 'unit': 'pcs', 'gramWeight': 282.0},
      {'genericNameId': 104, 'unit': 'cup', 'gramWeight': 174.0},
      {'genericNameId': 105, 'unit': 'cup', 'gramWeight': 80.0},

      // --- GRAINS, PASTA & BREAD (IDs 106-124) ---
      {'genericNameId': 106, 'unit': 'cup', 'gramWeight': 185.0},
      {'genericNameId': 106, 'unit': 'tbsp', 'gramWeight': 12.0},
      {'genericNameId': 107, 'unit': 'cup', 'gramWeight': 190.0},
      {'genericNameId': 107, 'unit': 'tbsp', 'gramWeight': 12.0},
      {'genericNameId': 108, 'unit': 'cup', 'gramWeight': 170.0},
      {'genericNameId': 108, 'unit': 'tbsp', 'gramWeight': 10.6},
      {'genericNameId': 109, 'unit': 'cup', 'gramWeight': 173.0},
      {'genericNameId': 109, 'unit': 'tbsp', 'gramWeight': 10.8},
      {'genericNameId': 110, 'unit': 'cup', 'gramWeight': 184.0},
      {'genericNameId': 111, 'unit': 'cup', 'gramWeight': 80.0},
      {'genericNameId': 111, 'unit': 'tbsp', 'gramWeight': 5.0},
      {'genericNameId': 112, 'unit': 'cup', 'gramWeight': 120.0},
      {'genericNameId': 112, 'unit': 'tbsp', 'gramWeight': 7.5},
      {'genericNameId': 112, 'unit': 'tsp', 'gramWeight': 2.5},
      {'genericNameId': 113, 'unit': 'cup', 'gramWeight': 122.0},
      {'genericNameId': 113, 'unit': 'tbsp', 'gramWeight': 7.6},
      {'genericNameId': 114, 'unit': 'cup', 'gramWeight': 90.0},
      {'genericNameId': 115, 'unit': 'cup', 'gramWeight': 100.0},
      {'genericNameId': 116, 'unit': 'pcs', 'gramWeight': 20.0},
      {'genericNameId': 116, 'unit': 'sheet', 'gramWeight': 20.0},
      {'genericNameId': 117, 'unit': 'cup', 'gramWeight': 38.0},
      {'genericNameId': 118, 'unit': 'cup', 'gramWeight': 65.0},
      {'genericNameId': 119, 'unit': 'pcs', 'gramWeight': 30.0},
      {'genericNameId': 119, 'unit': 'slice', 'gramWeight': 30.0},
      {'genericNameId': 120, 'unit': 'pcs', 'gramWeight': 50.0},
      {'genericNameId': 121, 'unit': 'pcs', 'gramWeight': 105.0},
      {'genericNameId': 122, 'unit': 'pcs', 'gramWeight': 45.0},
      {'genericNameId': 123, 'unit': 'pcs', 'gramWeight': 60.0},
      {'genericNameId': 124, 'unit': 'cup', 'gramWeight': 108.0},
      {'genericNameId': 124, 'unit': 'tbsp', 'gramWeight': 7.0},

      // --- BAKING & SWEETENERS (IDs 125-138) ---
      {'genericNameId': 125, 'unit': 'cup', 'gramWeight': 200.0},
      {'genericNameId': 125, 'unit': 'tbsp', 'gramWeight': 12.5},
      {'genericNameId': 125, 'unit': 'tsp', 'gramWeight': 4.2},
      {'genericNameId': 126, 'unit': 'cup', 'gramWeight': 220.0},
      {'genericNameId': 126, 'unit': 'tbsp', 'gramWeight': 13.7},
      {'genericNameId': 126, 'unit': 'tsp', 'gramWeight': 4.6},
      {'genericNameId': 127, 'unit': 'cup', 'gramWeight': 120.0},
      {'genericNameId': 127, 'unit': 'tbsp', 'gramWeight': 7.5},
      {'genericNameId': 128, 'unit': 'cup', 'gramWeight': 340.0},
      {'genericNameId': 128, 'unit': 'tbsp', 'gramWeight': 21.0},
      {'genericNameId': 128, 'unit': 'tsp', 'gramWeight': 7.0},
      {'genericNameId': 129, 'unit': 'cup', 'gramWeight': 312.0},
      {'genericNameId': 129, 'unit': 'tbsp', 'gramWeight': 19.5},
      {'genericNameId': 129, 'unit': 'tsp', 'gramWeight': 6.5},
      {'genericNameId': 130, 'unit': 'cup', 'gramWeight': 337.0},
      {'genericNameId': 130, 'unit': 'tbsp', 'gramWeight': 21.0},
      {'genericNameId': 130, 'unit': 'tsp', 'gramWeight': 7.0},
      {'genericNameId': 131, 'unit': 'tbsp', 'gramWeight': 13.0},
      {'genericNameId': 131, 'unit': 'tsp', 'gramWeight': 4.2},
      {'genericNameId': 132, 'unit': 'packet', 'gramWeight': 7.0},
      {'genericNameId': 132, 'unit': 'tbsp', 'gramWeight': 9.0},
      {'genericNameId': 132, 'unit': 'tsp', 'gramWeight': 3.0},
      {'genericNameId': 133, 'unit': 'tbsp', 'gramWeight': 14.0},
      {'genericNameId': 133, 'unit': 'tsp', 'gramWeight': 4.6},
      {'genericNameId': 134, 'unit': 'tbsp', 'gramWeight': 14.4},
      {'genericNameId': 134, 'unit': 'tsp', 'gramWeight': 4.8},
      {'genericNameId': 135, 'unit': 'cup', 'gramWeight': 86.0},
      {'genericNameId': 135, 'unit': 'tbsp', 'gramWeight': 5.4},
      {'genericNameId': 136, 'unit': 'oz', 'gramWeight': 28.0},
      {'genericNameId': 136, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 137, 'unit': 'cup', 'gramWeight': 168.0},
      {'genericNameId': 137, 'unit': 'tbsp', 'gramWeight': 10.5},
      {'genericNameId': 138, 'unit': 'cup', 'gramWeight': 128.0},
      {'genericNameId': 138, 'unit': 'tbsp', 'gramWeight': 8.0},
      {'genericNameId': 138, 'unit': 'tsp', 'gramWeight': 2.6},

      // --- OILS & VINEGARS (IDs 139-147) ---
      {'genericNameId': 139, 'unit': 'cup', 'gramWeight': 216.0},
      {'genericNameId': 139, 'unit': 'tbsp', 'gramWeight': 13.5},
      {'genericNameId': 139, 'unit': 'tsp', 'gramWeight': 4.5},
      {'genericNameId': 140, 'unit': 'cup', 'gramWeight': 218.0},
      {'genericNameId': 140, 'unit': 'tbsp', 'gramWeight': 13.6},
      {'genericNameId': 140, 'unit': 'tsp', 'gramWeight': 4.5},
      {'genericNameId': 141, 'unit': 'cup', 'gramWeight': 218.0},
      {'genericNameId': 141, 'unit': 'tbsp', 'gramWeight': 13.6},
      {'genericNameId': 141, 'unit': 'tsp', 'gramWeight': 4.5},
      {'genericNameId': 142, 'unit': 'cup', 'gramWeight': 218.0},
      {'genericNameId': 142, 'unit': 'tbsp', 'gramWeight': 13.6},
      {'genericNameId': 142, 'unit': 'tsp', 'gramWeight': 4.5},
      {'genericNameId': 143, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 143, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 143, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 144, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 144, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 144, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 145, 'unit': 'cup', 'gramWeight': 238.0},
      {'genericNameId': 145, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 145, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 146, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 146, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 146, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 147, 'unit': 'cup', 'gramWeight': 239.0},
      {'genericNameId': 147, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 147, 'unit': 'tsp', 'gramWeight': 5.0},

      // --- CONDIMENTS & SAUCES (IDs 148-165) ---
      {'genericNameId': 148, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 148, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 148, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 149, 'unit': 'cup', 'gramWeight': 249.0},
      {'genericNameId': 149, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 149, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 150, 'unit': 'cup', 'gramWeight': 220.0},
      {'genericNameId': 150, 'unit': 'tbsp', 'gramWeight': 14.0},
      {'genericNameId': 150, 'unit': 'tsp', 'gramWeight': 4.7},
      {'genericNameId': 151, 'unit': 'cup', 'gramWeight': 250.0},
      {'genericNameId': 151, 'unit': 'tbsp', 'gramWeight': 16.0},
      {'genericNameId': 151, 'unit': 'tsp', 'gramWeight': 5.3},
      {'genericNameId': 152, 'unit': 'cup', 'gramWeight': 288.0},
      {'genericNameId': 152, 'unit': 'tbsp', 'gramWeight': 18.0},
      {'genericNameId': 152, 'unit': 'tsp', 'gramWeight': 6.0},
      {'genericNameId': 153, 'unit': 'cup', 'gramWeight': 288.0},
      {'genericNameId': 153, 'unit': 'tbsp', 'gramWeight': 18.0},
      {'genericNameId': 153, 'unit': 'tsp', 'gramWeight': 6.0},
      {'genericNameId': 154, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 154, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 154, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 155, 'unit': 'cup', 'gramWeight': 270.0},
      {'genericNameId': 155, 'unit': 'tbsp', 'gramWeight': 17.0},
      {'genericNameId': 155, 'unit': 'tsp', 'gramWeight': 5.6},
      {'genericNameId': 156, 'unit': 'cup', 'gramWeight': 286.0},
      {'genericNameId': 156, 'unit': 'tbsp', 'gramWeight': 18.0},
      {'genericNameId': 156, 'unit': 'tsp', 'gramWeight': 6.0},
      {'genericNameId': 157, 'unit': 'cup', 'gramWeight': 272.0},
      {'genericNameId': 157, 'unit': 'tbsp', 'gramWeight': 17.0},
      {'genericNameId': 157, 'unit': 'tsp', 'gramWeight': 5.6},
      {'genericNameId': 158, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 158, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 158, 'unit': 'tsp', 'gramWeight': 5.0},
      {'genericNameId': 159, 'unit': 'cup', 'gramWeight': 275.0},
      {'genericNameId': 159, 'unit': 'tbsp', 'gramWeight': 17.0},
      {'genericNameId': 159, 'unit': 'tsp', 'gramWeight': 5.7},
      {'genericNameId': 160, 'unit': 'cup', 'gramWeight': 250.0},
      {'genericNameId': 160, 'unit': 'tbsp', 'gramWeight': 15.6},
      {'genericNameId': 161, 'unit': 'can', 'gramWeight': 425.0},
      {'genericNameId': 161, 'unit': 'cup', 'gramWeight': 245.0},
      {'genericNameId': 161, 'unit': 'tbsp', 'gramWeight': 15.0},
      {'genericNameId': 162, 'unit': 'cup', 'gramWeight': 260.0},
      {'genericNameId': 162, 'unit': 'tbsp', 'gramWeight': 16.0},
      {'genericNameId': 163, 'unit': 'cup', 'gramWeight': 258.0},
      {'genericNameId': 163, 'unit': 'tbsp', 'gramWeight': 16.0},
      {'genericNameId': 163, 'unit': 'tsp', 'gramWeight': 5.3},
      {'genericNameId': 164, 'unit': 'cup', 'gramWeight': 256.0},
      {'genericNameId': 164, 'unit': 'tbsp', 'gramWeight': 16.0},
      {'genericNameId': 164, 'unit': 'tsp', 'gramWeight': 5.3},
      {'genericNameId': 165, 'unit': 'cup', 'gramWeight': 330.0},
      {'genericNameId': 165, 'unit': 'tbsp', 'gramWeight': 20.0},
      {'genericNameId': 165, 'unit': 'tsp', 'gramWeight': 6.7},

      // --- CANNED & DRY LEGUMES (IDs 166-171) ---
      {'genericNameId': 166, 'unit': 'can', 'gramWeight': 250.0},
      {'genericNameId': 166, 'unit': 'cup', 'gramWeight': 164.0},
      {'genericNameId': 166, 'unit': 'tbsp', 'gramWeight': 10.0},
      {'genericNameId': 167, 'unit': 'can', 'gramWeight': 250.0},
      {'genericNameId': 167, 'unit': 'cup', 'gramWeight': 172.0},
      {'genericNameId': 167, 'unit': 'tbsp', 'gramWeight': 10.8},
      {'genericNameId': 168, 'unit': 'can', 'gramWeight': 250.0},
      {'genericNameId': 168, 'unit': 'cup', 'gramWeight': 177.0},
      {'genericNameId': 168, 'unit': 'tbsp', 'gramWeight': 11.0},
      {'genericNameId': 169, 'unit': 'can', 'gramWeight': 250.0},
      {'genericNameId': 169, 'unit': 'cup', 'gramWeight': 171.0},
      {'genericNameId': 169, 'unit': 'tbsp', 'gramWeight': 10.7},
      {'genericNameId': 170, 'unit': 'cup', 'gramWeight': 198.0},
      {'genericNameId': 170, 'unit': 'tbsp', 'gramWeight': 12.4},
      {'genericNameId': 171, 'unit': 'cup', 'gramWeight': 240.0},
      {'genericNameId': 171, 'unit': 'tbsp', 'gramWeight': 15.0},

      // --- SPICES & HERBS (IDs 172-190) ---
      {'genericNameId': 172, 'unit': 'tbsp', 'gramWeight': 18.0},
      {'genericNameId': 172, 'unit': 'tsp', 'gramWeight': 6.0},
      {'genericNameId': 172, 'unit': 'pinch', 'gramWeight': 0.3},
      {'genericNameId': 173, 'unit': 'tbsp', 'gramWeight': 6.9},
      {'genericNameId': 173, 'unit': 'tsp', 'gramWeight': 2.3},
      {'genericNameId': 173, 'unit': 'pinch', 'gramWeight': 0.2},
      {'genericNameId': 174, 'unit': 'tbsp', 'gramWeight': 6.0},
      {'genericNameId': 174, 'unit': 'tsp', 'gramWeight': 2.0},
      {'genericNameId': 175, 'unit': 'tbsp', 'gramWeight': 6.8},
      {'genericNameId': 175, 'unit': 'tsp', 'gramWeight': 2.3},
      {'genericNameId': 176, 'unit': 'tbsp', 'gramWeight': 6.8},
      {'genericNameId': 176, 'unit': 'tsp', 'gramWeight': 2.3},
      {'genericNameId': 177, 'unit': 'tbsp', 'gramWeight': 7.8},
      {'genericNameId': 177, 'unit': 'tsp', 'gramWeight': 2.6},
      {'genericNameId': 178, 'unit': 'tbsp', 'gramWeight': 8.0},
      {'genericNameId': 178, 'unit': 'tsp', 'gramWeight': 2.7},
      {'genericNameId': 179, 'unit': 'tbsp', 'gramWeight': 6.8},
      {'genericNameId': 179, 'unit': 'tsp', 'gramWeight': 2.3},
      {'genericNameId': 180, 'unit': 'tbsp', 'gramWeight': 5.0},
      {'genericNameId': 180, 'unit': 'tsp', 'gramWeight': 1.7},
      {'genericNameId': 181, 'unit': 'tbsp', 'gramWeight': 5.8},
      {'genericNameId': 181, 'unit': 'tsp', 'gramWeight': 1.9},
      {'genericNameId': 182, 'unit': 'tbsp', 'gramWeight': 7.0},
      {'genericNameId': 182, 'unit': 'tsp', 'gramWeight': 2.3},
      {'genericNameId': 183, 'unit': 'tbsp', 'gramWeight': 5.4},
      {'genericNameId': 183, 'unit': 'tsp', 'gramWeight': 1.8},
      {'genericNameId': 184, 'unit': 'tbsp', 'gramWeight': 5.3},
      {'genericNameId': 184, 'unit': 'tsp', 'gramWeight': 1.8},
      {'genericNameId': 185, 'unit': 'tbsp', 'gramWeight': 4.3},
      {'genericNameId': 185, 'unit': 'tsp', 'gramWeight': 1.4},
      {'genericNameId': 186, 'unit': 'tbsp', 'gramWeight': 3.3},
      {'genericNameId': 186, 'unit': 'tsp', 'gramWeight': 1.1},
      {'genericNameId': 187, 'unit': 'tbsp', 'gramWeight': 3.8},
      {'genericNameId': 187, 'unit': 'tsp', 'gramWeight': 1.3},
      {'genericNameId': 188, 'unit': 'tbsp', 'gramWeight': 3.0},
      {'genericNameId': 188, 'unit': 'tsp', 'gramWeight': 1.0},
      {'genericNameId': 189, 'unit': 'tbsp', 'gramWeight': 3.5},
      {'genericNameId': 189, 'unit': 'tsp', 'gramWeight': 1.2},
      {'genericNameId': 190, 'unit': 'pcs', 'gramWeight': 0.6},
      {'genericNameId': 190, 'unit': 'leaf', 'gramWeight': 0.6},
    ];

    // --- EXECUTE INSERTS ---
    for (var data in genericNamesData) {
      await db.into(db.genericNames).insert(
        GenericNamesCompanion.insert(
          id: Value(data['id'] as int),
          name: data['name'] as String,
          primaryUnit: data['unit'] as String,
        ),
      );
    }

    for (var item in pantrySeed) {
      await db.into(db.pantry).insert(
        PantryCompanion.insert(
          id: Value(item['id'] as int),
          quantity: Value(item['qty'] as double),
          unit: item['unit'] as String,
          isStaple: Value(item['staple'] as bool),
          genericNameId: item['genericNameId'] as int,
        ),
      );
    }

    for (var r in recipesSeed) {
      await db.into(db.recipes).insert(
        RecipesCompanion.insert(
          id: Value(r['id'] as int),
          name: r['name'] as String,
          tags: jsonEncode(r['tags'] as List<String>),
          instructions: r['instr'] as String,
        ),
      );

      final ingredients = r['ings'] as List<Map<String, dynamic>>;
      for (var ing in ingredients) {
        final optional = ing['optional'] ?? false;

        await db.into(db.recipeIngredients).insert(
          RecipeIngredientsCompanion.insert(
              recipeId: r['id'] as int,
              pantryId: ing['pantryId'] as int,
              quantityNeeded: ing['qty'] as double,
              unit: ing['unit'] as String,
              optional: Value(optional as bool)
          ),
        );
      }
    }

    for (var item in historySeed) {
      // 1. Look up the original recipe from your recipesSeed list
      final recipe = recipesSeed.firstWhere(
            (r) => r['id'] == item['recipeId'],
      );

      final multiplier = item['multiplier'] as double;
      final rawIngs = recipe['ings'] as List<Map<String, dynamic>>;

      // 2. Map the raw ingredients into your ConsumedIngredient Dart objects
      // and scale the quantity by the multiplier!
      final consumedList = rawIngs.map((ing) {
        return ConsumedIngredient(
          name: ing['name'] as String,
          quantity: (ing['qty'] as double) * multiplier,
          unit: ing['unit'] as String,
        );
      }).toList();

      // 3. Insert the snapshot
      await db.into(db.recipeHistory).insert(
        RecipeHistoryCompanion.insert(
          id: Value(item['id'] as int),
          recipeId: Value(item['recipeId'] as int),
          name: recipe['name'] as String,
          instructions: recipe['instr'] as String,
          // Serialize the tags array to match your DB setup
          tags: Value(jsonEncode(recipe['tags'] as List<String>)),
          multiplier: Value(multiplier),
          cookedAt: item['cookedAt'] as DateTime,
          // Pass the List<ConsumedIngredient> directly; Drift's TypeConverter handles toSql()
          ingredientsConsumed: consumedList,
        ),
      );
    }

    await db.batch((batch) {
      for (var i = 0; i < conversionsSeed.length; i++) {
        final item = conversionsSeed[i];
        batch.insert(
          db.ingredientConversions,
          IngredientConversionsCompanion.insert(
            genericNameId: item['genericNameId'] as int,
            unit: item['unit'] as String,
            gramWeight: item['gramWeight'] as double,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });

  });
}