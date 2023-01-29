import 'package:url_launcher/url_launcher.dart';

class CommonActions {
  static void makeCall(String mobNo) {
    final Uri telLaunchUri = Uri(
      scheme: 'tel',
      path: mobNo,
    );
    launchUrl(telLaunchUri);
  }

  static void sendSms(String mobNo, String content) {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: mobNo,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent(content),
      },
    );
    launchUrl(smsLaunchUri);
  }

  static void sendEmail(String email, String subject, String content) {
    final Uri mailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: <String, String>{
        'subject': Uri.encodeComponent(subject),
        'body': Uri.encodeComponent(content),
      },
    );
    launchUrl(mailLaunchUri);
  }
}
