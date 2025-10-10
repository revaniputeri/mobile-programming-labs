# Layout Flutter - Jobsheet 5

**Mata Kuliah**: Pemograman Mobile  
**Program Studi**: D4 – Sistem Informasi Bisnis  
**Semester**: 5  
**Kelas**: SIB  
**NIM**: 2341760056  
**Nama**: Revani Nanda Putri  
**Jobsheet Ke-**: 5 (Flutter 2)  

---

## Laporan Jobsheet

### Praktikum Ke-5 (Membangun Navigasi di Flutter)

| Langkah | Jawaban/Deskripsi |
|---------|-------------------|
| 1 | buatlah sebuah project baru Flutter dengan nama belanja dan susunan folder seperti pada gambar berikut. Penyusunan ini dimaksudkan untuk mengorganisasi kode dan widget yang lebih mudah.<br><br>![Langkah 1-a](images/praktikum5_langkah1-a.png) <br><br>![Langkah 1-b](images/praktikum5_langkah1-b.png)|
| 2 | Buatlah dua buah file dart dengan nama home_page.dart dan item_page.dart pada folder pages. Untuk masing-masing file, deklarasikan class HomePage pada file home_page.dart dan ItemPage pada item_page.dart. Turunkan class dari StatelessWidget.<br><br>![Langkah 2-a](images/praktikum5_langkah2-a.png)<br><br>![Langkah 2-b](images/praktikum5_langkah2-b.png) |
| 3 | Mendefinisikan Route untuk kedua halaman tersebut. Definisi penamaan route harus bersifat unique. Halaman HomePage didefinisikan sebagai `/`. Dan halaman ItemPage didefinisikan sebagai `/item`. Untuk mendefinisikan halaman awal, anda dapat menggunakan `named argument initialRoute`. seperti kode berikut: 

**Code Implementation:**

**lib/main.dart**
```dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/item_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belanja',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/item': (context) => ItemPage(),
      },
    );
  }
}

``` 
|  |  |
|---------|-------------------|
| 4 | Buatlah sebuah file dengan nama `item.dart` dan letakkan pada folder models. Pada file ini didefinisikan pemodelan data yang dibutuhkan. Berikut contoh implementasinya:
**lib/models/item.dart**
```dart
class Item {
  String name;
  int price;

  Item({required this.name, required this.price});
}
```
|  |  |
|---------|-------------------|
| 5 | Pada halaman HomePage terdapat ListView widget. Sumber data ListView diambil dari model List dari object Item. Berikut contoh implementasinya:
**lib/models/item.dart**
```dart
class Item {
  String name;
  int price;

  Item({required this.name, required this.price});
}
```

|  |  |
|---------|-------------------|
| 6 | menampilkan ListView pada praktikum ini digunakan itemBuilder. Data diambil dari definisi model yang telah dibuat sebelumnya. Untuk menunjukkan batas data satu dan berikutnya digunakan widget Card. Berikut contoh implementasinya:
**lib/pages/home_page.dart**
```dart
import 'package:flutter/material.dart';
import '../models/item.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Item> items = [
    Item(name: 'Sugar', price: 5000),
    Item(name: 'Salt', price: 2000)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(child: Text(item.name)),
                    Expanded(
                      child: Text(
                        item.price.toString(),
                        textAlign: TextAlign.end,
                      ),
                    ), // Text
                  ], // Row
                ), // Container
              ), // Container
            ); // Card
          },
        ), // ListView.builder
      ), // Container
    );
  }
}
```
### Hasil:
![Hasil Praktikum 1](images/praktikum5_hasil1.png)
|  |  |
|---------|-------------------|
| 7 | Menambahkan navigasi pada ListView menggunakan widget InkWell. Wrap Card dengan InkWell dan tambahkan onTap untuk navigasi ke ItemPage dengan mengirim data item sebagai arguments. Berikut contoh implementasinya:
**lib/pages/home_page.dart**
```dart
return InkWell(
  onTap: () {
    Navigator.pushNamed(context, '/item', arguments: item);
  },
  child: Card(
    child: Container(
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: Text(item.name)),
          Expanded(
            child: Text(
              item.price.toString(),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    ),
  ),
);
```

**lib/pages/item_page.dart**
```dart
import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context)!.settings.arguments as Item;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Center(
        child: Text('${item.name} with ${item.price}'),
      ),
    );
  }
}
```
### Hasil:
![Hasil Praktikum 2](images/praktikum5_hasil2.png)