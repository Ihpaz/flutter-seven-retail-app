import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/currency_format.dart';
import '../controller/homecontroller.dart';
import 'bill.dart';
import 'home.dart';


class Payment extends StatelessWidget{

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {

    final HomeController c = Get.find();



    Widget BodyDetail(){
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ]
          )
      );
    }



    Widget BodyDetails(){
      return SingleChildScrollView(
        child: Container(
          width:  MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          color:Colors.white,
          child: Column(
              children:[
                Container(
                  child: Text('Payment Method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                          c.isOnlinePayment.value=true;
                          c.isPayAtCahsier.value=false;
                      },
                      child: Card(
                          color: c.isOnlinePayment.isTrue? Colors.lightGreen : Colors.grey,
                          child:
                          SizedBox(
                            width: 150,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Online Payment',),
                                Icon(
                                    Icons.account_balance_wallet_outlined)
                              ],
                            ),
                          )
                      ),
                    )
                   ,
                    GestureDetector(
                      onTap: (){
                        c.isOnlinePayment.value=false;
                        c.isPayAtCahsier.value=true;

                        c.paymentMethod.value='CASH';
                      },
                      child:Card(
                          color: c.isPayAtCahsier.isTrue? Colors.lightGreen : Colors.grey,
                          child:
                          SizedBox(
                            width: 150,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Pay At Cashier'),
                                Icon(
                                    Icons.add_business)
                              ],
                            ),
                          )
                      ),
                    ),

                  ],

                ),

                Container(
                  child: c.isOnlinePayment.isTrue ?
                  Column(
                    children: [
                      Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Container(
                        child: Text('Select Method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Icon(Icons.account_balance_wallet),
                              Text('Gopay')
                            ],
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: c.isCheckedGopay.value,
                            onChanged: (bool? value) {
                              c.isCheckedGopay.value = value!;
                              c.isCheckedBankTransfer.value = false;
                              c.isCheckedDebit.value = false;
                              c.paymentMethod.value='GOPAY';
                            },
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Icon(Icons.web),
                              Text('Debit Card')
                            ],
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: c.isCheckedDebit.value,
                            onChanged: (bool? value) {
                              c.isCheckedDebit.value = value!;
                              c.isCheckedBankTransfer.value = false;
                              c.isCheckedGopay.value = false;

                              c.paymentMethod.value='DEBIT';
                            },
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Icon(Icons.account_balance),
                              Text('Bank Transfer')
                            ],
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: c.isCheckedBankTransfer.value,
                            onChanged: (bool? value) {

                              c.isCheckedBankTransfer.value = value!;
                              c.isCheckedDebit.value = false;
                              c.isCheckedGopay.value = false;

                              c.paymentMethod.value='BANK TRANSFER';
                            },
                          )
                        ],
                      ),
                    ],
                  )
                  : null,

                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                Container(
                    width: double.infinity,
                    height: 130,
                    child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Subtotal'),
                             Text(CurrencyFormat.convertToIdr(c.hargaTotal.value,0)),
                           ],
                         ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service Charge"),
                              Text(CurrencyFormat.convertToIdr(10000,0)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Grand Total'),
                              Text(CurrencyFormat.convertToIdr(c.tot.value,0)),
                            ],
                          )
                        ],
                    ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * (70 / 100),
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.lightGreen),
                    onPressed: () {

                      Get.to(()=>Bill());
                    },
                    child: Text(
                      "Pay Now | "+'${CurrencyFormat.convertToIdr(c.tot.value,0)}',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                )
              ]

          ),

        ),
      );
    }

    return Obx(()=>
        Scaffold(
          appBar:new AppBar(
            title: Text('Payment'),
            backgroundColor: Color(0xffA70E61),
          ) ,
          backgroundColor: Color(0xffE5E5E5),
          body:c.dtProductDetail.length == 0 ?BodyDetail():BodyDetails(),
        ),
    );


  }





}

