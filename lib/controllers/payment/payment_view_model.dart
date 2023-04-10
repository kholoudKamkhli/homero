import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:homero/controllers/base_classes/base.dart';
import 'package:homero/controllers/payment/payment_connector.dart';
import 'package:homero/database/order_database.dart';
import 'package:homero/screens/payment/payment_view.dart';
import 'package:http/http.dart' as http;

import '../../models/order_model.dart';

class PaymentViewModel extends BaseViewModel<PaymentConnector>{
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(String amount, OrderModel order) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(order);
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(OrderModel order) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        connector!.showMessage("Payment Successful", "Ok");
        paymentIntent = null;
        connector!.hideDialog();
        OrderDatabase.addOrder(order);
        connector!.goToHome();
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
    final calculatedAmout = int.parse(amount.replaceAll(RegExp(r'[^0-9]'),'')) * 100;
    return calculatedAmout.toString();
  }
}