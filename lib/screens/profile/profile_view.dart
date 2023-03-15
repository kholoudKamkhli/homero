import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            child: ClipRRect(
              child: Image.asset("assets/images/img_32.png"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Sara ali",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Edit Profile",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 126, 127, 131),
                fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 328,
            height: 1,
            decoration:const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                     Icons.notifications_none,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 115,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.menu_book_outlined,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "My orders",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 125,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.library_books,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.wallet,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Wallet",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.payment,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 145,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
