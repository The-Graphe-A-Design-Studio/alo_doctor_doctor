import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/MyConstants.dart';
import '../../utils/styles.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width / 4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Payment',
          style: Styles.regularHeading,
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
        leading: backButton(context),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 150,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.black)),
            child: Center(
              child: Text('Payment Method'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone),
                        labelText: 'Phone',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 30, right: 30, bottom: 10),
                      child: Text(
                        'SELECT A PAYMENT METHOD',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
          ),
          Row(
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.grey)),
                width: containerWidth,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 25,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Credit',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                    top: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                width: containerWidth,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wallet_giftcard_sharp,
                        size: 25,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.grey)),
                width: containerWidth,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.food_bank_outlined,
                        size: 25,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Bank',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                    top: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                width: containerWidth,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card_outlined,
                        size: 25,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'UPI',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, paymentFeedback);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return accentYellow;
                        return accentBlueLight;
                      })),
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: double.infinity,
                      child: Text(
                        'Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
