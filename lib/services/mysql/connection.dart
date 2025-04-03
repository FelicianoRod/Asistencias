import 'package:mysql1/mysql1.dart';

class Connection {
  static String host = 'codew4ves.com',
      user = 'u732277365_root',
      password = 'Coba2005',
      db = 'u732277365_coba';
  static int port = 3306;

  Connection();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db);
    return await MySqlConnection.connect(settings);
  }

}