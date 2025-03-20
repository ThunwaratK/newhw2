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
  List<BoonEntity?> boonList = []; // Initialize as an empty list
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data asynchronously
  }

  Future<void> _loadData() async {
    // Ensure the database is initialized
    await SqfliteFloorService.instance.initializeDatabase();
    final database = SqfliteFloorService.instance.database;

    // Insert a sample record (optional, for testing purposes)
    BoonEntity boon1 = BoonEntity(
      title: 'ตักบาตรฟังธรรม',
      desc: 'สวนแสงธรรม',
      eventDate: '16 มี.ค. 2568',
      startHour: 'startHour2',
      startMinute: 'startMinute2',
      location: 'สวนแสงธรรม',
    );
    await database.boonDao.insertBoon(boon1);

    // Fetch all records
    final fetchedBoons = await database.boonDao.findAllBoons();

    // Update the state
    setState(() {
      boonList = fetchedBoons;
      isLoading = false; // Set loading to false
    });
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
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show a loading spinner
              : boonList.isEmpty
              ? Center(
                child: Text('No data available'),
              ) // Show a message if the list is empty
              : Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final boon = boonList[index];
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
                          boon?.title ?? '',
                          style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        subtitle: Text(
                          '${boon?.location ?? ''} ${boon?.eventDate ?? ''}',
                          style: GoogleFonts.openSans(
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                            ),
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
