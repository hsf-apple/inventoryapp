import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../../DataLayer/Model/DeliveryModel.dart';

Future<void> sendQueryReminderNotification(
    DeliveryModel deliveryModel) async {
  DateTime value = DateTime.now();

  DateTime value1 =  value;
  // Add 3 seconds to the current date and time
  DateTime newTime = value1.add(const Duration(seconds: 6));


  // Create a new Random object
  final random = Random();

  // Generate a random and unique integer value
  int randomInt = random.nextInt(1000000);

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: randomInt,
        groupKey: '${deliveryModel.equipmentName} ${deliveryModel.serialNo}' ,
        channelKey: 'scheduled_channel',
        title: 'Data Added Successfully!!',
        body: deliveryModel.equipmentName,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: newTime.year,
        month: newTime.month,
        day: newTime.day,
        hour: newTime.hour,
        minute:newTime.minute,
        second:newTime.second,
        millisecond: 0,
        repeats: false,
        allowWhileIdle:true,
      ));
}
