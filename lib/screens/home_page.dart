import 'package:flutter/material.dart';

import '../ui/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Global variables are declared here

  var weightController = TextEditingController();
  var heightController = TextEditingController();
  String selectedHeightUnit = 'ft';
  String selectedWeightUnit = 'kg';
  double bmi = 0;

  Color determineColor(double num) {
    if (num < 18.5) {
      return paleGreenColor;
    } else if (num >= 18.5 && num < 25.0) {
      return greenColor;
    } else if (num >= 25.0 && num < 39.9) {
      return chromeColor;
    } else {
      return redColor;
    }
  }

  void calculateBMI() {

    String weightStr = weightController.text;
    String heightStr = heightController.text;

    double? weightDb;
    double? heightDb;

    weightDb = double.tryParse(weightStr);
    heightDb = double.tryParse(heightStr);

    if (weightStr.isEmpty || heightStr.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error',
                  style: kCustomTextStyle(blackColor, padding14, true)),
              content: Text('Please enter your weight and height!',
                  style: kCustomTextStyle(blackColor, padding14, true)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay',
                        style: kCustomTextStyle(blackColor, padding14, true)))
              ],
            );
          });
      return;
    }

    if (selectedWeightUnit == 'kg' && selectedHeightUnit == 'ft') {
      double heightMtr = heightDb! * 0.3048;
      bmi = weightDb! / (heightMtr * heightMtr);
    } else if (selectedWeightUnit == 'kg' && selectedHeightUnit == 'cm') {
      double heightMtr = heightDb! * 0.01;
      bmi = weightDb! / (heightMtr * heightMtr);
    } else if (selectedWeightUnit == 'kg' && selectedHeightUnit == 'm') {
      bmi = weightDb! / (heightDb! * heightDb);
    } else if (selectedWeightUnit == 'lbs' && selectedHeightUnit == 'ft') {
      double weightMtr = weightDb! * 0.4535;
      double heightMtr = heightDb! * 0.3048;
      bmi = weightMtr / (heightMtr * heightMtr);
    } else if (selectedWeightUnit == 'lbs' && selectedHeightUnit == 'cm') {
      double weightMtr = weightDb! * 0.4535;
      double heightMtr = heightDb! * 0.01;
      bmi = weightMtr / (heightMtr * heightMtr);
    } else {
      double weightMtr = weightDb! * 0.4535;
      bmi = weightMtr / (heightDb! * heightDb);
    }

    /*int totalHeightInches = (h_ft! * 12) + h_in!;

    double heightInMeter = totalHeightInches * 0.0254;

    double bmi = w! / (heightInMeter * heightInMeter);*/

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('BMI Result',
                style: kCustomTextStyle(blackColor, padding14, true)),
            content: Text('Your BMI result is ${bmi.toStringAsFixed(2)}',
                style: kCustomTextStyle(
                    determineColor(bmi),
                    padding14, 
                    true)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay',
                      style: kCustomTextStyle(blackColor, padding14, true)))
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
              style: kCustomTextStyle(blackColor, padding18, true)),
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
                    style: kCustomTextStyle(blackColor, padding16, true)),
                heightBox(padding50),
                Row(
                  children: [
                    Expanded(
                      flex: 80,
                      child: TextField(
                        controller: weightController,
                        decoration: InputDecoration(
                          label: Text('Enter your weight in ($selectedWeightUnit)',
                              style: kLabelTextStyle(padding14)),
                          prefixIcon: Icon(Icons.monitor_weight_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    widthBox(padding10),
                    Expanded(
                      flex: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: padding4, horizontal: padding10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(padding5)
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: SizedBox.shrink(),
                          value: selectedWeightUnit,
                          items: <String>['kg','lbs'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: kLabelTextStyle(padding14),),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedWeightUnit = value!;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                heightBox(padding50),
                Row(
                  children: [
                    Expanded(
                      flex: 80,
                      child: TextField(
                        controller: heightController,
                        decoration: InputDecoration(
                          label: Text('Enter your height in ($selectedHeightUnit)',
                              style: kLabelTextStyle(padding14)),
                          prefixIcon: Icon(Icons.height_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    widthBox(padding10),
                    Expanded(
                      flex: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: padding4, horizontal: padding10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(padding5)
                          ),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: SizedBox.shrink(),
                          value: selectedHeightUnit,
                          items: <String>['ft','cm','m'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: kLabelTextStyle(padding14),),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedHeightUnit = value!;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                heightBox(padding50),
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
                          style: kCustomTextStyle(whiteColor, padding14, true)),
                    ),
                  ),
                ),
                heightBox(padding50),
                Table(
                  border: TableBorder.all(
                    color: blackColor,
                    width: 1
                  ),
                  columnWidths: {
                    0 : FixedColumnWidth(240),
                  },
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'BMI',
                            style: kCustomTextStyle(blackColor, padding14, true),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Status',
                            style: kCustomTextStyle(blackColor, padding14, true),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Less than or equal to 18.4',
                            style: kCustomTextStyle(blackColor, padding14, true),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Underweight',
                            style: kCustomTextStyle(paleGreenColor, padding14, true),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'From range 18.5 to 24.9',
                            style: kCustomTextStyle(blackColor, padding14, true),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Normal',
                            style: kCustomTextStyle(greenColor, padding14, true),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'From range 25.0 to 39.9',
                            style: kCustomTextStyle(blackColor, padding14, true),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Overweight',
                            style: kCustomTextStyle(chromeColor, padding14, true),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Greater than or equal to 40',
                            style: kCustomTextStyle(blackColor, padding14, true),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Obese',
                            style: kCustomTextStyle(redColor, padding14, true),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
