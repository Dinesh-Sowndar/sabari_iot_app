import 'package:IoT_App/services/api_services/fireRD.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CountState extends GetxController {
  FirebaseDatabaseUtil fireApi = new FirebaseDatabaseUtil();

  List entries = [];

  addentries(data) {
    entries.add(data);
    update();
  }

  removeEntries() {
    entries = [];
    update();
  }

  createHistory(name) async {
    if (entries.isNotEmpty) {
      entries.add({
        "machine": name,
        "line": "RESET",
        "time_in": DateFormat('hh:mm aa').format(DateTime.now()),
        "time_out": "",
        "date": DateFormat('dd-MM-yyyy').format(DateTime.now())
      });
    }
    fireApi.initState();
    await fireApi.addHistory(entries).then((value) {
      removeEntries();
    });
  }
}
