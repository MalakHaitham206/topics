// pages/home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
            SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blue[700],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Provider Test App',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue[700]!,
                      Colors.blue[500]!,
                      Colors.cyan[400]!,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.flutter_dash,
                    size: 80,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
           
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate([
                _buildFeatureCard(
                  context,
                  'Counter',
                  'state management with provider',
                  Icons.add_circle_outline,
                  Colors.green,
                  '/counter',
                ),
                _buildFeatureCard(
                  context,
                  'Todo List',
                  'Complex list management with CRUD operations',
                  Icons.checklist,
                  Colors.orange,
                  '/todo',
                ),
                _buildFeatureCard(
                  context,
                  'Shopping Cart',
                  'E-commerce cart with quantity management',
                  Icons.shopping_cart,
                  Colors.purple,
                  '/cart',
                ),
                _buildFeatureCard(
                  context,
                  'User Profile',
                  'Form handling and profile management',
                  Icons.person,
                  Colors.teal,
                  '/profile',
                ),
                _buildFeatureCard(
                  context,
                  'Theme Settings',
                  'Global theme and preferences',
                  Icons.palette,
                  Colors.pink,
                  '/settings',
                ),
                _buildFeatureCard(
                  context,
                  'Form Validation',
                  'Complex form with validation states',
                  Icons.assignment,
                  Colors.indigo,
                  '/form',
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String route,
  ) {
    return Card(
      
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
   
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}