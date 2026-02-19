import 'package:flutter/material.dart';

// bikin komponen app bar custom sebenernya ada bawaan dari flutter tapi disini aku mau bikin
// secara manual 
class MyAppBar extends StatelessWidget{
  const MyAppBar({required this.title, super.key});
  
  // field di dalam Widget subclass wajib di pakai "final"
  // ini kaya jadi property object yang dipanggil buat diisi valuenya
  final Widget title;
  
  // udah pasti harus overide bawaan nya udah kaya gitu code isi nanti didalam build 
  @override
  Widget build(BuildContext context) {
    // sistem container itu kaya div di html dengan tinggi 56 pixel dan padding 
    // aturan padding pakai edgeinset jadi kaya bilang "aku mau bikin inset vertikal dan horizontal offset"
    // dengan ketentuan by default margin atas bawah nya 8 pixel dan tidak ada kanan kiri
    // karena itu aku atur jadi horizontal nya kanan kiri 8 pixel
    return Container(
      height: 56, //satuan pixel
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // child itu kaya ngatur "isi dari container"
      // row itu horizontal itungannya kaya display flex jadi kaya bilang
      // "eh isi dari container ini bakalan ditata secara 1 baris (row)
      // yang terdiri dari button icon,title,icon button buat search"
      // expanded itu kaya bilang "eh aku mau komponen ini buat ngambil semua sisa ruang sebelum icon search"
      child: Row(
        children: [
          const IconButton(
            onPressed: null, //null sama aja kaya disabled button 
            icon: Icon(Icons.menu),
            tooltip: "Navigation Menu", //tooltip itu hint pas di hover
            ),
            Expanded(child: title),
            const IconButton(
              onPressed: null, 
              icon: Icon(Icons.search),
              tooltip: "Search",
            )
        ],
      ),
    );
  }
}

// kerangka custom untuk halaman nya
class MyScaffold extends StatelessWidget{
  const MyScaffold({super.key});
  @override
  Widget build(BuildContext context) {
    // kaya jadi "alas kertas" kalo gapake Material biasanya layoutingnya bakalan aneh ibaratnya 
    // kita set "tema alas kertasnya" itu
    // nah didalam "alas kertas" itu kita isi dengan AppBar yang kita bangun, lalu dibawahnya 
    // diisi text rata tengah "hello world" pakai expanded biar komponen ini "ngabisin" seluruh sisa layar dibawah AppBar
    // dan berbeda dengan Row kaya diatas disini pakai collum mirip kaya display flex disusun dari atas kebawah 
    return Material(
      child: Column(
        children: [
          MyAppBar(
            title:Text(
              "Example Title",
              style: Theme.of(context).primaryTextTheme.titleLarge, //sttling pakai tema bawaan Material
              )
            ),
            Expanded(child: Center(child: Text("Hello World")))
        ],
      ),
    );    
  }
  
}

// main entry jantung app
void main() {
  // wajib ada 
  runApp(
    // MaterialApp itu pembungkus besar, dia yang ngatur navigasi, tema warna, dan bahasa
    // ada title digunakan untuk kebutuhan perpindahan OS senangkepku,
    // ada home buat "isinya" dan pakai SafeArea buat kebutuhan nanti kalo dimobile layoutingnya ga nabrak
    // sama notch kamera atau bar indikator di hp di web emang ga terlalu keliatan tapi di mobile bakalan ngaruh
    const MaterialApp(
      title: "My App", 
      home: SafeArea(child: MyScaffold()), 
    )
  );
}

