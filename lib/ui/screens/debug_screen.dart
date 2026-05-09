import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/services/database_service.dart';
import 'package:provider/provider.dart';

class DatabaseDebugScreen extends StatefulWidget {
  const DatabaseDebugScreen({super.key});

  @override
  State<DatabaseDebugScreen> createState() => _DatabaseDebugScreenState();
}

class _DatabaseDebugScreenState extends State<DatabaseDebugScreen> {
  // A simple key to force the FutureBuilders to reset
  int _refreshKey = 0;

  void _refresh() {
    setState(() {
      _refreshKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<DatabaseService>().db;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DB Debugger'),
        actions: [
          // THE REFRESH BUTTON
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Re-run Queries',
            onPressed: _refresh,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            onPressed: () => _confirmNuke(context, db),
          ),
        ],
      ),
      body: SingleChildScrollView(
        key: ValueKey(_refreshKey), // Forces the whole list to rebuild
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '--- RECIPES TABLE ---',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildRecipeList(db),
            const SizedBox(height: 30),
            const Text(
              '--- INGREDIENTS TABLE ---',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildIngredientList(db),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList(AppDatabase db) {
    return FutureBuilder(
      // The key change: FutureBuilder runs whenever the 'future' changes
      future: db.select(db.recipes).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const LinearProgressIndicator();
        if (!snapshot.hasData || snapshot.data!.isEmpty)
          return const Text("No recipes found.");

        return Column(
          children: snapshot.data!
              .map(
                (r) => Card(
                  child: ListTile(
                    title: Text(r.name),
                    subtitle: Text('ID: ${r.id} | Tags: ${r.tags ?? "None"}'),
                  ),
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
        if (snapshot.connectionState == ConnectionState.waiting)
          return const LinearProgressIndicator();
        if (!snapshot.hasData || snapshot.data!.isEmpty)
          return const Text("No ingredients found.");

        return Column(
          children: snapshot.data!
              .map(
                (i) => Card(
                  color: Colors.grey[100],
                  child: ListTile(
                    title: Text('Recipe ID: ${i.recipeId}'),
                    subtitle: Text(
                      'Pantry ID: ${i.pantryId} | Qty: ${i.quantityNeeded} ${i.unit}',
                    ),
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
        content: const Text('This will delete everything from the tables.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await db.delete(db.recipeIngredients).go();
              await db.delete(db.recipes).go();
              _refresh(); // Refresh UI after delete
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

