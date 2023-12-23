// import 'package:flutter/foundation.dart';
import 'package:currency_converter/db.dart';
import 'package:flutter/material.dart';
import 'color_palette.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  final TextEditingController textEditingController = TextEditingController();
  double convertedResult = 0;
  String currencyName = currencyList[0].name;
  double factor = currencyList[0].factor;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // always keep the build function as less expensive as possible
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorPalette.bgColor,
        appBar: AppBar(
          backgroundColor: ColorPalette.bgColor,
          foregroundColor: ColorPalette.primaryText,
          centerTitle: true,
          title: const Text(
            "Currency Converter App",
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display of Converted Answer
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "₹",
                        style: TextStyle(
                          color: ColorPalette.secondaryText,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        convertedResult.toStringAsFixed(2),
                        style: const TextStyle(
                          color: ColorPalette.primaryText,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Text Input Field
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown Menu to select Currencies
                    DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      value: currencyName,
                      dropdownColor: ColorPalette.primaryText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.secondaryText,
                        fontSize: 16,
                      ),
                      icon: const Icon(
                        Icons.change_circle_outlined,
                        size: 20,
                        color: ColorPalette.secondaryText,
                      ),
                      items: const [
                        DropdownMenuItem<String>(
                          value: "USD",
                          child: Text(
                            "USD",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Pound",
                          child: Text(
                            "Pound",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Euro",
                          child: Text(
                            "Euro",
                          ),
                        ),
                      ],
                      // elevation: 10,
                      // padding: const EdgeInsets.all(8),
                      onChanged: (selectedValue) {
                        setState(() {
                          currencyName = selectedValue.toString();
                          factor = currencyList
                              .firstWhere(
                                  (element) => element.name == currencyName)
                              .factor;
                        });
                      },
                    ),

                    // TextField
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
                              ),
                            ),
                            borderSide: BorderSide(
                              color: ColorPalette.secondaryText,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
                              ),
                            ),
                            borderSide: BorderSide(
                              color: ColorPalette.secondaryText,
                              width: 1.5,
                            ),
                          ),
                          focusColor: Colors.white,
                          hintText: "Enter amount in $currencyName",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            color: ColorPalette.secondaryText,
                          ),
                          filled: true,
                          fillColor: ColorPalette.bgColor,
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        style: const TextStyle(
                          color: ColorPalette.primaryText,
                          fontSize: 20,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        cursorColor: ColorPalette.primaryText,
                      ),
                    ),
                  ],
                ),
              ),

              // Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      convertedResult =
                          double.parse(textEditingController.text) * factor;
                      textEditingController.text = "";
                    });
                  },
                  style: const ButtonStyle(
                    // elevation: MaterialStatePropertyAll(2),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorPalette.primaryText,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      ColorPalette.secondaryText,
                    ),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 15,
                      ),
                    ),
                    foregroundColor: MaterialStatePropertyAll(
                      Colors.white,
                    ),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        // color: ColorPalette.primaryText,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    fixedSize: MaterialStatePropertyAll(
                      Size(double.maxFinite, 50),
                    ),
                  ),
                  child: const Text(
                    "Click to Convert",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
