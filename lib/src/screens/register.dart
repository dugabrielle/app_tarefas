import 'package:app_tarefas/src/widgets/input_decorations.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    required bool darkMode,
    required void Function() alternarTema,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  RegExp senhaRequisitos = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!#%@*$]).{8,40}$',
  );

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E7F8),
      body: Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            padding: const EdgeInsets.only(top: 40, left: 10),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80.0, left: 20.0),
                child: Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              height: 500,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFD5B1E3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // campo nome
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputStyleDecoration.style().copyWith(
                          labelText: 'Nome de usuário',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: _validarNome,
                      ),
                      const Expanded(child: SizedBox()),
                      // campo email
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputStyleDecoration.style().copyWith(
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: _validarEmail,
                      ),
                      const Expanded(child: SizedBox()),

                      // campo senha
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor, digite a senha.";
                          } else {
                            bool result = validarSenha(value);
                            if (result) {
                              return null;
                            } else {
                              return "A senha deve conter entre 8 e 40 caracteres, ao menos uma letra maiúscula, uma minúscula, um caractere especial e um número.";
                            }
                          }
                        },
                        obscureText: _obscureText,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputStyleDecoration.style().copyWith(
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              const Color(0xFF9C3EC8),
                            ),
                            fixedSize: WidgetStateProperty.all(
                              const Size.fromWidth(130),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.all(16),
                            ),
                          ),
                          onPressed: () {
                            _formKey.currentState!.validate();
                            // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          },
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Já tem uma conta? ',
                                style: TextStyle(
                                  color: Color(0xFF2E2E2E),
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Entre',
                                    style: TextStyle(
                                      color: Color(0xFF003366),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validarNome(String? nome) {
    if (nome == null || nome.isEmpty) {
      return "Nome invalido";
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O e-mail não pode estar vazio.';
    }
    return null;
  }

  bool validarSenha(String sen) {
    String senha = sen.trim(); // remove espaços

    if (senhaRequisitos.hasMatch(senha)) {
      return true; // se senha for válida
    } else {
      return false;
    }
  }
}
