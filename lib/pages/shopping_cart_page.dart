// import 'package:flutter/material.dart';
// import '../models/app_models.dart';

// class ShoppingCartPage extends StatefulWidget {
//   const ShoppingCartPage({super.key});

//   @override
//   State<ShoppingCartPage> createState() => _ShoppingCartPageState();
// }

// class _ShoppingCartPageState extends State<ShoppingCartPage> {
//   final ShoppingCartModel cartModel = ShoppingCartModel();
  
//   final List<Product> availableProducts = [
//     Product(
//       id: '1',
//       name: 'Wireless Headphones',
//       price: 99.99,
//       image: '🎧',
//       description: 'High-quality wireless headphones with noise cancellation',
//     ),
//     Product(
//       id: '2',
//       name: 'Smartphone',
//       price: 699.99,
//       image: '📱',
//       description: 'Latest smartphone with advanced features',
//     ),
//     Product(
//       id: '3',
//       name: 'Laptop',
//       price: 1299.99,
//       image: '💻',
//       description: 'Powerful laptop for work and gaming',
//     ),
//     Product(
//       id: '4',
//       name: 'Smart Watch',
//       price: 299.99,
//       image: '⌚',
//       description: 'Fitness tracking smartwatch with GPS',
//     ),
//     Product(
//       id: '5',
//       name: 'Tablet',
//       price: 449.99,
//       image: '📲',
//       description: 'Large screen tablet for productivity',
//     ),
//     Product(
//       id: '6',
//       name: 'Wireless Mouse',
//       price: 49.99,
//       image: '🖱️',
//       description: 'Ergonomic wireless mouse',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shopping Cart'),
//         backgroundColor: Colors.purple[600],
//         foregroundColor: Colors.white,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.shopping_cart),
//                 onPressed: () => _showCartDialog(),
//               ),
//               if (cartModel.itemCount > 0)
//                 Positioned(
//                   right: 8,
//                   top: 8,
//                   child: Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 16,
//                       minHeight: 16,
//                     ),
//                     child: Text(
//                       '${cartModel.itemCount}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ), 
//                 ),
//             ],  
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: availableProducts.length,
//         itemBuilder: (context, index) {
//           final product = availableProducts[index];
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: ListTile(
//               leading: CircleAvatar(
//                 child: Text(product.image, style: const TextStyle(fontSize: 24)),
//               ),
//               title: Text(product.name),
//               subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//               trailing: IconButton(
//                 icon: const Icon(Icons.add_shopping_cart),
//                 onPressed: () {
//                   setState(() {
//                     cartModel.addItem(product);
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('${product.name} added to cart')),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showCartDialog(),
//         child: const Icon(Icons.shopping_cart),
//         backgroundColor: Colors.purple[600],
//       ),
//     );
//   }
//   void _showCartDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Shopping Cart'),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: ListView.builder(
//               itemCount: cartModel.items.length,
//               itemBuilder: (context, index) {
//                 final item = cartModel.items[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     child: Text(item.image, style: const TextStyle(fontSize: 24)),
//                   ),
//                   title: Text(item.name),
//                   subtitle: Text('\$${item.price.toStringAsFixed(2)} x ${item.quantity}'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.remove_circle),
//                     onPressed: () {
//                       setState(() {
//                         cartModel.removeItem(item.id);
//                       });
//                       Navigator.of(context).pop();
//                       _showCartDialog();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle checkout logic here
//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Checkout not implemented')),
//                 );
//               },
//               child: const Text('Checkout'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   void dispose() {
//     // Clean up resources if needed
//     super.dispose();
//   }}










