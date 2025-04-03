import 'package:app_asistencias/services/mysql/noti_queries.dart';
import 'package:app_asistencias/services/notifications_service.dart';

class NotiController {
  NotiQueries notiQueries = NotiQueries();

  List<String> notifications = [];

  Future<void> showNotificacion(int userId) async {
    var result = await notiQueries.getNotifications(userId);

    if (result.isNotEmpty) {
      int i = 0;
      for (var noti in result) {
        showNotification(
          id: i++,
          mensaje: noti.toString(),
        );
      }
    }
  }
}