import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '安買高売',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: '仮想通貨の現在売買値'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Table(
              border: TableBorder.all(),
              children: [TableRow(children: [Text("")        ,Text("着金") ,Text("送金[USDT]")         ,Text("送金[BTC]")    ,Text("送金[ETH]")    ,Text("送金[XRP]") ,Text("送金[BNB]")    ,Text("買い[%]"),Text("売り[%]"),]),
                         TableRow(children: [Text("Binance") ,Text("0")   ,Text("1(TRC20)\n15(ERC20)"),Text("0.00057(BTC)"),Text("0.003(BEP20)"),Text("0.25(XRP)"),Text("0.0005(BEP20)"),Text("0.1")   ,Text("0.1")   ,]),
                         TableRow(children: [Text("FTX")     ,Text("0")   ,Text("0")                  ,Text("0")           ,Text("0")           ,Text("0")        ,Text("0")            ,Text("0.07")  ,Text("0.07")  ,]),
                         TableRow(children: [Text("KuCoin")  ,Text("0")   ,Text("1(TRC20)\n20(ERC20)"),Text("0.0006(BTC)") ,Text("0.004(ERC20)"),Text("0.2(XRP)") ,Text("0.02(BEP20)")  ,Text("0.1")   ,Text("0.1")   ,]),
                         TableRow(children: [Text("Bitstamp"),Text("0")   ,Text("	2.5")               ,Text("0.0005")      ,Text("0.0035")      ,Text("0.02")     ,Text("---")          ,Text("0.5")   ,Text("0.5")   ,]),
                         TableRow(children: [Text("Poloniex"),Text("0")   ,Text("0")                  ,Text("0")           ,Text("0")           ,Text("0")        ,Text("0")            ,Text("0.155") ,Text("0.155") ,]),
                         TableRow(children: [Text("Bittrex") ,Text("0")   ,Text("69")                 ,Text("0.0003")      ,Text("0.0137")      ,Text("1")        ,Text("---")          ,Text("0.35")  ,Text("0.35")  ,]),
                         TableRow(children: [Text("OKEx")    ,Text("0")   ,Text("0.88(ERC20)")        ,Text("0.0004")      ,Text("0.003")       ,Text("0.1")      ,Text("---")          ,Text("0.1")   ,Text("0.1")   ,]),
                         TableRow(children: [Text("KuCoin")  ,Text("0")   ,Text("0(TRC20)\n5(ERC20)") ,Text("0.0007")      ,Text("0.01")        ,Text("0.25")     ,Text("---")          ,Text("0.1")   ,Text("0.1")   ,]),
                        ],),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
