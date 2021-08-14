import 'package:flutter/cupertino.dart';
import 'model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/* なんでかextensionがimportされないので定義 */
extension on Symbol { String get str => this.toString().split(".").last;}
extension on Broker { String get str => this.toString().split(".").last;}
extension on BrokerId { String get str => this.toString().split(".").last;}

Future<Map<Symbol, AskBidDataforTbl>> GetTicker(BrokerId bid) async {
  final Set<Symbol> pairs = {Symbol.BTC_USDT, Symbol.ETH_USDT, Symbol.XRP_USDT, Symbol.BNB_USDT};
  Future<Map<Symbol, AskBidDataforTbl>> retjson;
  switch (bid) {
    case BrokerId.bi: retjson = getTickerBi(pairs); break;
    case BrokerId.fx: retjson = getTickerBi(pairs); break;
    case BrokerId.kc: retjson = getTickerBi(pairs); break;
    case BrokerId.bs: retjson = getTickerBi(pairs); break;
    case BrokerId.pn: retjson = getTickerBi(pairs); break;
    case BrokerId.bt: retjson = getTickerBi(pairs); break;
    case BrokerId.ex: retjson = getTickerBi(pairs); break;
    case BrokerId.lq: retjson = getTickerBi(pairs); break;
  }

  return retjson;
}

/* BinanceからAsk/Bid取得 */
Future<Map<Symbol, AskBidDataforTbl>> getTickerBi(Set<Symbol> pairs) async {
  final Set<String> PairStrs =  pairs.map((s)=>s.str.replaceFirst("_", "")).toSet();

  final String endpoint = 'https://api.binance.com';
  final String method = '/api/v3/ticker/bookTicker';

  final http.Response retRes = await http.get(Uri.parse(endpoint+method));
  final retjson2 = await json.decode(retRes.body).where((item)=>PairStrs.contains(item['symbol'])).toList();

  Symbol Function(String) str2symbol = (String sybl) {
    switch(sybl) {
      case 'BTCUSDT': return Symbol.BTC_USDT;
      case 'ETHUSDT': return Symbol.ETH_USDT;
      case 'XRPUSDT': return Symbol.XRP_USDT;
      case 'BNBUSDT': return Symbol.BNB_USDT;
      default: throw Exception("例外発生!! 未サポートペア =" + sybl);
    }
  };

  Map<Symbol, AskBidDataforTbl> ret = {};
  for(final item in retjson2) {
    if(item.containsKey('symbol') && item.containsKey('bidPrice') && item.containsKey('askPrice')) {
      Symbol sym = str2symbol(item['symbol']);
      ret[sym] = AskBidDataforTbl(sym, BrokerId.bi, item['askPrice'], item['bidPrice']);
    }
  }

  return ret;
}
