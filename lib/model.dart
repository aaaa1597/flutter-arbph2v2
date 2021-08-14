/* 通貨ペアenum */
enum Symbol {BTC_USDT, ETH_USDT, XRP_USDT, BNB_USDT,}
extension on Symbol { String get str => this.toString().split(".").last;}

/* 業者名enum */
enum Broker {Binance, FTX, KuCoin, Bitstamp, Poloniex, Bittrex, OKEx, Liquid,}
extension on Broker { String get str => this.toString().split(".").last;}

/* 業者idenum */
enum BrokerId { bi, fx, kc, bs, pn, bt, ex, lq,}
extension on BrokerId { String get str => this.toString().split(".").last;}

/* Ask/Bid取得結果 */
class AskBidDataforTbl {
  AskBidDataforTbl(this.symbol, this.id, this.askstr, this.bidstr);
  final Symbol symbol;
  final BrokerId id;
  final String askstr;
  final String bidstr;
}
