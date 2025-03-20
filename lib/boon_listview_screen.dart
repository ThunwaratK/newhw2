import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'boon_entity.dart';
import 'boon_form_screen.dart';
import 'sqflite_floor_service.dart';

class BoonListViewScreen extends StatefulWidget {
  const BoonListViewScreen({super.key});

  @override
  State<BoonListViewScreen> createState() => _BoonListViewScreenState();
}

class _BoonListViewScreenState extends State<BoonListViewScreen> {
  late List<BoonEntity?> boonList;
  @override
  void initState() async {
    final database = SqfliteFloorService.instance.database;
    BoonEntity boon1 = BoonEntity(
      title: 'ตักบาตรฟังธรรม',
      desc: 'สวนแสงธรรม',
      eventDate: '16 มี.ค. 2568',
      startHour: 'startHour2',
      startMinute: 'startMinute2',
      location: 'สวนแสงธรรม',
    );
    database.boonDao.insertBoon(boon1);
    boonList = await database.boonDao.findAllBoons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'Boon ListView',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[400],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BoonFormScreen(),
                  settings: RouteSettings(arguments: null),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.purple[200],
                    child: Icon(Icons.place),
                  ),
                  onPressed: () {},
                ),
                title: Text(
                  boonList[index].title,
                  style: GoogleFonts.openSans(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                subtitle: Text(
                  '${boonList[index].location} ${boonList[index].eventDate}',
                  style: GoogleFonts.openSans(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 10,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder:
              (BuildContext context, int index) => const Divider(),
          itemCount: boonList.length,
        ),
      ),
    );
  }
}
