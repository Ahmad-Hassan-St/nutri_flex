import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifefit/screens/diet%20plan/show_dietPlan_screens.dart';
import 'package:lifefit/screens/profile%20screens/profile_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int selectedIndex = 2;

  final List<Widget> screenList = <Widget>[
    const Text("Home1", style: TextStyle(fontSize: 50, color: Colors.red)),
    // const Text("Reports", style: TextStyle(fontSize: 50, color: Colors.red)),
    ShowDietScreen(),
    const Text("Stats", style: TextStyle(fontSize: 50, color: Colors.red)),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screenList[selectedIndex]),
      bottomNavigationBar: Container(
        width: 339,
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: CustomBottomNavigationBar(
          items: [
            BottomNavItem(icon: 'assets/icons/home.svg', text: 'Home'),
            BottomNavItem(icon: 'assets/icons/reports.svg', text: 'Trains'),
            BottomNavItem(icon: 'assets/icons/stats.svg', text: 'Bookings'),
            BottomNavItem(icon: 'assets/icons/profile.svg', text: 'Setting'),
          ],
          selectedIndex: selectedIndex,
          onTabSelected: (index) {
            selectedIndex = index;
            setState(() {});
          },
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigationBar({
    required this.items,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((item) {
          var index = widget.items.indexOf(item);
          return GestureDetector(
            onTap: () {
              widget.onTabSelected(index);
            },
            child: _buildItem(
              item.icon,
              item.text,
              index == widget.selectedIndex,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem(String icon, String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      decoration: BoxDecoration(
        // color: Colors.blue,
        border: isSelected
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Color of top border
                  width: 3.0, // Width of top border
                ),
              )
            : null,
      ),
      child: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
      ),
    );
  }
}

class BottomNavItem {
  final String icon;
  final String text;

  BottomNavItem({required this.icon, required this.text});
}
