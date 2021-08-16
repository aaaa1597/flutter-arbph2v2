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
        title: SelectableText('仮想通貨の現在売買値'),
      ),
      body: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 24,),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SelectableText("下記の現在地を表示しています。"),
                SelectableText("　・通貨ペア(BTC/USDT,ETH/USDT,XRP/USDT,BNB/USDT)の現在値"),
                SelectableText("　・現在で売買した時の利益金額"),
                SelectableText("　※基軸通貨には、USDTを選んでいます。(JPY(日本円)がわかりやすいですが、業者が国内に限られてしまうので。)"),
                SelectableText('\n\n手数料一覧', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText(""))        ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("着金")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("送金[USDT]"))         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("送金[BTC]"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("送金[ETH]"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("送金[XRP]")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("送金[BNB]"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("買い[%]")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("売り[%]")),]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Binance")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("1(TRC20)\n15(ERC20)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.00057(BTC)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.003(BEP20)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.25(XRP)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0005(BEP20)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("FTX"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))                  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))        ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))            ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.07"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.07"))   ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("1(TRC20)\n20(ERC20)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0006(BTC)")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.004(ERC20)")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.2(XRP)")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.02(BEP20)"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bitstamp")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("2.5"))                ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0005"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0035"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.02"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.5"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.5"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Poloniex")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))                  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))           ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))        ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))            ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.155"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.155"))  ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bittrex")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("69"))                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0003"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0137"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("1"))        ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.35"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.35"))   ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("OKEx"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.88(ERC20)"))        ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0004"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.003"))       ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,]),
                            TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0(TRC20)\n5(ERC20)")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.0007"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.01"))        ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.25"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("---"))          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("0.1"))    ,]),
                          ],),
                      ),
                      /* \u{2252}...≒ */
                    ],
                  ),
                ),
                SelectableText('※0.0005[BTC]\u{2252}2,000(円)　※0.003[ETH]\u{2252}1,030(円)　※0.2[XRP]\u{2252}18(円)　※0.02[BNB]\u{2252}780(円)',),
                SelectableText('\n\n通貨ペアの現在値', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: _AskBidTable(),
                      ),
                    ],
                  ),
                ),
                SelectableText('※"***":市場なし',),
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
  Widget build(BuildContext conSelectableText) {
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
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("通貨ペア")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("BTC/USDT")),SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("ETH/USDT")) ,SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("XRP/USDT")) ,SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("BNB/USDT")),SelectableText("")                                                ,]),
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("業者"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Binance")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbi.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("FTX"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsfx.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidskc.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bitstamp")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbs.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbs.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbs.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbs.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbs.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbs.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Poloniex")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.BNB_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidspn.when(data: (ret) => ret[Symbol.BNB_USDT].askstr, loading: () => '...', error: (e, stack) => '---'))),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bittrex")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbt.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbt.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbt.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbt.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbt.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsbt.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("OKEx"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsex.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsex.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsex.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsex.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsex.when(data: (ret) => ret[Symbol.XRP_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidsex.when(data: (ret) => ret[Symbol.XRP_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Liquid"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidslq.when(data: (ret) => ret[Symbol.BTC_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidslq.when(data: (ret) => ret[Symbol.BTC_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidslq.when(data: (ret) => ret[Symbol.ETH_USDT].bidstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(AskBidslq.when(data: (ret) => ret[Symbol.ETH_USDT].askstr, loading: () => '...', error: (e, stack) => '---')))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                         ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
    ],);
  }
}