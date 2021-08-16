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
    case BrokerId.fx: retjson = getTickerFx(pairs); break;
    case BrokerId.kc: retjson = getTickerKc(pairs); break;
    case BrokerId.bs: retjson = getTickerBs(pairs); break;
    case BrokerId.pn: retjson = getTickerPn(pairs); break;
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

/* FTXからAsk/Bid取得 */
Future<Map<Symbol, AskBidDataforTbl>> getTickerFx(Set<Symbol> pairs) async {
  final Set<String> PairStrs =  pairs.map((s)=>s.str.replaceFirst("_", "/")).toSet();

  final String endpoint = 'https://ftx.com/api';
  final String method = '/markets';

  final http.Response retRes = await http.get(Uri.parse(endpoint+method), headers: {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  });
  final retjson1 = await json.decode(retRes.body);
  if(retjson1.containsKey('result') == false) return {};
  final retjson = retjson1['result'].where((item)=>PairStrs.contains(item['name'])).toList();

  Symbol Function(String) str2symbol = (String sybl) {
                            switch(sybl) {
                              case 'BTC/USDT': return Symbol.BTC_USDT;
                              case 'ETH/USDT': return Symbol.ETH_USDT;
                              case 'XRP/USDT': return Symbol.XRP_USDT;
                              case 'BNB/USDT': return Symbol.BNB_USDT;
                              default: throw Exception("例外発生!! 未サポートペア =" + sybl);
                            }
                          };

  Map<Symbol, AskBidDataforTbl> ret = {};
  for(final item in retjson) {
    if(item.containsKey('name') && item.containsKey('bid') && item.containsKey('ask')) {
      Symbol sym = str2symbol(item['name']);
      ret[sym] = AskBidDataforTbl(sym, BrokerId.fx, item['ask'].toString(), item['bid'].toString());
    }
  }

  return ret;
}

/* KuCoinからAsk/Bid取得 */
Future<Map<Symbol, AskBidDataforTbl>> getTickerKc(Set<Symbol> pairs) async {
  final Set<String> PairStrs =  pairs.map((s)=>s.str.replaceFirst("_", "-")).toSet();

  final String endpoint = 'https://api.kucoin.com';
  final String method = '/api/v1/market/allTickers';

  final http.Response retRes = await http.get(Uri.parse(endpoint+method), headers: {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  });
  final retjson1 = await json.decode(retRes.body);
  if(retjson1.containsKey('data') == false || retjson1['data'].containsKey('ticker') == false) return {};
  final retjson = retjson1['data']['ticker'].where((item)=>PairStrs.contains(item['symbol'])).toList();

  Symbol Function(String) str2symbol = (String sybl) {
    switch(sybl) {
      case 'BTC-USDT': return Symbol.BTC_USDT;
      case 'ETH-USDT': return Symbol.ETH_USDT;
      case 'XRP-USDT': return Symbol.XRP_USDT;
      case 'BNB-USDT': return Symbol.BNB_USDT;
      default: throw Exception("例外発生!! 未サポートペア =" + sybl);
    }
  };

  Map<Symbol, AskBidDataforTbl> ret = {};
  for(final item in retjson) {
    if(item.containsKey('symbol') && item.containsKey('buy') && item.containsKey('sell')) {
      Symbol sym = str2symbol(item['symbol']);
      ret[sym] = AskBidDataforTbl(sym, BrokerId.kc, item['sell'].toString(), item['buy'].toString());
    }
  }

  return ret;
}

/* KuCoinからAsk/Bid取得 */
Future<Map<Symbol, AskBidDataforTbl>> getTickerBs(Set<Symbol> pairs) async {
  final Set<String> PairStrs =  pairs.map((s)=>s.str.replaceFirst("_", "").toLowerCase()).toSet();

  final String endpoint = 'https://www.bitstamp.net';
  final String method = '/api/v2/ticker';

  Symbol Function(String) str2symbol = (String sybl) {
    switch(sybl) {
      case 'btcusdt': return Symbol.BTC_USDT;
      case 'ethusdt': return Symbol.ETH_USDT;
      case 'xrpusdt': return Symbol.XRP_USDT;
      case 'bnbusdt': return Symbol.BNB_USDT;
      default: throw Exception("例外発生!! 未サポートペア =" + sybl);
    }
  };

  Map<Symbol, AskBidDataforTbl> ret = {};
  for(final symbol in PairStrs) {
    final http.Response retRes = await http.get(Uri.parse(endpoint+method+'/'+symbol+'/'), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    });

    if(retRes.statusCode != 200) {
      print('warinig! http-status=' + retRes.statusCode.toString() + ' url=' + endpoint+method+'/'+symbol+'/');
      continue;
    }

    final retjson2 = await json.decode(retRes.body);
    if(retjson2.containsKey('ask') && retjson2.containsKey('bid')) {
      Symbol sym = str2symbol(symbol);
      ret[sym] = AskBidDataforTbl(sym, BrokerId.bs, retjson2['ask'].toString(), retjson2['bid'].toString());
    }
  }
  return ret;
}

/* PoloniexからAsk/Bid取得 */
Future<Map<Symbol, AskBidDataforTbl>> getTickerPn(Set<Symbol> pairs) async {
  final Set<String> PairStrs =  pairs.map((s)=>s.str.replaceFirst("_", "-")).toSet();

  final String endpoint = 'https://api.kucoin.com';
  final String method = '/api/v1/market/allTickers';

  final http.Response retRes = await http.get(Uri.parse(endpoint+method), headers: {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  });
  final retjson1 = await json.decode(retRes.body);

  Symbol Function(String) str2symbol = (String sybl) {
    switch(sybl) {
      case 'BTC-USDT': return Symbol.BTC_USDT;
      case 'ETH-USDT': return Symbol.ETH_USDT;
      case 'XRP-USDT': return Symbol.XRP_USDT;
      case 'BNB-USDT': return Symbol.BNB_USDT;
      default: throw Exception("例外発生!! 未サポートペア =" + sybl);
    }
  };

  if(retjson1.containsKey('code')==false || retjson1['code']!='200000') {
    print('error! getTickerPn() retjson not has key("code") retjson=' + retjson1);
    return {};
  }
  final retjson = retjson1['data']['ticker'].where((item) => PairStrs.contains(item['symbol'])).toList();

  Map<Symbol, AskBidDataforTbl> ret = {};
  retjson.forEach((item) {
    if(item.containsKey('sell') && item.containsKey('buy')) {
      Symbol sym = str2symbol(item['symbol']);
      ret[sym] = AskBidDataforTbl(sym, BrokerId.kc, item['sell'].toString(), item['buy'].toString());
    }
  });

  return ret;
}
