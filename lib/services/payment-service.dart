import 'dart:convert';

import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com//v1';
  static String secret = '';

  static init(){
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "pk_test_51Hm2SKIIBWMqfojFMxCgZiBx5PWNFQTtbSJwu4Gy55LB476DvjEpRQVgWEuQIGAQJ8W8BsVniYLYl2ToNU64P5zF00s1Sju7Bs",
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
  }

  static StripeTransactionResponse payViaExistingCard({String amount, String currency, card}){
    return StripeTransactionResponse(
      message: 'Transaction successful',
      success: true,
    );
  }

  static Future <StripeTransactionResponse> payWithNewCard({String amount, String currency}) async{
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );
      print(jsonEncode(paymentMethod));
      return StripeTransactionResponse(
        message: 'Transaction successful',
        success: true,
      );
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction successful',
        success: true,
      );
    }
  }

  static createPaymentIntent(String amount, String currency) async {

  }
}