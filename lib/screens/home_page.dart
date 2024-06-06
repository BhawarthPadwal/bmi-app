import 'package:flutter/material.dart';

import '../ui/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Global variables are declared here

  var wtController = TextEditingController();
  var htController_ft = TextEditingController();
  var htController_in = TextEditingController();

  /*String bmiResult = '';*/

  calculateBMI() {
    String weight = wtController.text;
    String height_ft = htController_ft.text;
    String height_in = htController_in.text;

    int? w;
    int? h_ft;
    int? h_in;

    w = int.tryParse(weight);
    h_ft = int.tryParse(height_ft);
    h_in = int.tryParse(height_in);

    if (weight.isEmpty || height_ft.isEmpty || height_in.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error',
                  style: kCustomTextStyle(blackColor, padding14, true)
                  /*TextStyle(
                    fontSize: padding14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),*/
                  ),
              content: Text('Please fill all fields',
                  style: kCustomTextStyle(blackColor, padding14, true)
                  /*TextStyle(
                    fontSize: padding14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),*/
                  ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay',
                        style: kCustomTextStyle(blackColor, padding14, true)
                        /*TextStyle(
                          fontSize: padding14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),*/
                        ))
              ],
            );
          });
      return;
    }

    int totalHeightInches = (h_ft! * 12) + h_in!;

    double heightInMeter = totalHeightInches * 0.0254;

    double bmi = w! / (heightInMeter * heightInMeter);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('BMI Result',
                style: kCustomTextStyle(blackColor, padding14, true)
                /*TextStyle(
                  fontSize: padding14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),*/
                ),
            content: Text('Your BMI result is ${bmi.toStringAsFixed(2)}',
                style: kCustomTextStyle(blackColor, padding14, true)
                /*TextStyle(
                  fontSize: padding14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),*/
                ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay',
                      style: kCustomTextStyle(blackColor, padding14, true)
                      /*TextStyle(
                        fontSize: padding14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),*/
                      ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text('BMI Calculator',
              style: kCustomTextStyle(blackColor, padding18, true)
              /*TextStyle(
                fontSize: padding18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),*/
              ),
          centerTitle: true,
          backgroundColor: transparentColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(padding20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Track Your Health: Calculate Your BMI Today!',
                    style: kCustomTextStyle(blackColor, padding16, true)
                    /*TextStyle(
                      fontSize: padding16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'),*/
                    ),
                heightBox(padding50),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    label: Text('Enter your weight in (kg)',
                        style: kLabelTextStyle(padding14)
                        /*TextStyle(fontSize: padding14, fontFamily: 'Poppins'),*/
                        ),
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                heightBox(padding50),
                TextField(
                  controller: htController_ft,
                  decoration: InputDecoration(
                    label: Text('Enter your height in (ft)',
                        style: kLabelTextStyle(padding14)
                        /*TextStyle(fontSize: padding14, fontFamily: 'Poppins'),*/
                        ),
                    prefixIcon: Icon(Icons.height_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                heightBox(padding50),
                TextField(
                  controller: htController_in,
                  decoration: InputDecoration(
                    label: Text('Enter your height in (in)',
                        style: kLabelTextStyle(padding14)
                        /*TextStyle(fontSize: padding14, fontFamily: 'Poppins'),*/
                        ),
                    prefixIcon: Icon(Icons.height_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                heightBox(padding60),
                ElevatedButton(
                  onPressed: () {
                    calculateBMI();
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(padding10),
                        side: const BorderSide(color: orangeColor),
                      ),
                    ),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(orangeColor),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: padding50,
                    child: Center(
                      child: Text('Calculate your BMI',
                          style: kCustomTextStyle(whiteColor, padding14, true)
                          /*TextStyle(
                            color: whiteColor,
                            fontSize: padding14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),*/
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
