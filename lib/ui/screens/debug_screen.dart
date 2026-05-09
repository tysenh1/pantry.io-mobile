import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/services/database_service.dart';
import 'package:provider/provider.dart';
import '../../data/database/app_database.dart';

class DatabaseDebugScreen extends StatelessWidget {
  const DatabaseDebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<DatabaseService>().db;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DB Debugger'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            onPressed: () => _confirmNuke(context, db),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '--- RECIPES TABLE ---',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildRecipeList(db),
            const SizedBox(height: 20),
            const Text(
              '--- INGREDIENTS TABLE ---',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildIngredientList(db),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList(AppDatabase db) {
    return FutureBuilder(
      future: db.select(db.recipes).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        final items = snapshot.data!;
        return Column(
          children: items
              .map(
                (r) => ListTile(
                  title: Text(r.name),
                  subtitle: Text('ID: ${r.id} | Tags: ${r.tags}'),
                  isThreeLine: true,
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildIngredientList(AppDatabase db) {
    return FutureBuilder(
      future: db.select(db.recipeIngredients).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        final items = snapshot.data!;
        return Column(
          children: items
              .map(
                (i) => ListTile(
                  title: Text('RecipeID: ${i.recipeId}'),
                  subtitle: Text(
                    'PantryID: ${i.pantryId} | Qty: ${i.quantityNeeded} ${i.unit}',
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  void _confirmNuke(BuildContext context, AppDatabase db) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuke DB?'),
        content: const Text('This will delete everything from all tables.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Drift provides a simple way to delete all rows
              await db.delete(db.recipeIngredients).go();
              await db.delete(db.recipes).go();
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text(
              'Delete All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
