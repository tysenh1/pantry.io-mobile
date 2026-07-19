import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

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
      {'id': 9, 'name': 'Bacon', 'unit': 'pcs', 'weight': 25.0},
      {'id': 10, 'name': 'Sausage', 'unit': 'pcs', 'weight': 75.0},
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
      {'id': 21, 'name': 'Egg', 'unit': 'pcs', 'weight': 50.0},
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
      {'id': 45, 'name': 'Onion', 'unit': 'pcs', 'weight': 150.0},
      {'id': 46, 'name': 'Garlic', 'unit': 'pcs', 'weight': 50.0},
      {'id': 47, 'name': 'Shallot', 'unit': 'pcs', 'weight': 25.0},
      {'id': 48, 'name': 'Scallion', 'unit': 'pcs', 'weight': 15.0},
      {'id': 49, 'name': 'Potato', 'unit': 'pcs', 'weight': 200.0},
      {'id': 50, 'name': 'Sweet Potato', 'unit': 'pcs', 'weight': 300.0},
      {'id': 51, 'name': 'Carrot', 'unit': 'pcs', 'weight': 60.0},
      {'id': 52, 'name': 'Celery', 'unit': 'pcs', 'weight': 450.0},
      {'id': 53, 'name': 'Broccoli', 'unit': 'g', 'weight': 300.0},
      {'id': 54, 'name': 'Cauliflower', 'unit': 'pcs', 'weight': 600.0},
      {'id': 55, 'name': 'Cabbage', 'unit': 'pcs', 'weight': 900.0},
      {'id': 56, 'name': 'Bok Choy', 'unit': 'pcs', 'weight': 200.0},
      {'id': 57, 'name': 'Spinach', 'unit': 'g', 'weight': 1.0},
      {'id': 58, 'name': 'Kale', 'unit': 'g', 'weight': 1.0},
      {'id': 59, 'name': 'Lettuce', 'unit': 'pcs', 'weight': 400.0},
      {'id': 60, 'name': 'Arugula', 'unit': 'g', 'weight': 1.0},
      {'id': 61, 'name': 'Bell Pepper', 'unit': 'pcs', 'weight': 150.0},
      {'id': 62, 'name': 'Chili Pepper', 'unit': 'pcs', 'weight': 15.0},
      {'id': 63, 'name': 'Jalapeno', 'unit': 'pcs', 'weight': 15.0},
      {'id': 64, 'name': 'Tomato', 'unit': 'pcs', 'weight': 120.0},
      {'id': 65, 'name': 'Cherry Tomato', 'unit': 'g', 'weight': 15.0},
      {'id': 66, 'name': 'Cucumber', 'unit': 'pcs', 'weight': 250.0},
      {'id': 67, 'name': 'Zucchini', 'unit': 'pcs', 'weight': 200.0},
      {'id': 68, 'name': 'Eggplant', 'unit': 'pcs', 'weight': 450.0},
      {'id': 69, 'name': 'Asparagus', 'unit': 'g', 'weight': 20.0},
      {'id': 70, 'name': 'Green Beans', 'unit': 'g', 'weight': 1.0},
      {'id': 71, 'name': 'Peas', 'unit': 'g', 'weight': 1.0},
      {'id': 72, 'name': 'Corn', 'unit': 'pcs', 'weight': 200.0},
      {'id': 73, 'name': 'Mushroom', 'unit': 'g', 'weight': 15.0},
      {'id': 74, 'name': 'Radish', 'unit': 'pcs', 'weight': 20.0},
      {'id': 75, 'name': 'Beet', 'unit': 'pcs', 'weight': 150.0},
      {'id': 76, 'name': 'Turnip', 'unit': 'pcs', 'weight': 200.0},
      {'id': 77, 'name': 'Parsnip', 'unit': 'pcs', 'weight': 120.0},
      {'id': 78, 'name': 'Fennel', 'unit': 'pcs', 'weight': 250.0},
      {'id': 79, 'name': 'Artichoke', 'unit': 'pcs', 'weight': 300.0},
      {'id': 80, 'name': 'Brussels Sprout', 'unit': 'g', 'weight': 20.0},
      {'id': 81, 'name': 'Leek', 'unit': 'pcs', 'weight': 200.0},
      {'id': 82, 'name': 'Ginger', 'unit': 'g', 'weight': 1.0},

      // FRUIT (IDs 83-105)
      {'id': 83, 'name': 'Apple', 'unit': 'pcs', 'weight': 150.0},
      {'id': 84, 'name': 'Banana', 'unit': 'pcs', 'weight': 120.0},
      {'id': 85, 'name': 'Orange', 'unit': 'pcs', 'weight': 130.0},
      {'id': 86, 'name': 'Lemon', 'unit': 'pcs', 'weight': 60.0},
      {'id': 87, 'name': 'Lime', 'unit': 'pcs', 'weight': 40.0},
      {'id': 88, 'name': 'Grapefruit', 'unit': 'pcs', 'weight': 300.0},
      {'id': 89, 'name': 'Strawberry', 'unit': 'g', 'weight': 12.0},
      {'id': 90, 'name': 'Blueberry', 'unit': 'g', 'weight': 1.0},
      {'id': 91, 'name': 'Raspberry', 'unit': 'g', 'weight': 1.0},
      {'id': 92, 'name': 'Blackberry', 'unit': 'g', 'weight': 1.0},
      {'id': 93, 'name': 'Grape', 'unit': 'g', 'weight': 5.0},
      {'id': 94, 'name': 'Watermelon', 'unit': 'pcs', 'weight': 5000.0},
      {'id': 95, 'name': 'Cantaloupe', 'unit': 'pcs', 'weight': 1500.0},
      {'id': 96, 'name': 'Pineapple', 'unit': 'pcs', 'weight': 900.0},
      {'id': 97, 'name': 'Mango', 'unit': 'pcs', 'weight': 200.0},
      {'id': 98, 'name': 'Peach', 'unit': 'pcs', 'weight': 150.0},
      {'id': 99, 'name': 'Pear', 'unit': 'pcs', 'weight': 180.0},
      {'id': 100, 'name': 'Plum', 'unit': 'pcs', 'weight': 65.0},
      {'id': 101, 'name': 'Cherry', 'unit': 'g', 'weight': 8.0},
      {'id': 102, 'name': 'Kiwi', 'unit': 'pcs', 'weight': 70.0},
      {'id': 103, 'name': 'Avocado', 'unit': 'pcs', 'weight': 200.0},
      {'id': 104, 'name': 'Pomegranate', 'unit': 'pcs', 'weight': 280.0},
      {'id': 105, 'name': 'Coconut', 'unit': 'pcs', 'weight': 400.0},

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
      {'id': 119, 'name': 'Bread', 'unit': 'pcs', 'weight': 30.0},
      {'id': 120, 'name': 'Bun', 'unit': 'pcs', 'weight': 50.0},
      {'id': 121, 'name': 'Bagel', 'unit': 'pcs', 'weight': 100.0},
      {'id': 122, 'name': 'Tortilla', 'unit': 'pcs', 'weight': 45.0},
      {'id': 123, 'name': 'Pita', 'unit': 'pcs', 'weight': 60.0},
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
      {'id': 190, 'name': 'Bay Leaf', 'unit': 'pcs', 'weight': 1.0},
    ];

    // --- 2. SEED PANTRY ITEMS ---
    final List<Map<String, dynamic>> pantrySeed = [
      {'id': 1, 'name': 'Chicken Breast', 'qty': 1000.0, 'unit': 'g', 'staple': false, 'genericNameId': 1},
      {'id': 2, 'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g', 'staple': false, 'genericNameId': 2},
      {'id': 3, 'name': 'Eggs', 'qty': 12.0, 'unit': 'pcs', 'staple': true, 'genericNameId': 21},
      {'id': 4, 'name': 'Salmon Fillet', 'qty': 300.0, 'unit': 'g', 'staple': false, 'genericNameId': 13},
      {'id': 5, 'name': 'Shrimp', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 16},
      {'id': 6, 'name': 'Spaghetti', 'qty': 500.0, 'unit': 'g', 'staple': true, 'genericNameId': 114},
      {'id': 7, 'name': 'White Rice', 'qty': 2000.0, 'unit': 'g', 'staple': true, 'genericNameId': 106},
      {'id': 8, 'name': 'Tortillas', 'qty': 8.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 122},
      {'id': 9, 'name': 'Brown Rice', 'qty': 1000.0, 'unit': 'g', 'staple': true, 'genericNameId': 107},
      {'id': 10, 'name': 'Bread Slices', 'qty': 20.0, 'unit': 'pcs', 'staple': true, 'genericNameId': 119},
      {'id': 11, 'name': 'Lasagna Noodles', 'qty': 400.0, 'unit': 'g', 'staple': false, 'genericNameId': 116},
      {'id': 12, 'name': 'Garlic', 'qty': 5.0, 'unit': 'pcs', 'staple': true, 'genericNameId': 46},
      {'id': 13, 'name': 'Onion', 'qty': 2.0, 'unit': 'pcs', 'staple': true, 'genericNameId': 45},
      {'id': 14, 'name': 'Bell Peppers', 'qty': 3.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 61},
      {'id': 15, 'name': 'Broccoli', 'qty': 1.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 53},
      {'id': 16, 'name': 'Spinach', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 57},
      {'id': 17, 'name': 'Carrots', 'qty': 5.0, 'unit': 'pcs', 'staple': true, 'genericNameId': 51},
      {'id': 18, 'name': 'Tomatoes', 'qty': 6.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 64},
      {'id': 19, 'name': 'Mushrooms', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 73},
      {'id': 20, 'name': 'Zucchini', 'qty': 3.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 67},
      {'id': 21, 'name': 'Olive Oil', 'qty': 1000.0, 'unit': 'ml', 'staple': true, 'genericNameId': 139},
      {'id': 22, 'name': 'Soy Sauce', 'qty': 250.0, 'unit': 'ml', 'staple': true, 'genericNameId': 151},
      {'id': 23, 'name': 'Butter', 'qty': 250.0, 'unit': 'g', 'staple': true, 'genericNameId': 29},
      {'id': 24, 'name': 'Cheddar Cheese', 'qty': 200.0, 'unit': 'g', 'staple': false, 'genericNameId': 33},
      {'id': 25, 'name': 'Milk', 'qty': 2000.0, 'unit': 'ml', 'staple': true, 'genericNameId': 25},
      {'id': 26, 'name': 'Flour', 'qty': 2000.0, 'unit': 'g', 'staple': true, 'genericNameId': 112},
      {'id': 27, 'name': 'Sugar', 'qty': 1000.0, 'unit': 'g', 'staple': true, 'genericNameId': 125},
      {'id': 28, 'name': 'Honey', 'qty': 500.0, 'unit': 'g', 'staple': true, 'genericNameId': 128},
      {'id': 29, 'name': 'Tomato Sauce', 'qty': 800.0, 'unit': 'ml', 'staple': true, 'genericNameId': 161},
      {'id': 30, 'name': 'Coconut Milk', 'qty': 0.0, 'unit': 'ml', 'staple': false, 'genericNameId': 44},
      {'id': 31, 'name': 'Beef Steak', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 4},
      {'id': 32, 'name': 'Mozzarella Cheese', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 34},
      {'id': 33, 'name': 'Baking Powder', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 133},
      {'id': 34, 'name': 'Avocado', 'qty': 0.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 103},
      {'id': 35, 'name': 'Peanut Butter', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 163},
      {'id': 36, 'name': 'Lime', 'qty': 0.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 87},
      {'id': 37, 'name': 'Bun', 'qty': 0.0, 'unit': 'pcs', 'staple': false, 'genericNameId': 120},
      {'id': 38, 'name': 'Chocolate Snacks', 'qty': 0.0, 'unit': 'g', 'staple': false, 'genericNameId': 136},
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
          {'pantryId': 12, 'name': 'Garlic', 'qty': 3.0, 'unit': 'pcs'},
          {'pantryId': 23, 'name': 'Butter', 'qty': 30.0, 'unit': 'g'},
          {'pantryId': 21, 'name': 'Olive Oil', 'qty': 35.5, 'unit': 'ml', 'optional': true},
        ],
      },
      {
        'id': 2,
        'name': 'Beef Tacos',
        'tags': ['Mexican', 'Family Style', 'Quick'],
        'instr': '1. Brown beef with onions. 2. Warm tortillas. 3. Assemble with cheese.',
        'ings': [
          {'pantryId': 2, 'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 8, 'name': 'Tortillas', 'qty': 4.0, 'unit': 'pcs'},
          {'pantryId': 13, 'name': 'Onion', 'qty': 0.5, 'unit': 'pcs'},
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 100.0, 'unit': 'g', 'optional': true},
        ],
      },
      {
        'id': 3,
        'name': 'Chicken & Broccoli Stir Fry',
        'tags': ['Asian', 'Healthy', 'One-Pan'],
        'instr': '1. Slice chicken and broccoli. 2. Stir fry. 3. Add soy sauce.',
        'ings': [
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 400.0, 'unit': 'g'},
          {'pantryId': 15, 'name': 'Broccoli', 'qty': 1.0, 'unit': 'pcs'},
          {'pantryId': 22, 'name': 'Soy Sauce', 'qty': 50.0, 'unit': 'ml'},
          {'pantryId': 7, 'name': 'White Rice', 'qty': 200.0, 'unit': 'g', 'optional': true},
        ],
      },
      {
        'id': 4,
        'name': 'Red Chicken Curry',
        'tags': ['Spicy', 'Thai', 'Hearty'],
        'instr': '1. Simmer paste with coconut milk. 2. Add chicken and peppers.',
        'ings': [
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 30, 'name': 'Coconut Milk', 'qty': 400.0, 'unit': 'ml'},
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
          {'pantryId': 12, 'name': 'Garlic', 'qty': 4.0, 'unit': 'pcs'},
          {'pantryId': 21, 'name': 'Olive Oil', 'qty': 60.0, 'unit': 'ml', 'optional': true},
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
          {'pantryId': 23, 'name': 'Butter', 'qty': 30.0, 'unit': 'g', 'optional': true},
        ],
      },
      {
        'id': 7,
        'name': 'Margherita Pizza',
        'tags': ['Italian', 'Vegetarian', 'Comfort'],
        'instr': '1. Make dough. 2. Add sauce and mozzarella. 3. Bake at 450F.',
        'ings': [
          {'pantryId': 29, 'name': 'Tomato Sauce', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 32, 'name': 'Mozzarella Cheese', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 26, 'name': 'Flour', 'qty': 300.0, 'unit': 'g'},
          {'pantryId': 21, 'name': 'Olive Oil', 'qty': 35.5, 'unit': 'ml', 'optional': true},
        ],
      },
      {
        'id': 8,
        'name': 'Fluffy Pancakes',
        'tags': ['Breakfast', 'Quick', 'Family'],
        'instr': '1. Mix dry. 2. Add wet. 3. Cook on medium heat.',
        'ings': [
          {'pantryId': 26, 'name': 'Flour', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 3, 'name': 'Eggs', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 25, 'name': 'Milk', 'qty': 250.0, 'unit': 'ml'},
          {'pantryId': 33, 'name': 'Baking Powder', 'qty': 20.0, 'unit': 'g'},
          {'pantryId': 27, 'name': 'Sugar', 'qty': 12.0, 'unit': 'g', 'optional': true},
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
          {'pantryId': 7, 'name': 'White Rice', 'qty': 200.0, 'unit': 'g'},
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
          {'pantryId': 11, 'name': 'Lasagna Noodles', 'qty': 12.0, 'unit': 'pcs'},
          {'pantryId': 29, 'name': 'Tomato Sauce', 'qty': 500.0, 'unit': 'g'},
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 300.0, 'unit': 'g', 'optional': true},
        ],
      },
      {
        'id': 12,
        'name': 'Veggie Stir Fry',
        'tags': ['Vegan', 'Quick', 'Healthy'],
        'instr': '1. Chop veggies. 2. High heat stir fry. 3. Add soy sauce.',
        'ings': [
          {'pantryId': 15, 'name': 'Broccoli', 'qty': 1.0, 'unit': 'pcs'},
          {'pantryId': 14, 'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 22, 'name': 'Soy Sauce', 'qty': 30.0, 'unit': 'ml'},
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
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 100.0, 'unit': 'g'},
          {'pantryId': 8, 'name': 'Tortillas', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 13, 'name': 'Onion', 'qty': 0.25, 'unit': 'pcs', 'optional': true},
        ],
      },
      {
        'id': 14,
        'name': 'Chicken Fried Rice',
        'tags': ['Asian', 'One Pan', 'Leftovers'],
        'instr': '1. Stir fry chicken and rice. 2. Add soy and eggs.',
        'ings': [
          {'pantryId': 7, 'name': 'White Rice', 'qty': 300.0, 'unit': 'g'},
          {'pantryId': 3, 'name': 'Eggs', 'qty': 2.0, 'unit': 'pcs'},
          {'pantryId': 1, 'name': 'Chicken Breast', 'qty': 200.0, 'unit': 'g'},
          {'pantryId': 22, 'name': 'Soy Sauce', 'qty': 40.0, 'unit': 'ml', 'optional': true},
        ],
      },
      {
        'id': 15,
        'name': 'Veggie Omelette',
        'tags': ['Breakfast', 'Quick', 'High Protein'],
        'instr': '1. Whisk eggs. 2. Sauté veggies. 3. Fold when set.',
        'ings': [
          {'pantryId': 3, 'name': 'Eggs', 'qty': 3.0, 'unit': 'pcs'},
          {'pantryId': 16, 'name': 'Spinach', 'qty': 50.0, 'unit': 'g'},
          {'pantryId': 13, 'name': 'Onion', 'qty': 0.25, 'unit': 'pcs'},
          {'pantryId': 24, 'name': 'Cheddar Cheese', 'qty': 30.0, 'unit': 'g', 'optional': true},
        ],
      },
    ];

    // --- EXECUTE INSERTS ---
    for (var data in genericNamesData) {
      await db.into(db.genericNames).insert(
        GenericNamesCompanion.insert(
          id: Value(data['id'] as int),
          name: data['name'] as String,
          primaryUnit: data['unit'] as String,
          weightPerPiece: data['weight'] as double,
        ),
      );
    }

    for (var item in pantrySeed) {
      await db.into(db.pantry).insert(
        PantryCompanion.insert(
          id: Value(item['id'] as int),
          quantity: Value(item['qty'] as double),
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
  });
}