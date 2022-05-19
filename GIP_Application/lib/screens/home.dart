import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var conn;
  List<Elem> list = [];

  Future<void> dbConnection() async {
    conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'ID191774_6itngip15.db.webhosting.be',
        port: 3306,
        user: 'ID191774_6itngip15',
        password: 'Zs21f5sdf5',
        db: 'ID191774_6itngip15'));
    var result = await conn.query(
        'SELECT * FROM (SELECT * FROM tbl_numberplates ORDER BY id DESC LIMIT 5) as r ORDER BY id');
    /* resultList = result; */
    print(result);
    list = [];
    for (var row in result) {
      Elem e = Elem();
      e.plate = row[1];
      e.timestamp = row[2];
      list.add(e);
    }
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container();
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.deepPurple[100],
              elevation: 7,
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                    child: Text("Plate: " +
                        list[index].plate +
                        "\nTimestamp: " +
                        list[index].timestamp.toString(),
                        style: const TextStyle(fontSize: 20, color: Colors.white,)),
                ),
              ),
            );
          }
        );
      },
      future: dbConnection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return projectWidget();
  }
}

class Elem {
  String plate;
  DateTime? timestamp;

  Elem({
    this.plate = "",
    this.timestamp,
  });
}
