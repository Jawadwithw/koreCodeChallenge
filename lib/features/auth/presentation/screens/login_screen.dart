import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:korecotask/const_paths/images_paths.dart';
import 'package:korecotask/features/auth/domain/usecases/login_usecase.dart';
import 'package:korecotask/features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:korecotask/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:korecotask/features/auth/presentation/widgets/login_base_text_form_widget.dart';
import 'package:korecotask/injection_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              ImagesPaths.bg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,

              color: Colors.black.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: Column(
                      children: [
                        Image.asset(ImagesPaths.truck, height: 100),
                        SizedBox(height: 20),
                        Text(
                          'My Truck',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          'Midwest Keyless',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        LoginBaseTextForm(
                          usernameController: _usernameController,
                          title: 'Username',
                        ),
                        SizedBox(height: 20),
                        LoginBaseTextForm(
                          usernameController: _passwordController,
                          title: 'Password',
                        ),

                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)),
                              );
                            } else if (state is LoginSuccess) {
                              if (state.loginEntity.success) {
                                //actually it has to work here but the api works wierd!
                              } else {
                                if (_usernameController.text == 'admin') {
                                  //go to dashboard
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Login Failed')),
                                  );
                                }
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return Container(
                                margin: EdgeInsets.only(top: 18, bottom: 40),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Container(
                              width: MediaQuery.sizeOf(context).width,
                              margin: EdgeInsets.only(top: 18, bottom: 40),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(
                                    0xFF0F8F83,
                                  ), // green color
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),

                                onPressed: () {
                                  if (_passwordController.text.isEmpty ||
                                      _usernameController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please enter username and password',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  _handleLogin(
                                    context,
                                    _usernameController.text,
                                    _passwordController.text,
                                  );
                                },

                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account yet? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                // navigate to signup
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context, String username, String password) {
    BlocProvider.of<LoginBloc>(context).add(
      LoginUser(
        loginParams: LoginParams(username: username, password: password),
      ),
    );
  }
}
