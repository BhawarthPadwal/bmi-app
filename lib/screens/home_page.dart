import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  FocusNode weightFocus = FocusNode();
  FocusNode heightFocus = FocusNode();
  double bmi = 0;
  int decider = 0;
  bool visibility = false;

  Color determineColor(double num) {
    if (num < 18.5) {
      decider = 1;
      return paleGreenColor;
    } else if (num >= 18.5 && num < 25.0) {
      decider = 2;
      return greenColor;
    } else if (num >= 25.0 && num < 39.9) {
      decider = 3;
      return chromeColor;
    } else {
      decider = 4;
      return redColor;
    }
  }

  String status(int decider) {
    if (decider == 1) {
      return 'Underweight';
    } else if (decider == 2) {
      return 'Normal';
    } else if (decider == 3) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  Map<String, dynamic> tips = {
    'Underweight': [
      'Focus on calorie-dense foods such as nuts, avocados, and healthy fats.',
      'Increase protein intake with lean meats, fish, eggs, and legumes.',
      'Incorporate strength training exercises to build muscle mass.',
      'Avoid skipping meals and aim for regular, balanced meals throughout the day.',
      'Consult with a healthcare professional or dietitian for personalized advice.'
    ],
    'Normal': [
      'Maintain a balanced diet rich in fruits, vegetables, whole grains, and lean proteins.',
      'Engage in regular physical activity, aiming for at least 150 minutes of moderate-intensity exercise per week.',
      'Stay hydrated by drinking plenty of water throughout the day.',
      'Monitor portion sizes to avoid overeating.',
      'Prioritize sleep and stress management for overall well-being.'
    ],
    'Overweight': [
      'Focus on portion control and reduce consumption of high-calorie, processed foods.',
      'Increase physical activity levels with a combination of cardiovascular exercise and strength training.',
      'Incorporate more fruits, vegetables, and fiber-rich foods into meals to promote satiety.',
      'Set realistic weight loss goals and track progress over time.',
      'Seek support from a healthcare provider or weight loss program if needed.'
    ],
    'Obese': [
      'Gradually reduce calorie intake by choosing nutrient-dense foods and limiting added sugars and unhealthy fats.',
      'Increase daily physical activity with a mix of aerobic exercises, strength training, and flexibility exercises.',
      'Consider seeking professional guidance from a registered dietitian or weight loss specialist.',
      'Focus on long-term lifestyle changes rather than quick-fix diets.',
      'Join a support group or community for encouragement and accountability.'
    ],
  };

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
                  style: kCustomTextStyle(blackColor, padding14, false)),
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

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('BMI Result',
                style: kCustomTextStyle(blackColor, padding14, true)),
            content: Text('Your BMI result is ${bmi.toStringAsFixed(2)}',
                style: kCustomTextStyle(determineColor(bmi), padding14, true)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    weightController.clear();
                    heightController.clear();
                    heightFocus.nextFocus();
                  },
                  child: Text('Okay',
                      style: kCustomTextStyle(blackColor, padding14, true)))
            ],
          );
        });
    visibility = true;
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
                      focusNode: weightFocus,
                      decoration: InputDecoration(
                        label: Text(
                            'Enter your weight in ($selectedWeightUnit)',
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
                      padding: EdgeInsets.symmetric(
                          vertical: padding4, horizontal: padding10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(padding5)),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox.shrink(),
                        value: selectedWeightUnit,
                        items: <String>['kg', 'lbs']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: kLabelTextStyle(padding14),
                            ),
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
                      focusNode: heightFocus,
                      decoration: InputDecoration(
                        label: Text(
                            'Enter your height in ($selectedHeightUnit)',
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
                      padding: EdgeInsets.symmetric(
                          vertical: padding4, horizontal: padding10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(padding5)),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox.shrink(),
                        value: selectedHeightUnit,
                        items: <String>['ft', 'cm', 'm']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: kLabelTextStyle(padding14),
                            ),
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
                  backgroundColor: WidgetStateProperty.all<Color>(orangeColor),
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
                border: TableBorder.all(color: blackColor, width: 1),
                columnWidths: {
                  0: FixedColumnWidth(240),
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
                          style: kCustomTextStyle(blackColor, padding14, false),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Underweight',
                          style:
                              kCustomTextStyle(paleGreenColor, padding14, true),
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
                          style: kCustomTextStyle(blackColor, padding14, false),
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
                          style: kCustomTextStyle(blackColor, padding14, false),
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
                          style: kCustomTextStyle(blackColor, padding14, false),
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
              heightBox(padding10),
              tips_section(),
            ],
          ),
        ),
      ),
    );
  }

  tips_section() {
    if (!visibility) {
      return Container(
        margin: EdgeInsets.only(top: padding10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Lottie.asset(
              'assets/cycle.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
              repeat: true,
              reverse: false,
              animate: true,
            ),
            Text(
              'Let\'s start a journey towards a healthier life!',
              style: kCustomTextStyle(blackColor, padding14, true),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    String bmiStatus =
        status(decider); // Get the status string from the decider

    // Ensure the tips map contains the key
    if (!tips.containsKey(bmiStatus)) {
      return Container();
    }

    List<String> tipsForStatus = tips[bmiStatus];

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: padding20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Your BMI: ${bmi.toStringAsFixed(2)}',
            style: kCustomTextStyle(determineColor(bmi), padding16, true),
          ),
          SizedBox(height: padding10),
          Text(
            'Tips for you!',
            style: kCustomTextStyle(blackColor, padding16, true),
          ),
          heightBox(padding20),
          Container(
            height: 450,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: tipsForStatus.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    'assets/arrow.png',
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    tipsForStatus[index],
                    style: kCustomTextStyle(blackColor, padding14, false),
                  ),
                );
              },
            ),
          ),
          Text(
            'Stay healthy always!',
            style: kCustomTextStyle(blackColor, padding14, true),
          )
        ],
      ),
    );
  }
}
