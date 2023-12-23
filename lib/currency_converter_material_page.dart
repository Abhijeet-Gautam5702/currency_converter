// import 'package:flutter/foundation.dart';
import 'package:currency_converter/db.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
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
                  child: Text(
                    "₹ ${convertedResult.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      icon: const Icon(
                        Icons.change_circle_outlined,
                        size: 20,
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
                      elevation: 2,
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
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          focusColor: Colors.black,
                          hintText: "Enter amount in $currencyName",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(20),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        cursorColor: Colors.black,
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
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(2),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.blue,
                    ),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.all(12),
                    ),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Colors.blue.shade800,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    fixedSize: const MaterialStatePropertyAll(
                      Size(double.maxFinite, 50),
                    ),
                  ),
                  child: const Text(
                    "Click to Convert",
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
