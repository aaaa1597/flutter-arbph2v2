import 'dart:async';
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
                /* 概要 */
                SelectableText("下記の現在地を表示しています。"),
                SelectableText("　・通貨ペア(BTC/USDT,ETH/USDT,XRP/USDT,BNB/USDT)の現在値"),
                SelectableText("　・現在で売買した時の利益金額"),
                SelectableText("　※基軸通貨には、USDTを選んでいます。(JPY(日本円)がわかりやすいですが、業者が国内に限られてしまうので。)"),
                SelectableText('\n\n手数料一覧', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                /* 手数料一覧 */
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
                /* 仮想通貨の現在値 */
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
                /* 見込み利益(BTC/USDT) */
                SelectableText('\n\n見込み利益(BTC/USDT)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: _ExpectedProfitTable(),
                      ),
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

/* 10sタイマ発火を受けて値更新 */
final StateProvider<int> timeoutEventProvider = StateProvider<int>((ref) => 0);

/* Ask/Bid取得(非同期) */
final FutureProviderFamily askbidProvider = FutureProvider.family<Map<Symbol, AskBidDataforTbl>, BrokerId>((ref, bid) {
  ref.watch(timeoutEventProvider);
  return GetTicker(bid);
});

class _AskBidTable extends HookWidget {
  @override
  Widget build(BuildContext context) {
    /* 10sタイマ起動 */
    useEffect((){ Timer.periodic(Duration(seconds: 10),(timer){
      print('10sタイマ発火--------' + DateTime.now().toString());
      context.read(timeoutEventProvider).state++;
    },); }, const []);

    final AskBidsbi = useProvider(askbidProvider(BrokerId.bi));
    final AskBidsfx = useProvider(askbidProvider(BrokerId.fx));
    final AskBidskc = useProvider(askbidProvider(BrokerId.kc));
    final AskBidsbs = useProvider(askbidProvider(BrokerId.bs));
    final AskBidspn = useProvider(askbidProvider(BrokerId.pn));
    final AskBidsbt = useProvider(askbidProvider(BrokerId.bt));
    final AskBidsex = useProvider(askbidProvider(BrokerId.ex));
    final AskBidslq = useProvider(askbidProvider(BrokerId.lq));

    final retAskBidsbi = AskBidsbi.when(data: (ret) => ret, loading: () => loadingret[BrokerId.bi], error: (e, stack) => errret[BrokerId.bi]);
    final retAskBidsfx = AskBidsfx.when(data: (ret) => ret, loading: () => loadingret[BrokerId.fx], error: (e, stack) => errret[BrokerId.fx]);
    final retAskBidskc = AskBidskc.when(data: (ret) => ret, loading: () => loadingret[BrokerId.kc], error: (e, stack) => errret[BrokerId.kc]);
    final retAskBidsbs = AskBidsbs.when(data: (ret) => ret, loading: () => loadingret[BrokerId.bs], error: (e, stack) => errret[BrokerId.bs]);
    final retAskBidspn = AskBidspn.when(data: (ret) => ret, loading: () => loadingret[BrokerId.pn], error: (e, stack) => errret[BrokerId.pn]);
    final retAskBidsbt = AskBidsbt.when(data: (ret) => ret, loading: () => loadingret[BrokerId.bt], error: (e, stack) => errret[BrokerId.bt]);
    final retAskBidsex = AskBidsex.when(data: (ret) => ret, loading: () => loadingret[BrokerId.ex], error: (e, stack) => errret[BrokerId.ex]);
    final retAskBidslq = AskBidslq.when(data: (ret) => ret, loading: () => loadingret[BrokerId.lq], error: (e, stack) => errret[BrokerId.lq]);

    return Table(
      border: TableBorder.all(),
      /* Riverpod で状態管理を行う */
      children: [
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("通貨ペア")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("BTC/USDT")),SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("ETH/USDT")) ,SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("XRP/USDT")) ,SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("BNB/USDT")),SelectableText("")                                                ,]),
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("業者"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Binance")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BNB_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("FTX"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BNB_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BNB_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bitstamp")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Poloniex")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BNB_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bittrex")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("OKEx"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.XRP_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.XRP_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Liquid"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.BTC_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.BTC_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.ETH_USDT].bidstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.ETH_USDT].askstr))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
                                                                                                   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
    ],);
  }
}

class _ExpectedProfitTable extends HookWidget {
  @override
  Widget build(BuildContext context) {
    /* 10sタイマ起動 */
    useEffect((){ Timer.periodic(Duration(seconds: 10),(timer){
      print('10sタイマ発火--------' + DateTime.now().toString());
      context.read(timeoutEventProvider).state++;
    },); }, const []);

    final AskBidsbi = useProvider(askbidProvider(BrokerId.bi));
    final AskBidsfx = useProvider(askbidProvider(BrokerId.fx));
    final AskBidskc = useProvider(askbidProvider(BrokerId.kc));
    final AskBidsbs = useProvider(askbidProvider(BrokerId.bs));
    final AskBidspn = useProvider(askbidProvider(BrokerId.pn));
    final AskBidsbt = useProvider(askbidProvider(BrokerId.bt));
    final AskBidsex = useProvider(askbidProvider(BrokerId.ex));
    final AskBidslq = useProvider(askbidProvider(BrokerId.lq));

    final retAskBidsbi = AskBidsbi.when(data: (ret) => ret, loading: () => loadingret[BrokerId.bi], error: (e, stack) => errret[BrokerId.bi]);
    final retAskBidsfx = AskBidsfx.when(data: (ret) => ret, loading: () => loadingret[BrokerId.fx], error: (e, stack) => errret[BrokerId.fx]);
    final retAskBidskc = AskBidskc.when(data: (ret) => ret, loading: () => loadingret[BrokerId.kc], error: (e, stack) => errret[BrokerId.kc]);
    final retAskBidsbs = AskBidsbs.when(data: (ret) => ret, loading: () => loadingret[BrokerId.bs], error: (e, stack) => errret[BrokerId.bs]);
    final retAskBidspn = AskBidspn.when(data: (ret) => ret, loading: () => loadingret[BrokerId.pn], error: (e, stack) => errret[BrokerId.pn]);
    final retAskBidsbt = AskBidsbt.when(data: (ret) => ret, loading: () => loadingret[BrokerId.bt], error: (e, stack) => errret[BrokerId.bt]);
    final retAskBidsex = AskBidsex.when(data: (ret) => ret, loading: () => loadingret[BrokerId.ex], error: (e, stack) => errret[BrokerId.ex]);
    final retAskBidslq = AskBidslq.when(data: (ret) => ret, loading: () => loadingret[BrokerId.lq], error: (e, stack) => errret[BrokerId.lq]);

    return Table(
      border: TableBorder.all(),
      /* Riverpod で状態管理を行う */
      children: [
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("通貨ペア")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText("BTC/USDT")),SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("ETH/USDT")) ,SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("XRP/USDT")) ,SelectableText("")                                                 ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("BNB/USDT")),SelectableText("")                                                ,]),
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("業者"))   ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))      ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bid"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Ask")),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Binance")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BNB_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbi[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("FTX"))     ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BNB_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsfx[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("KuCoin"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BNB_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidskc[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bitstamp")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbs[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Poloniex")),Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BNB_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidspn[Symbol.BNB_USDT].askstr)),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Bittrex")) ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsbt[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("OKEx"))    ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.XRP_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidsex[Symbol.XRP_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
        /******************************************/
        TableRow(children: [Padding(padding: EdgeInsets.all(4.0),child: SelectableText("Liquid"))  ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.BTC_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.BTC_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.ETH_USDT].bidstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText(retAskBidslq[Symbol.ETH_USDT].askstr))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***'))
          ,Padding(padding: EdgeInsets.all(4.0),child: SelectableText('***')),]),
      ],);
  }
}
