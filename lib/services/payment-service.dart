import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com//v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = 'sk_test_51Hm2SKIIBWMqfojFL0TTzSaGoVTqeXmNt1G4QAnmLccqMUIZdGdI0PXSb9Ol2smYJVXdy0Z23VpuNq7Zgw0zbXDu00w19vTGk7';
  static Map <String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

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
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency,
      );
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id,
        )
      );
        if(response.status == 'succeeded') {
          return StripeTransactionResponse(
            message: 'Transaction successful',
            success: true,
          );
        }
        else {
          return StripeTransactionResponse(
            message: 'Transaction failed',
            success: false,
          );
        }
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction failed ${err.toString()}',
        success: false,
      );
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map <String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers,
      );
      return jsonDecode(response.body);
    } catch (err){
      print(err.toString());
    }
    return null;
  }
}