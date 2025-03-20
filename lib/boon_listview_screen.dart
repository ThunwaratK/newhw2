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
  List<BoonEntity?> boonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await SqfliteFloorService.instance.initializeDatabase();
    final database = SqfliteFloorService.instance.database;

    final fetchedBoons = await database.boonDao.findAllBoons();

    setState(() {
      boonList = fetchedBoons;
      isLoading = false;
    });
  }

  Future<void> _deleteBoon(int bid) async {
    final database = SqfliteFloorService.instance.database;

    await database.boonDao.deleteBoonByBID(bid);

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        title: Text(
          'Boon ListView',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const BoonFormScreen(mode: "add", boonId: null),
                ),
              ).then((_) => setState(() {}));
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<List<BoonEntity?>>(
        future: _fetchBoons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final boonList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final boon = boonList[index];
                  return Card(
                    color: Colors.green[200],
                    child: ListTile(
                      leading: IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.yellow[200],
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
                            onPressed: () {
                              if (boon?.bid != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => BoonFormScreen(
                                          mode: "edit",
                                          boonId: boon!.bid,
                                        ),
                                  ),
                                ).then((_) => setState(() {}));
                              }
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              if (boon?.bid != null) {
                                _deleteBoon(boon!.bid!);
                              }
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              if (boon?.bid != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => BoonFormScreen(
                                          mode: "view",
                                          boonId: boon!.bid,
                                        ),
                                  ),
                                );
                              }
                            },
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
            );
          }
        },
      ),
    );
  }

  Future<List<BoonEntity?>> _fetchBoons() async {
    await SqfliteFloorService.instance.initializeDatabase();
    final database = SqfliteFloorService.instance.database;
    return await database.boonDao.findAllBoons();
  }
}
