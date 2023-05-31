import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: true,
        home: const HomePage(),
        theme: ThemeData(useMaterial3: true),
      ),
    );

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('eProdaja')),
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
                    color: Color.fromARGB(115, 247, 247, 247)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Email or Phone',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'FiraMono'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          decoration: InputDecoration(
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
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FiraMono',
                            fontSize: 20),
                      )),
                    )
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
