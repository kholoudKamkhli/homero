import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import '../../models/order_model.dart';
import 'package:http/http.dart' as http;

class PayViewModel extends Cubit<PaymentState>{
  PayViewModel():super(LoadingPayment());
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(String amount, OrderModel order) async {
    try {
      emit(LoadingPayment());
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(order);
    } catch (err) {
     emit(ErrorPayment(err.toString()));
    }
  }

  displayPaymentSheet(OrderModel order) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntent = null;
        //OrderDatabase.addOrder(order);
        emit(DonePayment());
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    print("$amount");
    final calculatedAmout = int.parse(amount.replaceAll(RegExp(r'[^0-9]'), '')) ;
    return calculatedAmout.toString();
  }
}
abstract class PaymentState {}
class LoadingPayment extends PaymentState{}
class ErrorPayment extends PaymentState{
  String errorMessage;
  ErrorPayment(this.errorMessage);
}
class DonePayment extends PaymentState{}