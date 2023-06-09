import 'package:flutter/material.dart';
import 'package:myapp/providers/cart_provider.dart';
import 'package:myapp/providers/order_provider.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screens/products/cart/cart_screen.dart';
import 'package:myapp/screens/products/product_list_screen.dart';
import 'package:myapp/screens/products/products/product_details_screen.dart';
import 'package:myapp/theme/theme.dart';
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
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => OrderProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          onGenerateRoute: (settings) {
            if (settings.name == ProductListScreen.routeName) {
              return MaterialPageRoute(
                  builder: ((context) => const ProductListScreen()));
            } else if (settings.name == CartScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => const CartScreen()),
              );
            }
            var uri = Uri.parse(settings.name!);
            if (uri.pathSegments.length == 2 &&
                '/${uri.pathSegments.first}' ==
                    ProductDetailsScreen.routeName) {
              var id = uri.pathSegments[1];
              return MaterialPageRoute(
                builder: ((context) => ProductDetailsScreen(id)),
              );
            }

            return null;
          },
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkThme,
          themeMode: ThemeMode.system,
        ),
      ),
    );

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dark_mode_outlined),
          )
        ],
        title: const Center(
          child: Text('test_app'),
        ),
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
                          try {
                            Authorization.username = _usernameController.text;
                            Authorization.password = _passwordController.text;
                            await _userProvider.get();

                            Navigator.pushNamed(
                                context, ProductListScreen.routeName);
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Error"),
                                content: const Text(
                                  "Incorrect username or password ",
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ),
                            );
                          }
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
