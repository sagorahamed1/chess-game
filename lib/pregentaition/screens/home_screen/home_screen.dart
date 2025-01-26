import 'package:chess/core/routes/app_routes.dart';
import 'package:chess/pregentaition/widgets/custom_text.dart';
import 'package:chess/pregentaition/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/custom_button.dart';
import 'inner_widgets/white_or_black_option_dialog.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   String selectedOption = 'White';

  List <dynamic> gameTypeList = [
    {
      "title" : "Play\nComputer",
      "icon" : Icon(Icons.ac_unit_outlined)
    },

    {
      "title" : "Play\nOnline",
      "icon" : Icon(Icons.ac_unit_outlined)
    },

    {
      "title" : "Play\nFriend",
      "icon" : Icon(Icons.ac_unit_outlined)
    },

    {
      "title" : "Play\nOthers",
      "icon" : Icon(Icons.ac_unit_outlined)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      ///back ground sound + demo game screen + button of game type +

      body: Column(
        children: [

          /// ====================app logo===================>>>>


          ///====================game screen demo=================>>>



          ///====================game buttons===================>>>

          SizedBox(height: 300),

          GridView.builder(
            shrinkWrap: true,
            itemCount: gameTypeList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                childAspectRatio: 2.0059
              ),
              itemBuilder: (context, index) {
              var gameType = gameTypeList[index];
                return GestureDetector(
                  onTap: () {
                    if(index == 0){


                      ///================play with computer=======>>>

                      showDialog(context: context, builder: (context) {
                       return AlertDialog(

                         content: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [

                             CustomText(text: "Choose Option",),

                             Divider(),

                              WhiteOrBlackOptionDialog(),

                           ],
                         ),
                       );
                      });



                    }else if(index == 1){

                      ///================Play with online player============>>

                      showDialog(context: context, builder: (context) {
                        return AlertDialog(

                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              CustomText(text: "Play with online random player", bottom: 10.h),

                              Divider(),

                              SizedBox(height: 12.h),

                              OnlineDialog(),

                            ],
                          ),
                        );
                      });

                    }else if(index == 2){
                      ///===============Play with friends ===================>>>

                    }else if(index == 3){
                      ///===============Others Options ==================>>>>

                    }
                  },
                  child: Card(
                    color: Colors.grey,
                    child: Center(
                      child: Row(
                        children: [

                          SizedBox(width: 16.w),
                          gameType["icon"],
                          SizedBox(width: 8.w),

                          Column(
                            children: [
                              ///=============Icon and Text=============<<

                              SizedBox(height: 4.h),
                              Center(child: CustomText(text: "${gameType["title"]}", fontSize: 20.h, textAlign: TextAlign.start)),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
          )

        ],
      ),

    );
  }
}




class OnlineDialog extends StatelessWidget {
   OnlineDialog({super.key});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
   final GlobalKey<FormState> forKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forKey,
      child: Column(
        children: [


          ///=====================Enter Your name=================>>.

          CustomTextField(
              controller: nameCtrl,
             hintText: "Enter Your Name",
          ),


          SizedBox(height: 16.h),

          ///=====================Enter Your name=================>>.

          CustomTextField(
            controller: countryCtrl,
            hintText: "Enter Your Country",
          ),



          SizedBox(height: 50.h),


          CustomButton(title: "Play", onpress: (){
            context.pushNamed(AppRoutes.playOnlineScreen);
          })
        ],
      ),
    );
  }
}
