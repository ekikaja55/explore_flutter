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

// bikin komponen button manual
class MyButton extends StatelessWidget{
  const MyButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("My Button was tapped");
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightGreen[500],
        ),
       child: const Center(child: Text("Engage"),), 
      ),
    );
  }
}

// komponen class statefull untuk button counter
// setup state counter btn pakai statefull 

// Penjelasan "Satu Paket" Stateful Widget
// Bayangkan StatefulWidget itu seperti sebuah Remote TV:
// CounterBtn (Widget): Ini adalah fisiknya (plastik remotnya). Ini yang kamu panggil di kode lain.
// _CounterState (State): Ini adalah mesin di dalamnya (baterai dan chip).
//  Dia yang menyimpan data angka dan melakukan perubahan.
class CounterBtn extends StatefulWidget{
  const CounterBtn({super.key});
  // @override
  // State<StatefulWidget> createState() {
  //   return _CounterState();
  // }
  @override
  State<StatefulWidget> createState()=>_CounterState();
}

// setup statenya
class _CounterState extends State<CounterBtn>{
  int _counter = 0;

  void _increment(){
    setState(() {
      _counter++;
      print("increment v1 ke triger, _counter:$_counter");

    });
  }

  void _decrement(){
    setState(() {
      _counter--;
      print("decrement v1 ke triger, _counter:$_counter");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // konsepnya sama kaya TS, jadi kalo di define <Widget> sama kaya ngunci kalo type didalam children ini
      // cuma boleh widget
      // children itu buat banyak widget child itu cuma buat satu aja tergantung konteks mau pakai pembungkus apa
      children: <Widget>[
        ElevatedButton(onPressed: _increment, child: const Text("Increment V1")),
        const SizedBox(width: 16),
        ElevatedButton(onPressed: _decrement, child: const Text("Decrement V2")),
        const SizedBox(width: 16),
        Text("Count: $_counter")
      ],
    );
  }
  
}

// dibawah ini adalah variasi handling state lebih reusable dan profesional dengan memisahkan 
// menjadi 3 widget kecil 
// CounterDisplay -> cuma untuk nampilin display
// CounterIncrementator -> cuma untuk jadi tombol, dia tidak tau angka berapa yang sedang di tampilankan
// Counter -> sebagai "otak" handling state nya 

class CounterDisplay extends StatelessWidget{
  const CounterDisplay({required this.count,super.key});
  final int count;
  @override
  Widget build(BuildContext context) {
   return Text("Count : $count");
  }
}

class CounterIncrementator extends StatelessWidget{
  const CounterIncrementator({required this.onPressed,super.key});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: onPressed, 
    child: const Text("Increment V2")
    );
  }
} 

class CounterDecrementator extends StatelessWidget{
  const CounterDecrementator({required this.onPressed,super.key});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: onPressed, 
    child: const Text("Decrement V2")
    );
  }
} 

class CounterBtnV2 extends StatefulWidget{
  const CounterBtnV2({super.key});
  
  @override
  State<StatefulWidget> createState() => _CounterStateV2();
}

class _CounterStateV2 extends State<CounterBtnV2>{
  int _counter = 0;

  void _increment(){
    setState(() {
      ++_counter;
      print("increment v2 ke triger, _counter:$_counter");
    });
  }

  void _decrement(){
    setState(() {
      --_counter;
      print("decrement v2 ke triger, _counter:$_counter");

    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CounterIncrementator(onPressed: _increment),
        const SizedBox(width: 16),
        CounterDecrementator(onPressed: _decrement),
        const SizedBox(width: 16),
        CounterDisplay(count: _counter)
      ],
    ); 
  }
  
}

// bikin komponen app bar + body didalam scaffold bedanya ini pakai komponen dari flutter nya
// const tidak boleh berisi fungsi
class TutorialHome extends StatelessWidget{
  const TutorialHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          onPressed: (){
            print("btn navigasi ditekan");
          }, 
          icon: Icon(Icons.menu),
          tooltip: "Navigation Home",
          ),
          title: const Text('Example Title'),
          actions: [
            IconButton(
              onPressed: (){
                print("btn search ditekan");
              }, 
              icon: Icon(Icons.search),
              tooltip: "Search",
            )
          ],
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(20.0),//kasih padding defaultnya 8 pixel semua sisi disini aku atur 20 pixel
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(child: Text("hello world")),
           
            const SizedBox(height: 20),// jeda antara teks dengan MyButton
              // agar MyButton tidak selebar layar, bungkus dengan Center dikombo SizedBox
            const Center(
              child: SizedBox(
                width: 200,
                child: MyButton(),
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Center(
              child: SizedBox(
                width: 400,
                child: CounterBtn() , //panggil statefull widget nya BUKAN STATENYA LANGSUNG
              ),
            ),

            const SizedBox(height: 20),
             const Center(
              child: SizedBox(
                width: 400,
                child: CounterBtnV2(),//panggil statefull widget nya BUKAN STATENYA LANGSUNG
              ),
            ),
          ],
        ),
        ),
        //FAB
      floatingActionButton: FloatingActionButton(
                            onPressed: (){
                              print("FAB ditekan");
                            },
                            tooltip: "add",
                            child: Icon(Icons.add),
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
    
    // const MaterialApp(
    //   title: "My App", 
    //   home: SafeArea(child: MyScaffold()), 
    // )

    const MaterialApp(
      debugShowCheckedModeBanner: false,//buat ngilagin label "debug"
      title: "My App", 
      home: TutorialHome(), 
    )
  );
}

