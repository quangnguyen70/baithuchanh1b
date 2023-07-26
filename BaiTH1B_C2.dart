import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Product',
      initialRoute: '/',
      routes: {
        '/': (context) => ProductListScreen(),
        '/productDetail': (context) => const ProductDetailScreen(),
      },
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Lamborghini Aventador SVJ ', 'imageURL': 'https://danviet.mediacdn.vn/296231569849192448/2022/3/24/bo-mercedes-amg-g63-truong-quynh-anh-chon-lamborghini-hon-50-ty-1648089046840-16480890506961476451376.png', 'price':2.500000000 },
    {'name': 'Lamborghini Aventador S Taiwan Edition ', 'imageURL': 'https://img.tinxe.vn/crop/1200x675/2020/01/24/95ywCUPr/avatar-54c6.jpg','price':58},
    {'name': 'Lamborghini Aventador SVJ Roadster', 'imageURL': 'https://photo-cms-kienthuc.epicdn.me/w730/Uploaded/2023/mdfvkxlkxr/2023_05_08/7/lamborghini-aventador-svj-roadster-mau-sieu-doc-la-ve-viet-nam-Hinh-3.png','price':13.2},
  ];

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              products[index]['imageURL'],
              width: 2 * MediaQuery.of(context).size.width / 15, // set chiều rộng ảnh bằng 2/5 chiều rộng của màn hình
              height: 2 * MediaQuery.of(context).size.width / 15, // set chiều cao ảnh bằng 2/5 chiều rộng của màn hình
            ),
            title: Text(products[index]['name']),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/productDetail',
                arguments: products[index],
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Chi tiết sản phẩm: ${product['name']}', style: const TextStyle(fontSize: 18),),
            const SizedBox(height: 20),
            Text('Giá: \$${product['price']}', style: const TextStyle(fontSize: 18),),
            const SizedBox(height: 20),
            Image.network(
              product['imageURL'], // Use the image URL from the selected product
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
