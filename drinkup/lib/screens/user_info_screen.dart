import 'package:drinkup/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_picker/wheel_picker.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _gender = "male"; // за замовчуванням чоловік
  double? _weight;

  final List<int> weights = List.generate(200, (i) => i + 30);

  int selectedIndex = 0; // стан вибраного елемента

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("gender", _gender);
      await prefs.setDouble("weight", _weight!);
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }

  void _toggleGender() {
    setState(() {
      _gender = _gender == "male" ? "female" : "male";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Встановіть свої дані",
          style: TextStyle(
            fontSize: 24, // потрібний розмір тексту
            fontWeight: FontWeight.bold, // за бажанням зробити жирним
          ),
          textAlign: TextAlign.center, // текст по середині
        ),
        backgroundColor:
            AppColors.backgroundcolor, // змінюємо колір фону AppBar
        centerTitle: true, // ще одна опція для центрування на iOS/Android
      ),
      body: Container(
        color: AppColors.backgroundcolor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  // Ліва частина: зображення
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: _toggleGender,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _gender == "male"
                                ? "assets/images/male.png"
                                : "assets/images/female.png",
                            height:
                                MediaQuery.of(context).size.height *
                                0.7, // 40% висоти екрану
                            fit: BoxFit.fitHeight,
                          ),

                          // const SizedBox(height: 16),
                          // Text(
                          //   _gender == "male" ? "Чоловік" : "Жінка",
                          //   style: const TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Колесо з числами
                      SizedBox(
                        height: 210, // висота колеса
                        width: 70, // ширина колеса
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 70,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) => Center(
                              child: Text(
                                weights[index].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            childCount: weights.length,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Статичний текст "кг"
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: const Text(
                          "кг",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Права частина: форма для ваги
                  // Expanded(
                  //   flex: 1,
                  //   child: Form(
                  //     key: _formKey,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         TextFormField(
                  //           decoration: const InputDecoration(
                  //             labelText: "Вага (кг)",
                  //           ),
                  //           keyboardType: TextInputType.number,
                  //           validator: (val) {
                  //             if (val == null || val.isEmpty) return "Введи вагу";
                  //             final number = double.tryParse(val);
                  //             if (number == null || number <= 0)
                  //               return "Некоректна вага";
                  //             return null;
                  //           },
                  //           onSaved: (val) => _weight = double.parse(val!),
                  //         ),
                  //         const SizedBox(height: 24),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // колір кнопки
                      foregroundColor: Colors.white, // колір тексту
                    ),
                    child: const Text(
                      "Продовжити",
                      style: TextStyle(
                        fontSize: 20, // потрібний розмір тексту
                        fontWeight:
                            FontWeight.bold, // за бажанням зробити жирним
                      ),
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
