import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _gender = "male"; // за замовчуванням чоловік
  double? _weight;

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
      appBar: AppBar(title: const Text("Встановіть свої дані")),
      body: Padding(
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
                              0.4, // 40% висоти екрану
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
                const SizedBox(width: 16),
                // Права частина: форма для ваги
                Expanded(
                  flex: 1,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Вага (кг)",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) return "Введи вагу";
                            final number = double.tryParse(val);
                            if (number == null || number <= 0)
                              return "Некоректна вага";
                            return null;
                          },
                          onSaved: (val) => _weight = double.parse(val!),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text("Продовжити"),
            ),
          ],
        ),
      ),
    );
  }
}
