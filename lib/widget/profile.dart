



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../controller/profilecontroller.dart';

class ProfileWidget extends StatelessWidget {
  final ProfileController p = Get.put(ProfileController());
  final phoneController = Get.put(TextEditingController());
  final phoneFormatter =
  MaskTextInputFormatter(mask: '(+##) ###-####-####', filter: {'#': RegExp(r'[0-9]')});

  Widget profileWidget(BuildContext context){
    return Obx(() =>Container(
      color: Colors.white,
      child: p.isLogin.isTrue  ?  personalInfo(context) :
      p.isSignUp.isTrue ? signupWidget(context) : buildWidget(context)) ,
    );

  }

  Widget personalInfo(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left:10,top: 10,right: 10),
      width: MediaQuery
          .of(context)
          .size
          .width,

      child: Column(
        children: [
          Center(
            child: Text('Personal Data :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.add_call),
              Text(p.noTelp.value.toString())
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.accessibility),
              Text(p.age.value.toString())
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.wc),
              Text(p.gender.value.toString())
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.account_balance),
              Text(p.address.value.toString())
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 100,
            child:  TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent),
              onPressed: () {
                p.isLogin.value =!p.isLogin.value;

                print(p.isSignUp.value);
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Color(0xffffffff),
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
  Widget buildWidget(BuildContext context) {
    return Container(

        margin: const EdgeInsets.only(left:10,top: 10,right: 10),
          width: MediaQuery
              .of(context)
              .size
              .width,

          child:Column(
            children: [
            TextFormField(

              controller: phoneController,
              inputFormatters: [phoneFormatter],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){

              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                } else if (value.length < 14) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            Container(
              child: Align(alignment: Alignment.topLeft,
                  child: Text('Dont Have an Account ?'),)

            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child:  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    onPressed: () {
                      p.isSignUp.value =!p.isSignUp.value;

                      print(p.isSignUp.value);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),

                    ),
                  ),
                )
              ,
              SizedBox(
                width: 100,
                child:TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.lightGreen),
                  onPressed: () {
                    p.isLogin.value =!p.isLogin.value;
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),

                  ),
                ),
              )

              ],
            )
        ],
      ) ,);
  }

  Widget signupWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left:10,top: 10,right: 10),
      width: MediaQuery
          .of(context)
          .size
          .width,

      child:Column(
        children: [
          TextFormField(
            controller: phoneController,
            inputFormatters: [phoneFormatter],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
                p.noTelp.value=value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              } else if (value.length < 14) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 5,bottom: 5),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      p.age.value=value;
                    },
                  ),
                ),
              SizedBox(
                width: 70,
                child: Text('Gender :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              )
                ,
                SizedBox(
                  width: 150,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      hint: Text("Gender", style: GoogleFonts.poppins(fontSize: 13.0,)),
                      value: p.gender.value,
                      items: [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (value) {
                        p.gender.value=value!;
                      },
                    ),
                  ),
                )


              ],
            ),
          ),
          Container(
              height: 100,
              width:MediaQuery
                  .of(context)
                  .size
                  .width,
              child: TextFormField(
                maxLines: 4,
                initialValue: '',
                onChanged: (value) {
                  p.address.value=value!;
                },

                style: GoogleFonts.varela(fontSize: 14),
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  labelText: 'Address',
                  labelStyle: GoogleFonts.poppins(fontSize: 13),
                  hintText: 'Address',
                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey,fontFamily: 'Gotham'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),

              )

          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child:  TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    p.isLogin.value =!p.isLogin.value;
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),

                  ),
                ),
              )
              ,
              SizedBox(
                width: 100,
                child:TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.lightGreen),
                  onPressed: () {
                    p.isSignUp.value =!p.isSignUp.value;
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),

                  ),
                ),
              )
              ,
            ],
          ),


        ],
      ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}