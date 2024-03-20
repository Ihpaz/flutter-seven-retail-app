import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controller/currency_format.dart';
import '../controller/homecontroller.dart';
import '../widget/profile.dart';
import 'cart.dart';
import 'order.dart';

class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());
    final TextEditingController _search = new TextEditingController();
    final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
    final FocusNode fnsearch = FocusNode();
    bool _validate = false;
    // TODO: implement build
   Widget _inputSearch(context){
      return Container(
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width*(85/100),
          height: 40,
          child: TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.lightGreen), //<-- SEE HERE
              ),


              labelText: 'Kosongkan text untuk mereset.',
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
                c.filterMenu.value=value;
            },
          ),
        ),
      );
   }
    Widget _btnCari(context){
      return  Obx(() =>
        Expanded(
          flex: 2,
          child: Container(
            child: IconButton(
              color: Colors.lightGreen,
              onPressed: c.isLoading.isTrue ?   (){
                FocusManager.instance.primaryFocus?.unfocus();
              }
                  :
                  (){
                c.SearcMenu();

                FocusManager.instance.primaryFocus?.unfocus();
              }
              ,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(8),
                ),
              ),
              icon: c.isLoading.isTrue
                  ? Container(
                width: 15,
                height: 15,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.lightGreen,
                  strokeWidth: 3,
                ),
              )
                  : Center(child: Icon(Icons.search) ,),

            ),
          ),
        )
      );

    }

    List<Widget> _widgetOptions = <Widget>[

        Container(
          color:Colors.white,
          child:Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:200,
                    color:Colors.white,
                    child:  Image.asset('assets/banner.jpg',fit: BoxFit.cover,),
                  ),
                  Align(
                    alignment: Alignment(0.75,-0.80),
                    child: Text('Seven Retail GI',
                                style:TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
                                    ) ,
                 )

                ],
              )
             ,
              Container(
                child: Center(child:Text('Menu',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
              ),
              Row(
                children: [
                  _inputSearch(context),
                  SizedBox(width: 10),
                  _btnCari(context)
                ],
              ),

              Expanded(
                  child:ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: c.dtProduct.length,
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
                                    child: Image.asset(c.dtProduct[index].url,
                                      height: 100, width: 100, fit: BoxFit.fill,)
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * (47 / 100),
                                      height: 20,
                                      child: Text(c.dtProduct[index].nama, style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * (47 / 100),
                                      height: 70,
                                      child: Text(c.dtProduct[index].deskripsi),
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
                                      height: 50,
                                      child: Text(CurrencyFormat.convertToIdr(c.dtProduct[index].harga,0), style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * (20 / 100),
                                      height: 30,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.lightGreen),
                                        onPressed: () {
                                          c.dtProductDetail.clear();
                                          Get.to(()=>DetailProduct());
                                          c.getProductByid(index);
                                        },
                                        child: Text(
                                          "ADD",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                          ),

                                        ),
                                      ),
                                    )
                                  ],
                                )


                              ],
                            )
                        );
                      }
                  )
              )
            ],
          ),
        ),
        ProfileWidget().profileWidget(context)

    ];

    return WillPopScope(
        onWillPop: () async {
      return true;
    },
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {

        print('maskdk');
        FocusManager.instance.primaryFocus?.unfocus();

      },
   child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          title:Text('Seven Retail'),
          backgroundColor: Color(0xffA70E61),
        ),

        body: Container(
          width: MediaQuery.of(context).size.width,
          child:   Obx(() => (_widgetOptions.elementAt(c.changeSelectedNavBar.value))),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          c.getTotal();

          Get.to(()=>Cart());
        },

        backgroundColor: Colors.green,
        label: Obx(() => Text(c.dtMenuOrder.length.toString(),style: TextStyle(color: Colors.red),)),
        icon: const Icon(Icons.add_shopping_cart_rounded),
      ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                ),
              ],
            ),
            child:Obx(()=> BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
              currentIndex:c.changeSelectedNavBar.value,
              selectedItemColor: Color(0xffED62AD),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              onTap: c.changeNavBar,
            ))
          ),
      ),
    ),
    );
    // throw UnimplementedError();
  }
  
}