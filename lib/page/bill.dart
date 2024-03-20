import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/currency_format.dart';
import '../controller/homecontroller.dart';
import 'home.dart';


class Bill extends StatelessWidget{

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
                  child: Text('Seven Retail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                ),
                Container(
                  child: Text('Grand Indonesia',style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                Container(
                  child: Text('Your Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
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
                    height: 250,
                    child:ListView.builder(
                        padding: const EdgeInsets.all(5),
                        itemCount: c.dtMenuOrder.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 100,
                              color: Colors.amber[100],
                              child:
                              Row(
                                children: [

                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * (25 / 100),
                                      height: 100,
                                      child: Image.asset(c.dtMenuOrder[index].url,
                                        height: 100, width: 100, fit: BoxFit.fill,)
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (43 / 100),
                                        height: 20,
                                        child: Text(c.dtMenuOrder[index].nama, style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                      ),

                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (43 / 100),
                                        height: 50,
                                        child: Text('Notes :'+c.dtMenuOrder[index].notes),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (20 / 100),
                                        height: 20,
                                        child: Text("Qty. "+'${c.dtMenuOrder[index].qty}', style: TextStyle(
                                            fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * (20 / 100),
                                        height: 20,
                                        child: Text("Rp. "+'${c.dtMenuOrder[index].totalHargaQty}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                    ],
                                  )


                                ],
                              )
                          );
                        }
                    )
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      Text(c.paymentMethod.value,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
                      SizedBox(
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Grand Total'),
                          Text("Rp "+'${CurrencyFormat.convertToIdr(c.tot.value,0)}'),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
                Divider(
                  color: Colors.black,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Terima Kasih',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.lightGreen),
                        onPressed: () {
                          c.resetAll();
                          Get.offAll(()=>Home());
                        },
                        child: Text(
                          "Back to Home",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),

                        ),
                      ),
                    ],
                  ),
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

