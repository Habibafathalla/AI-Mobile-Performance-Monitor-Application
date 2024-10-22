
import 'package:ai_device/screens/battery_screen.dart';
import 'package:ai_device/screens/home_screen.dart';
import 'package:ai_device/screens/memory_screen.dart';
import 'package:ai_device/screens/network_screen.dart';
import 'package:ai_device/screens/storage_screen.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {

  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
            child:  Column(
            mainAxisAlignment:MainAxisAlignment.start ,
              children: [
                Container(
                alignment: Alignment.center,
                width: 90,
                height: 90,
                child: Image.asset(
                  'assets/images/performance-monitor_logo.png',
                  alignment: Alignment.center,
                  
                  ),
              )
              ,
              const SizedBox(width: 10,),
                  Text(
                "PerfMonitor AI",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: const  Color.fromARGB(255, 42, 51, 128))
                ,
                  ),
              ],
            ),
      ),
           ListTile(
            leading: const Icon(Icons.chat,
            color:  Color.fromARGB(255, 42, 51, 128),
            size: 30,
            ),
            title:const Text('Chat with AI',
              style: TextStyle(color: Color.fromARGB(255, 42, 51, 128),)),
            onTap: () => {Navigator.of(context).pop(),
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen(),))

            },
            
          ),
          const SizedBox(height: 10,),

          ListTile(
            leading: const Icon(Icons.memory_outlined,
            color:  Color.fromARGB(255, 42, 51, 128),
            size: 30,
            ),
            title:const Text('Memory',
              style: TextStyle(color: Color.fromARGB(255, 42, 51, 128),)),
            onTap: () => {Navigator.of(context).pop(),
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  MemoryInfoScreen(),))

            },
            
          ),
          const SizedBox(height: 10,)
          ,
          ListTile(
            leading: const Icon(
              Icons.battery_4_bar_rounded,
              size: 30,
              color: Colors.green,

            ),
            title:const Text(
              'Battery Health',
              style: TextStyle(color: Color.fromARGB(255, 42, 51, 128),)
              ),
            onTap: () => {Navigator.of(context).pop(),
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  BatteryScreen(),))

            },
          ),
          const SizedBox(height: 10,)
          ,
          ListTile(
            leading: const Icon(
              Icons.storage_rounded,
              size: 30,
              color: Color.fromARGB(255, 42, 51, 128),

            ),
            title:const Text(
              'Storage',
              style: TextStyle(color: Color.fromARGB(255, 42, 51, 128),)
              ),
            onTap: () => {Navigator.of(context).pop(),
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StorageInfoPage(),))


            },
          ),
          const SizedBox(height: 10,),
          
       ListTile(
            leading: const Icon(
              Icons.wifi,
              size: 30,
              color: Color.fromARGB(255, 75, 92, 244),
            ),
            title: const Text(
              'Network',
              style: TextStyle(color: Color.fromARGB(255, 42, 51, 128)),
            ),
            onTap: () {
              Navigator.of(context).pop(); 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NetworkScreen(),
                ),
              );
            },
          ),
 
            
          ],
        ),
      
      
      ),
    );
  }

}