import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'api.dart';
import 'model.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '安買高売',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Noto Sans JP",
      ),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('仮想通貨の現在売買値'),
      ),
      body: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 24,),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("下記の現在地を表示しています。"),
                Text("　・通貨ペア(BTC/USDT,ETH/USDT,XRP/USDT,BNB/USDT)の現在値"),
                Text("　・現在で売買した時の利益金額"),
                Text("　※基軸通貨には、USDTを選んでいます。(JPY(日本円)がわかりやすいですが、業者が国内に限られてしまうので。)"),
                Text('\n\n手数料一覧', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text(""))        ,Padding(padding: EdgeInsets.all(4.0),child: Text("着金")),Padding(padding: EdgeInsets.all(4.0),child: Text("送金[USDT]"))         ,Padding(padding: EdgeInsets.all(4.0),child: Text("送金[BTC]"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("送金[ETH]"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("送金[XRP]")),Padding(padding: EdgeInsets.all(4.0),child: Text("送金[BNB]"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("買い[%]")),Padding(padding: EdgeInsets.all(4.0),child: Text("売り[%]")),]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Binance")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("1(TRC20)\n15(ERC20)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.00057(BTC)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.003(BEP20)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.25(XRP)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.0005(BEP20)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("FTX"))     ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))                  ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))        ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))            ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.07"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.07"))   ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("1(TRC20)\n20(ERC20)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.0006(BTC)")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.004(ERC20)")),Padding(padding: EdgeInsets.all(4.0),child: Text("0.2(XRP)")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.02(BEP20)"))  ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Bitstamp")),Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("2.5"))                ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.0005"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.0035"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.02"))     ,Padding(padding: EdgeInsets.all(4.0),child: Text("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.5"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.5"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Poloniex")),Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))                  ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))        ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))            ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.155"))  ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.155"))  ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Bittrex")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("69"))                 ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.0003"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.0137"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("1"))        ,Padding(padding: EdgeInsets.all(4.0),child: Text("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.35"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.35"))   ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("OKEx"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.88(ERC20)"))        ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.0004"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.003"))       ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: Text("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: Text("0(TRC20)\n5(ERC20)")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.0007"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.01"))        ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.25"))     ,Padding(padding: EdgeInsets.all(4.0),child: Text("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("0.1"))    ,]),
                          ],),
                      ),
                      /* \u{2252}...≒ */
                      Text('※0.0005[BTC]\u{2252}2,000(円)　※0.003[ETH]\u{2252}1,030(円)　※0.2[XRP]\u{2252}18(円)　※0.02[BNB]\u{2252}780(円)',),
                    ],
                  ),
                ),
                Text('\n\n通貨ペアの現在値', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: _AskBidTable(),
                      ),
                      /* \u{2252}...≒ */
                      Text('※0.0005[BTC]\u{2252}2,000(円)　※0.003[ETH]\u{2252}1,030(円)　※0.2[XRP]\u{2252}18(円)　※0.02[BNB]\u{2252}780(円)',),
                    ],
                  ),
                ),
              ]
            ),
        ),
      ),
    );
  }
}

final FutureProviderFamily askbidProvider = FutureProvider.family<Map<Symbol, AskBidDataforTbl>, BrokerId>((ref, bid) {
  return GetTicker(bid);
});

class _AskBidTable extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final AskBidsbi = useProvider(askbidProvider(BrokerId.bi));
    final AskBidsfx = useProvider(askbidProvider(BrokerId.fx));
    final AskBidskc = useProvider(askbidProvider(BrokerId.kc));
    final AskBidsbs = useProvider(askbidProvider(BrokerId.bs));
    final AskBidspn = useProvider(askbidProvider(BrokerId.pn));
    final AskBidsbt = useProvider(askbidProvider(BrokerId.bt));
    final AskBidsex = useProvider(askbidProvider(BrokerId.ex));
    final AskBidslq = useProvider(askbidProvider(BrokerId.lq));

    return Table(
      border: TableBorder.all(),
      /* Riverpod で状態管理を行う */
      children: [
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("通貨ペア")),Padding(padding: EdgeInsets.all(4.0),child: Text("BTC/USDT")),Text("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: Text("ETH/USDT")) ,Text("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: Text("XRP/USDT")) ,Text("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: Text("BNB/USDT")),Text("")                                                ,]),
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("業者"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: Text("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: Text("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: Text("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: Text("Ask")),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Binance")) ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbi.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("FTX"))     ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsfx.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidskc.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Bitstamp")),Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbs.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Poloniex")),Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidspn.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Bittrex")) ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsbt.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("OKEx"))    ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidsex.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: Text("Liquid"))  ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: Text(AskBidslq.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
    ],);
  }
}