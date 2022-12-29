// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_util.dart';
Future<String> formatCurrency(String? amount) async {
  final _currencyFormat = NumberFormat.simpleCurrency(
    decimalDigits: 0,
  );
  if (amount!.trim().isEmpty) {
    return '';
  }
  String price = _currencyFormat.format(amount);
  if (price.isNotEmpty) {
    return price.substring(1);
  } else {
    return '';
  }
}
