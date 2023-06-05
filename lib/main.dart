import 'package:flutter/material.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screens/products/product_list_screen.dart';
import 'package:myapp/utils/util.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          onGenerateRoute: (settings) {
            if (settings.name == ProductListScreen.routeName) {
              return MaterialPageRoute(
                  builder: ((context) => const ProductListScreen()));
            }
            return null;
          },
          theme: ThemeData(useMaterial3: true),
        ),
      ),
    );

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('test_app')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 120,
                    left: 120,
                    child: Container(
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'FiraMono',
                              fontSize: 55,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(115, 247, 247, 247)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Email or Phone',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'FiraMono'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'FiraMono'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 55,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(219, 170, 241, 1),
                            Color.fromRGBO(33, 211, 255, 1),
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          Authorization.username = _usernameController.text;
                          Authorization.password = _passwordController.text;
                          await _userProvider.get();
                          Navigator.pushNamed(
                              context, ProductListScreen.routeName);
                        },
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'FiraMono',
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 164, 197, 255)))),
                      child: const Text(
                        'Forget password ?',
                        style: TextStyle(
                            fontFamily: 'FiraMono', color: Colors.black87),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
