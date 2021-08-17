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

/* Ask/Bid取得結果 */
class AskBidData {
  AskBidData(this.symbol, this.id, this.ask, this.bid);
  AskBidData.formAskBidDataforTbl(AskBidDataforTbl askbidfortbl) : this.symbol=askbidfortbl.symbol, this.id=askbidfortbl.id, this.ask=isNumeric(askbidfortbl.askstr)?double.parse(askbidfortbl.askstr):99999999, this.bid=isNumeric(askbidfortbl.bidstr)?double.parse(askbidfortbl.bidstr):0;
  static bool isNumeric(String s) {
    if(s == null) return false;
    try { double tmpval = double.parse(s); return true;}
    catch (exception) { return false; }
  }
  final Symbol symbol;
  final BrokerId id;
  final double ask;
  final double bid;
}

/* Ask/Bid取得結果(Loading中) */
final Map<BrokerId, Map<Symbol, AskBidDataforTbl>> loadingret = {
   BrokerId.bi : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.bi, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.bi, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.bi, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.bi, '...', '...')}
  ,BrokerId.fx : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.fx, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.fx, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.fx, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.fx, '...', '...')}
  ,BrokerId.kc : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.kc, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.kc, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.kc, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.kc, '...', '...')}
  ,BrokerId.bs : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.bs, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.bs, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.bs, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.bs, '...', '...')}
  ,BrokerId.pn : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.pn, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.pn, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.pn, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.pn, '...', '...')}
  ,BrokerId.bt : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.bt, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.bt, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.bt, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.bt, '...', '...')}
  ,BrokerId.ex : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.ex, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.ex, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.ex, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.ex, '...', '...')}
  ,BrokerId.lq : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.lq, '...', '...'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.lq, '...', '...'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.lq, '...', '...'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.lq, '...', '...')}
};

/* Ask/Bid取得結果(エラー応答) */
final Map<BrokerId, Map<Symbol, AskBidDataforTbl>> errret = {
   BrokerId.bi : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.bi, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.bi, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.bi, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.bi, '---', '---')}
  ,BrokerId.fx : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.fx, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.fx, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.fx, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.fx, '---', '---')}
  ,BrokerId.kc : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.kc, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.kc, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.kc, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.kc, '---', '---')}
  ,BrokerId.bs : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.bs, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.bs, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.bs, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.bs, '---', '---')}
  ,BrokerId.pn : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.pn, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.pn, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.pn, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.pn, '---', '---')}
  ,BrokerId.bt : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.bt, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.bt, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.bt, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.bt, '---', '---')}
  ,BrokerId.ex : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.ex, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.ex, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.ex, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.ex, '---', '---')}
  ,BrokerId.lq : {Symbol.BTC_USDT:AskBidDataforTbl(Symbol.BTC_USDT, BrokerId.lq, '---', '---'), Symbol.ETH_USDT:AskBidDataforTbl(Symbol.ETH_USDT, BrokerId.lq, '---', '---'), Symbol.XRP_USDT:AskBidDataforTbl(Symbol.XRP_USDT, BrokerId.lq, '---', '---'), Symbol.BNB_USDT:AskBidDataforTbl(Symbol.BNB_USDT, BrokerId.lq, '---', '---')}
};
