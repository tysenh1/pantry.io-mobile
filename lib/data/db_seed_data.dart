import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

Future<void> seedAllData(AppDatabase db) async {
  await db.transaction(() async {
    // --- 1. SEED GENERIC NAMES ---
    final Map<String, int> genericNameToId = {};

    final List<Map<String, dynamic>> genericNamesData = [
      // PROTEINS
      {'name': 'Chicken', 'unit': 'g', 'weight': 200.0},
      {'name': 'Beef', 'unit': 'g', 'weight': 500.0},
      {'name': 'Pork', 'unit': 'g', 'weight': 200.0},
      {'name': 'Steak', 'unit': 'g', 'weight': 250.0},
      {'name': 'Lamb', 'unit': 'g', 'weight': 250.0},
      {'name': 'Turkey', 'unit': 'g', 'weight': 5000.0},
      {'name': 'Duck', 'unit': 'g', 'weight': 2000.0},
      {'name': 'Venison', 'unit': 'g', 'weight': 250.0},
      {'name': 'Bacon', 'unit': 'pcs', 'weight': 25.0},
      {'name': 'Sausage', 'unit': 'pcs', 'weight': 75.0},
      {'name': 'Ham', 'unit': 'g', 'weight': 500.0},
      {'name': 'Deli Meat', 'unit': 'g', 'weight': 1.0},
      {'name': 'Salmon', 'unit': 'g', 'weight': 150.0},
      {'name': 'White Fish', 'unit': 'g', 'weight': 150.0},
      {'name': 'Tuna', 'unit': 'g', 'weight': 170.0},
      {'name': 'Shrimp', 'unit': 'g', 'weight': 15.0},
      {'name': 'Scallops', 'unit': 'g', 'weight': 30.0},
      {'name': 'Mussels', 'unit': 'g', 'weight': 20.0},
      {'name': 'Crab', 'unit': 'g', 'weight': 100.0},
      {'name': 'Lobster', 'unit': 'g', 'weight': 500.0},
      {'name': 'Egg', 'unit': 'pcs', 'weight': 50.0},
      {'name': 'Tofu', 'unit': 'g', 'weight': 400.0},
      {'name': 'Tempeh', 'unit': 'g', 'weight': 225.0},
      {'name': 'Seitan', 'unit': 'g', 'weight': 225.0},

      // DAIRY & ALTERNATIVES
      {'name': 'Milk', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Heavy Cream', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Sour Cream', 'unit': 'g', 'weight': 1.0},
      {'name': 'Yogurt', 'unit': 'g', 'weight': 170.0},
      {'name': 'Butter', 'unit': 'g', 'weight': 227.0},
      {'name': 'Ghee', 'unit': 'g', 'weight': 1.0},
      {'name': 'Margarine', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cream Cheese', 'unit': 'g', 'weight': 226.0},
      {'name': 'Cheddar Cheese', 'unit': 'g', 'weight': 28.0},
      {'name': 'Mozzarella Cheese', 'unit': 'g', 'weight': 28.0},
      {'name': 'Parmesan Cheese', 'unit': 'g', 'weight': 1.0},
      {'name': 'Feta Cheese', 'unit': 'g', 'weight': 1.0},
      {'name': 'Goat Cheese', 'unit': 'g', 'weight': 1.0},
      {'name': 'Ricotta Cheese', 'unit': 'g', 'weight': 1.0},
      {'name': 'Swiss Cheese', 'unit': 'g', 'weight': 28.0},
      {'name': 'Cottage Cheese', 'unit': 'g', 'weight': 1.0},
      {'name': 'Almond Milk', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Soy Milk', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Oat Milk', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Coconut Milk', 'unit': 'ml', 'weight': 400.0},

      // VEGETABLES
      {'name': 'Onion', 'unit': 'pcs', 'weight': 150.0},
      {'name': 'Garlic', 'unit': 'pcs', 'weight': 50.0},
      {'name': 'Shallot', 'unit': 'pcs', 'weight': 25.0},
      {'name': 'Scallion', 'unit': 'pcs', 'weight': 15.0},
      {'name': 'Potato', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Sweet Potato', 'unit': 'pcs', 'weight': 300.0},
      {'name': 'Carrot', 'unit': 'pcs', 'weight': 60.0},
      {'name': 'Celery', 'unit': 'pcs', 'weight': 450.0},
      {'name': 'Broccoli', 'unit': 'g', 'weight': 300.0},
      {'name': 'Cauliflower', 'unit': 'pcs', 'weight': 600.0},
      {'name': 'Cabbage', 'unit': 'pcs', 'weight': 900.0},
      {'name': 'Bok Choy', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Spinach', 'unit': 'g', 'weight': 1.0},
      {'name': 'Kale', 'unit': 'g', 'weight': 1.0},
      {'name': 'Lettuce', 'unit': 'pcs', 'weight': 400.0},
      {'name': 'Arugula', 'unit': 'g', 'weight': 1.0},
      {'name': 'Bell Pepper', 'unit': 'pcs', 'weight': 150.0},
      {'name': 'Chili Pepper', 'unit': 'pcs', 'weight': 15.0},
      {'name': 'Jalapeno', 'unit': 'pcs', 'weight': 15.0},
      {'name': 'Tomato', 'unit': 'pcs', 'weight': 120.0},
      {'name': 'Cherry Tomato', 'unit': 'g', 'weight': 15.0},
      {'name': 'Cucumber', 'unit': 'pcs', 'weight': 250.0},
      {'name': 'Zucchini', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Eggplant', 'unit': 'pcs', 'weight': 450.0},
      {'name': 'Asparagus', 'unit': 'g', 'weight': 20.0},
      {'name': 'Green Beans', 'unit': 'g', 'weight': 1.0},
      {'name': 'Peas', 'unit': 'g', 'weight': 1.0},
      {'name': 'Corn', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Mushroom', 'unit': 'g', 'weight': 15.0},
      {'name': 'Radish', 'unit': 'pcs', 'weight': 20.0},
      {'name': 'Beet', 'unit': 'pcs', 'weight': 150.0},
      {'name': 'Turnip', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Parsnip', 'unit': 'pcs', 'weight': 120.0},
      {'name': 'Fennel', 'unit': 'pcs', 'weight': 250.0},
      {'name': 'Artichoke', 'unit': 'pcs', 'weight': 300.0},
      {'name': 'Brussels Sprout', 'unit': 'g', 'weight': 20.0},
      {'name': 'Leek', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Ginger', 'unit': 'g', 'weight': 1.0},

      // FRUIT
      {'name': 'Apple', 'unit': 'pcs', 'weight': 150.0},
      {'name': 'Banana', 'unit': 'pcs', 'weight': 120.0},
      {'name': 'Orange', 'unit': 'pcs', 'weight': 130.0},
      {'name': 'Lemon', 'unit': 'pcs', 'weight': 60.0},
      {'name': 'Lime', 'unit': 'pcs', 'weight': 40.0},
      {'name': 'Grapefruit', 'unit': 'pcs', 'weight': 300.0},
      {'name': 'Strawberry', 'unit': 'g', 'weight': 12.0},
      {'name': 'Blueberry', 'unit': 'g', 'weight': 1.0},
      {'name': 'Raspberry', 'unit': 'g', 'weight': 1.0},
      {'name': 'Blackberry', 'unit': 'g', 'weight': 1.0},
      {'name': 'Grape', 'unit': 'g', 'weight': 5.0},
      {'name': 'Watermelon', 'unit': 'pcs', 'weight': 5000.0},
      {'name': 'Cantaloupe', 'unit': 'pcs', 'weight': 1500.0},
      {'name': 'Pineapple', 'unit': 'pcs', 'weight': 900.0},
      {'name': 'Mango', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Peach', 'unit': 'pcs', 'weight': 150.0},
      {'name': 'Pear', 'unit': 'pcs', 'weight': 180.0},
      {'name': 'Plum', 'unit': 'pcs', 'weight': 65.0},
      {'name': 'Cherry', 'unit': 'g', 'weight': 8.0},
      {'name': 'Kiwi', 'unit': 'pcs', 'weight': 70.0},
      {'name': 'Avocado', 'unit': 'pcs', 'weight': 200.0},
      {'name': 'Pomegranate', 'unit': 'pcs', 'weight': 280.0},
      {'name': 'Coconut', 'unit': 'pcs', 'weight': 400.0},

      // GRAINS, PASTA & BREAD
      {'name': 'White Rice', 'unit': 'g', 'weight': 1.0},
      {'name': 'Brown Rice', 'unit': 'g', 'weight': 1.0},
      {'name': 'Quinoa', 'unit': 'g', 'weight': 1.0},
      {'name': 'Couscous', 'unit': 'g', 'weight': 1.0},
      {'name': 'Barley', 'unit': 'g', 'weight': 1.0},
      {'name': 'Oats', 'unit': 'g', 'weight': 1.0},
      {'name': 'Flour', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cornmeal', 'unit': 'g', 'weight': 1.0},
      {'name': 'Spaghetti', 'unit': 'g', 'weight': 1.0},
      {'name': 'Short Pasta', 'unit': 'g', 'weight': 1.0},
      {'name': 'Lasagna Noodle', 'unit': 'g', 'weight': 20.0},
      {'name': 'Egg Noodle', 'unit': 'g', 'weight': 1.0},
      {'name': 'Rice Noodle', 'unit': 'g', 'weight': 1.0},
      {'name': 'Bread', 'unit': 'pcs', 'weight': 30.0},
      {'name': 'Bun', 'unit': 'pcs', 'weight': 50.0},
      {'name': 'Bagel', 'unit': 'pcs', 'weight': 100.0},
      {'name': 'Tortilla', 'unit': 'pcs', 'weight': 45.0},
      {'name': 'Pita', 'unit': 'pcs', 'weight': 60.0},
      {'name': 'Breadcrumbs', 'unit': 'g', 'weight': 1.0},

      // BAKING & SWEETENERS
      {'name': 'Sugar', 'unit': 'g', 'weight': 1.0},
      {'name': 'Brown Sugar', 'unit': 'g', 'weight': 1.0},
      {'name': 'Powdered Sugar', 'unit': 'g', 'weight': 1.0},
      {'name': 'Honey', 'unit': 'g', 'weight': 1.0},
      {'name': 'Maple Syrup', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Molasses', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Vanilla Extract', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Yeast', 'unit': 'g', 'weight': 7.0},
      {'name': 'Baking Powder', 'unit': 'g', 'weight': 1.0},
      {'name': 'Baking Soda', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cocoa Powder', 'unit': 'g', 'weight': 1.0},
      {'name': 'Chocolate', 'unit': 'g', 'weight': 1.0},
      {'name': 'Chocolate Chips', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cornstarch', 'unit': 'g', 'weight': 1.0},

      // OILS & VINEGARS
      {'name': 'Olive Oil', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Vegetable Oil', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Coconut Oil', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Sesame Oil', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Balsamic Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Apple Cider Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'name': 'White Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Rice Vinegar', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Red Wine Vinegar', 'unit': 'ml', 'weight': 1.0},

      // CONDIMENTS & SAUCES
      {'name': 'Ketchup', 'unit': 'g', 'weight': 1.0},
      {'name': 'Mustard', 'unit': 'g', 'weight': 1.0},
      {'name': 'Mayonnaise', 'unit': 'g', 'weight': 1.0},
      {'name': 'Soy Sauce', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Fish Sauce', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Oyster Sauce', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Hot Sauce', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Sriracha', 'unit': 'ml', 'weight': 1.0},
      {'name': 'BBQ Sauce', 'unit': 'g', 'weight': 1.0},
      {'name': 'Worcestershire', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Tahini', 'unit': 'g', 'weight': 1.0},
      {'name': 'Miso', 'unit': 'g', 'weight': 1.0},
      {'name': 'Pesto', 'unit': 'g', 'weight': 1.0},
      {'name': 'Tomato Sauce', 'unit': 'ml', 'weight': 1.0},
      {'name': 'Salsa', 'unit': 'g', 'weight': 1.0},
      {'name': 'Peanut Butter', 'unit': 'g', 'weight': 1.0},
      {'name': 'Almond Butter', 'unit': 'g', 'weight': 1.0},
      {'name': 'Jam', 'unit': 'g', 'weight': 1.0},

      // CANNED & DRY LEGUMES
      {'name': 'Chickpeas', 'unit': 'g', 'weight': 425.0},
      {'name': 'Black Beans', 'unit': 'g', 'weight': 425.0},
      {'name': 'Kidney Beans', 'unit': 'g', 'weight': 425.0},
      {'name': 'Pinto Beans', 'unit': 'g', 'weight': 425.0},
      {'name': 'Lentils', 'unit': 'g', 'weight': 1.0},
      {'name': 'Broth', 'unit': 'ml', 'weight': 1.0},

      // SPICES & HERBS
      {'name': 'Salt', 'unit': 'g', 'weight': 1.0},
      {'name': 'Black Pepper', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cumin', 'unit': 'g', 'weight': 1.0},
      {'name': 'Paprika', 'unit': 'g', 'weight': 1.0},
      {'name': 'Smoked Paprika', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cinnamon', 'unit': 'g', 'weight': 1.0},
      {'name': 'Chili Powder', 'unit': 'g', 'weight': 1.0},
      {'name': 'Turmeric', 'unit': 'g', 'weight': 1.0},
      {'name': 'Coriander', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cardamom', 'unit': 'g', 'weight': 1.0},
      {'name': 'Nutmeg', 'unit': 'g', 'weight': 1.0},
      {'name': 'Oregano', 'unit': 'g', 'weight': 1.0},
      {'name': 'Basil', 'unit': 'g', 'weight': 1.0},
      {'name': 'Thyme', 'unit': 'g', 'weight': 1.0},
      {'name': 'Rosemary', 'unit': 'g', 'weight': 1.0},
      {'name': 'Parsley', 'unit': 'g', 'weight': 1.0},
      {'name': 'Cilantro', 'unit': 'g', 'weight': 1.0},
      {'name': 'Dill', 'unit': 'g', 'weight': 1.0},
      {'name': 'Bay Leaf', 'unit': 'pcs', 'weight': 1.0},
    ];

    // --- 2. SEED PANTRY ITEMS ---
    final Map<String, int> pantryItemNameToId = {};

    final pantrySeed = [
      {
        'name': 'Chicken Breast',
        'qty': 1000,
        'unit': 'g',
        'staple': false,
        'gen': 'Chicken',
      },
      {
        'name': 'Ground Beef',
        'qty': 500,
        'unit': 'g',
        'staple': false,
        'gen': 'Beef',
      },
      {'name': 'Eggs', 'qty': 12, 'unit': 'pcs', 'staple': true, 'gen': 'Egg'},
      {
        'name': 'Salmon Fillet',
        'qty': 300,
        'unit': 'g',
        'staple': false,
        'gen': 'Salmon',
      },
      {
        'name': 'Shrimp',
        'qty': 200,
        'unit': 'g',
        'staple': false,
        'gen': 'Shrimp',
      },
      {
        'name': 'Spaghetti',
        'qty': 500,
        'unit': 'g',
        'staple': true,
        'gen': 'Spaghetti',
      },
      {
        'name': 'White Rice',
        'qty': 2000,
        'unit': 'g',
        'staple': true,
        'gen': 'White Rice',
      },
      {
        'name': 'Tortillas',
        'qty': 8,
        'unit': 'pcs',
        'staple': false,
        'gen': 'Tortilla',
      },
      {
        'name': 'Brown Rice',
        'qty': 1000,
        'unit': 'g',
        'staple': true,
        'gen': 'Brown Rice',
      },
      {
        'name': 'Bread Slices',
        'qty': 20,
        'unit': 'pcs',
        'staple': true,
        'gen': 'Bread',
      },
      {
        'name': 'Lasagna Noodles',
        'qty': 400,
        'unit': 'g',
        'staple': false,
        'gen': 'Lasagna Noodle',
      },
      {
        'name': 'Garlic',
        'qty': 5,
        'unit': 'pcs',
        'staple': true,
        'gen': 'Garlic',
      },
      {
        'name': 'Onion',
        'qty': 2,
        'unit': 'pcs',
        'staple': true,
        'gen': 'Onion',
      },
      {
        'name': 'Bell Peppers',
        'qty': 3,
        'unit': 'pcs',
        'staple': false,
        'gen': 'Bell Pepper',
      },
      {
        'name': 'Broccoli',
        'qty': 1,
        'unit': 'pcs',
        'staple': false,
        'gen': 'Broccoli',
      },
      {
        'name': 'Spinach',
        'qty': 200,
        'unit': 'g',
        'staple': false,
        'gen': 'Spinach',
      },
      {
        'name': 'Carrots',
        'qty': 5,
        'unit': 'pcs',
        'staple': true,
        'gen': 'Carrot',
      },
      {
        'name': 'Tomatoes',
        'qty': 6,
        'unit': 'pcs',
        'staple': false,
        'gen': 'Tomato',
      },
      {
        'name': 'Mushrooms',
        'qty': 200,
        'unit': 'g',
        'staple': false,
        'gen': 'Mushroom',
      },
      {
        'name': 'Zucchini',
        'qty': 3,
        'unit': 'pcs',
        'staple': false,
        'gen': 'Zucchini',
      },
      {
        'name': 'Olive Oil',
        'qty': 1000,
        'unit': 'ml',
        'staple': true,
        'gen': 'Olive Oil',
      },
      {
        'name': 'Soy Sauce',
        'qty': 250,
        'unit': 'ml',
        'staple': true,
        'gen': 'Soy Sauce',
      },
      {
        'name': 'Butter',
        'qty': 250,
        'unit': 'g',
        'staple': true,
        'gen': 'Butter',
      },
      {
        'name': 'Cheddar Cheese',
        'qty': 200,
        'unit': 'g',
        'staple': false,
        'gen': 'Cheddar Cheese',
      },
      {
        'name': 'Milk',
        'qty': 2000,
        'unit': 'ml',
        'staple': true,
        'gen': 'Milk',
      },
      {
        'name': 'Flour',
        'qty': 2000,
        'unit': 'g',
        'staple': true,
        'gen': 'Flour',
      },
      {
        'name': 'Sugar',
        'qty': 1000,
        'unit': 'g',
        'staple': true,
        'gen': 'Sugar',
      },
      {
        'name': 'Honey',
        'qty': 500,
        'unit': 'g',
        'staple': true,
        'gen': 'Honey',
      },
      {
        'name': 'Tomato Sauce',
        'qty': 800,
        'unit': 'ml',
        'staple': true,
        'gen': 'Tomato Sauce',
      },
      {
        'name': 'Coconut Milk',
        'qty': 0,
        'unit': 'ml',
        'staple': false,
        'gen': 'Coconut Milk',
      },
      {
        'name': 'Beef Steak',
        'qty': 0,
        'unit': 'g',
        'staple': false,
        'gen': 'Steak',
      },
      {
        'name': 'Mozzarella Cheese',
        'qty': 0,
        'unit': 'g',
        'staple': false,
        'gen': 'Mozzarella Cheese',
      },
      {
        'name': 'Baking Powder',
        'qty': 0,
        'unit': 'ml',
        'staple': false,
        'gen': 'Baking Powder',
      },
      {
        'name': 'Avocado',
        'qty': 0,
        'unit': 'pcs',
        'staple': false,
        'gen': 'Avocado',
      },
      {
        'name': 'Peanut Butter',
        'qty': 0,
        'unit': 'g',
        'staple': false,
        'gen': 'Peanut Butter',
      },
      {'name': 'Lime', 'qty': 0, 'unit': 'pcs', 'staple': false, 'gen': 'Lime'},
      {'name': 'Bun', 'qty': 0, 'unit': 'pcs', 'staple': false, 'gen': 'Bun'},
      {
        'name': 'Chocolate Snacks',
        'qty': 0,
        'unit': 'g',
        'staple': false,
        'gen': 'Chocolate',
      },
    ];

    // --- 3. SEED RECIPES ---
    final recipesSeed = [
      {
        'name': 'Garlic Butter Chicken',
        'tags': 'Quick, High Protein, Low Carb',
        'instr':
            '1. Dice chicken. 2. Sauté garlic in butter/oil. 3. Cook chicken until golden.',
        'ings': [
          {'name': 'Chicken Breast', 'qty': 500.0, 'unit': 'g'},
          {'name': 'Garlic', 'qty': 3.0, 'unit': 'pcs'},
          {'name': 'Butter', 'qty': 30.0, 'unit': 'g'},
          {'name': 'Olive Oil', 'qty': 35.5, 'unit': 'ml'},
        ],
      },
      {
        'name': 'Beef Tacos',
        'tags': 'Mexican, Family Style, Quick',
        'instr':
            '1. Brown beef with onions. 2. Warm tortillas. 3. Assemble with cheese.',
        'ings': [
          {'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g'},
          {'name': 'Tortillas', 'qty': 4.0, 'unit': 'pcs'},
          {'name': 'Onion', 'qty': 0.5, 'unit': 'pcs'},
          {'name': 'Cheddar Cheese', 'qty': 100.0, 'unit': 'g'},
        ],
      },
      {
        'name': 'Chicken & Broccoli Stir Fry',
        'tags': 'Asian, Healthy, One-Pan',
        'instr':
            '1. Slice chicken and broccoli. 2. Stir fry. 3. Add soy sauce.',
        'ings': [
          {'name': 'Chicken Breast', 'qty': 400.0, 'unit': 'g'},
          {'name': 'Broccoli', 'qty': 1.0, 'unit': 'pcs'},
          {'name': 'Soy Sauce', 'qty': 50.0, 'unit': 'ml'},
          {'name': 'White Rice', 'qty': 200.0, 'unit': 'g'},
        ],
      },
      {
        'name': 'Red Chicken Curry',
        'tags': 'Spicy, Thai, Hearty',
        'instr':
            '1. Simmer paste with coconut milk. 2. Add chicken and peppers.',
        'ings': [
          {'name': 'Chicken Breast', 'qty': 500.0, 'unit': 'g'},
          {'name': 'Coconut Milk', 'qty': 400.0, 'unit': 'ml'},
          {'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
        ],
      },
      {
        'name': 'Simple Spaghetti Aglio e Olio',
        'tags': 'Vegetarian, Italian, Pantry Staples',
        'instr': '1. Boil spaghetti. 2. Sauté garlic in oil. 3. Toss pasta.',
        'ings': [
          {'name': 'Spaghetti', 'qty': 250.0, 'unit': 'g'},
          {'name': 'Garlic', 'qty': 4.0, 'unit': 'pcs'},
          {'name': 'Olive Oil', 'qty': 60.0, 'unit': 'ml'},
        ],
      },
      {
        'name': 'Classic Steak and Peppers',
        'tags': 'High Protein, Dinner',
        'instr': '1. Sear steak. 2. Sauté peppers/onions. 3. Serve together.',
        'ings': [
          {'name': 'Beef Steak', 'qty': 400.0, 'unit': 'g'},
          {'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
          {'name': 'Onion', 'qty': 1.0, 'unit': 'pcs'},
          {'name': 'Butter', 'qty': 30.0, 'unit': 'g'},
        ],
      },
      {
        'name': 'Margherita Pizza',
        'tags': 'Italian, Vegetarian, Comfort',
        'instr': '1. Make dough. 2. Add sauce and mozzarella. 3. Bake at 450F.',
        'ings': [
          {'name': 'Tomato Sauce', 'qty': 200.0, 'unit': 'g'},
          {'name': 'Mozzarella Cheese', 'qty': 200.0, 'unit': 'g'},
          {'name': 'Flour', 'qty': 300.0, 'unit': 'g'},
          {'name': 'Olive Oil', 'qty': 35.5, 'unit': 'ml'},
        ],
      },
      {
        'name': 'Fluffy Pancakes',
        'tags': 'Breakfast, Quick, Family',
        'instr': '1. Mix dry. 2. Add wet. 3. Cook on medium heat.',
        'ings': [
          {'name': 'Flour', 'qty': 200.0, 'unit': 'g'},
          {'name': 'Eggs', 'qty': 2.0, 'unit': 'pcs'},
          {'name': 'Milk', 'qty': 250.0, 'unit': 'ml'},
          {'name': 'Baking Powder', 'qty': 20.0, 'unit': 'g'},
          {'name': 'Sugar', 'qty': 12.0, 'unit': 'g'},
        ],
      },
      {
        'name': 'Beef Chili',
        'tags': 'Hearty, Spicy, Freezer Friendly',
        'instr':
            '1. Brown beef with onions. 2. Add tomatoes and peppers. 3. Simmer.',
        'ings': [
          {'name': 'Ground Beef', 'qty': 500.0, 'unit': 'g'},
          {'name': 'Tomatoes', 'qty': 4.0, 'unit': 'pcs'},
          {'name': 'Onion', 'qty': 1.0, 'unit': 'pcs'},
          {'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
        ],
      },
      {
        'name': 'California Roll',
        'tags': 'Japanese, Healthy, Fun',
        'instr': '1. Cook sushi rice. 2. Roll nori with avocado and shrimp.',
        'ings': [
          {'name': 'White Rice', 'qty': 200.0, 'unit': 'g'},
          {'name': 'Avocado', 'qty': 1.0, 'unit': 'pcs'},
          {'name': 'Shrimp', 'qty': 100.0, 'unit': 'g'},
        ],
      },
      {
        'name': 'Classic Lasagna',
        'tags': 'Italian, Family Dinner, Make Ahead',
        'instr': '1. Layer noodles, beef, sauce. 2. Bake 45 mins at 375F.',
        'ings': [
          {'name': 'Ground Beef', 'qty': 600.0, 'unit': 'g'},
          {'name': 'Lasagna Noodles', 'qty': 12.0, 'unit': 'pcs'},
          {'name': 'Tomato Sauce', 'qty': 500.0, 'unit': 'g'},
          {'name': 'Cheddar Cheese', 'qty': 300.0, 'unit': 'g'},
        ],
      },
      {
        'name': 'Veggie Stir Fry',
        'tags': 'Vegan, Quick, Healthy',
        'instr': '1. Chop veggies. 2. High heat stir fry. 3. Add soy sauce.',
        'ings': [
          {'name': 'Broccoli', 'qty': 1.0, 'unit': 'pcs'},
          {'name': 'Bell Peppers', 'qty': 2.0, 'unit': 'pcs'},
          {'name': 'Soy Sauce', 'qty': 30.0, 'unit': 'ml'},
          {'name': 'Zucchini', 'qty': 2.0, 'unit': 'pcs'},
        ],
      },
      {
        'name': 'Chicken Quesadilla',
        'tags': 'Mexican, Quick, Kid Friendly',
        'instr': '1. Shred chicken. 2. Fill tortilla with cheese. 3. Pan fry.',
        'ings': [
          {'name': 'Chicken Breast', 'qty': 200.0, 'unit': 'g'},
          {'name': 'Cheddar Cheese', 'qty': 100.0, 'unit': 'g'},
          {'name': 'Tortillas', 'qty': 2.0, 'unit': 'pcs'},
          {'name': 'Onion', 'qty': 0.25, 'unit': 'pcs'},
        ],
      },
      {
        'name': 'Chicken Fried Rice',
        'tags': 'Asian, One Pan, Leftovers',
        'instr': '1. Stir fry chicken and rice. 2. Add soy and eggs.',
        'ings': [
          {'name': 'White Rice', 'qty': 300.0, 'unit': 'g'},
          {'name': 'Eggs', 'qty': 2.0, 'unit': 'pcs'},
          {'name': 'Chicken Breast', 'qty': 200.0, 'unit': 'g'},
          {'name': 'Soy Sauce', 'qty': 40.0, 'unit': 'ml'},
        ],
      },
      {
        'name': 'Veggie Omelette',
        'tags': 'Breakfast, Quick, High Protein',
        'instr': '1. Whisk eggs. 2. Sauté veggies. 3. Fold when set.',
        'ings': [
          {'name': 'Eggs', 'qty': 3.0, 'unit': 'pcs'},
          {'name': 'Spinach', 'qty': 50.0, 'unit': 'g'},
          {'name': 'Onion', 'qty': 0.25, 'unit': 'pcs'},
          {'name': 'Cheddar Cheese', 'qty': 30.0, 'unit': 'g'},
        ],
      },
    ];

    for (var data in genericNamesData) {
      final id = await db
          .into(db.genericNames)
          .insert(
            GenericNamesCompanion.insert(
              name: data['name'] as String,
              primaryUnit: data['unit'] as String,
              weightPerPiece: data['weight'],
            ),
          );
      genericNameToId[data['name'] as String] = id;
    }

    for (var item in pantrySeed) {
      final id = await db
          .into(db.pantry)
          .insert(
            PantryCompanion.insert(
              quantity: Value(item['qty'] as int),
              isStaple: Value(item['staple'] as bool),
              genericNameId: genericNameToId[item['gen']] as int,
            ),
          );
      pantryItemNameToId[item['name'] as String] = id;
    }

    for (var r in recipesSeed) {
      final recipeId = await db
          .into(db.recipes)
          .insert(
            RecipesCompanion.insert(
              name: r['name'] as String,
              tags: r['tags'] as String,
              instructions: r['instr'] as String,
            ),
          );

      final ingredients = r['ings'] as List<Map<String, dynamic>>;
      for (var ing in ingredients) {
        final pantryId = pantryItemNameToId[ing['name']];
        if (pantryId != null) {
          await db
              .into(db.recipeIngredients)
              .insert(
                RecipeIngredientsCompanion.insert(
                  recipeId: recipeId,
                  pantryId: pantryId,
                  quantityNeeded: ing['qty'] as double,
                  unit: ing['unit'] as String,
                ),
              );
        }
      }
    }
  });
}
