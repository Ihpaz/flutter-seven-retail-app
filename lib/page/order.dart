import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/currency_format.dart';
import '../controller/homecontroller.dart';
import 'home.dart';


class DetailProduct extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.find();

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

    Widget _createIncrementDicrementButton(IconData icon,String action) {
      return RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
        onPressed: (){
            if(action=='plus'){
              c.currentQty.value++;
            }else{
              c.currentQty.value--;
            }

            if(c.currentQty.value < 0) c.currentQty.value=0;

            c.totalHargaQty.value=c.dtProductDetail[0].harga*c.currentQty.value;
        },
        elevation: 2.0,
        fillColor: Colors.grey,
        child: Icon(
          icon,
          color: Colors.black,
          size: 12.0,
        ),
        shape: CircleBorder(),
      );
    }

    Widget BodyDetails(){
      return SingleChildScrollView(
        child: Container(
          child: Column(
              children:[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(c.dtProductDetail[0].url),
                    ),
                  ),
                  // child: Image.network(c.dtProductDetail[0].foto,width:MediaQuery.of(context).size.width, height:400.0),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,top: 10),
                          child: Obx(()=>Text(CurrencyFormat.convertToIdr(c.dtProductDetail[0].harga,0),style: TextStyle(fontSize: 18),)),
                        ),
                        Container(
                            child: Divider()
                        ),
                        Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(c.dtProductDetail[0].deskripsi),
                            )
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 130,
                    child: Card(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,top: 10),
                            child: Text('Modifier',style: TextStyle(fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                height: 50,
                                width:MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child:
                                Row(
                                  children: [
                                    Obx(() =>
                                        Checkbox(
                                          checkColor: Colors.white,
                                          fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: c.isCheckedMeat.value,
                                          onChanged: (bool? value) {
                                            c.isCheckedMeat.value = value!;
                                          },
                                        )
                                    ),
                                    Text('Extra Meat')
                                    ,
                                    Obx(() =>
                                        Checkbox(
                                          checkColor: Colors.white,
                                          fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: c.isCheckedEgg.value,
                                          onChanged: (bool? value) {
                                            c.isCheckedEgg.value = value!;
                                          },
                                        )
                                    ),
                                    Text('Extra Egg')
                                  ],
                                )



                            ),
                          )
                        ],
                      ),
                    )
                ),
                Container(
                  width: double.infinity,
                  height: 170,
                  child: Card(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,top: 10),
                          child: Text('Notes',style: TextStyle(fontSize: 18),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: 100,
                              width:MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: TextFormField(
                                maxLines: 4,
                                initialValue: '',
                                onChanged: (value) {
                                      c.currentNotes.value=value;
                                },

                                style: GoogleFonts.varela(fontSize: 14),
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(20.0),
                                  labelText: '',
                                  labelStyle: GoogleFonts.poppins(fontSize: 13),
                                  hintText: '',
                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey,fontFamily: 'Gotham'),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),

                              )

                          ),
                        )
                      ],
                    ),
                  )
                ),
                Center(
                  child:  SizedBox(
                    width: MediaQuery.of(context).size.width*(32/100),
                    height: 50,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22,top: 10,bottom: 10),
                        child: Obx(()=>Row(
                          children: [
                            _createIncrementDicrementButton(Icons.remove,'minus'),
                            Text(c.currentQty.toString()),
                            _createIncrementDicrementButton(Icons.add,'plus'),
                          ],
                        )),
                      ),
                    ),
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
                          c.addMenuORder(c.dtProductDetail[0].id);
                          c.addProduct();
                          c.currentQty.value=0;
                          c.currentNotes.value='';
                          c.totalHargaQty.value=0;
                          Get.offAll(()=>Home());
                    },
                    child: Text(
                      "ADD TO CART | "+'${CurrencyFormat.convertToIdr(c.totalHargaQty.value,0)}',
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
            title: Text(c.dtProductDetail[0].nama),
            backgroundColor: Color(0xffA70E61),
          ) ,
          backgroundColor: Color(0xffE5E5E5),
          body:c.dtProductDetail.length == 0 ?BodyDetail():BodyDetails(),
        ),
    );


  }





}

