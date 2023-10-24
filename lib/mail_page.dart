import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/hotmail.dart';
import 'package:mailer/smtp_server/yandex.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final outlookSmtp =
      hotmail(dotenv.env["OUTLOOK_EMAIL"]!, dotenv.env["OUTLOOK_PASSWORD"]!);

  final yandexSmtp =
      yandex(dotenv.env["YANDEX_EMAIL"]!, dotenv.env["YANDEX_PASSWORD"]!);

  sendMailFromOutlook() async {
    final message = Message()
      ..from = Address(dotenv.env["OUTLOOK_EMAIL"]!, 'Confirmation Bot')
      ..recipients.add('yigivib607@wisnick.com')
      ..subject = 'This is just a test mail.'
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.';
      ..html =
          '<body style="text-align: center; font-family: Tahoma, Geneva, Verdana, sans-serif;"> <div style="margin:auto; border-radius: 10px; width: 300px; padding: 10px; box-shadow: 1px 1px 1px 1px rgb(174, 174, 174);"> <img style="height: 150px;" src="https://static.vecteezy.com/system/resources/previews/018/930/122/non_2x/email-marketing-campaign-subscription-on-web-and-sending-email-newsletter-for-discount-or-promotion-information-businessmen-standing-next-to-email-envelope-announcing-promotion-through-megaphone-vector.jpg" alt="newsletter"> <h2>Thanks for accepting our Newsletter 🙌</h2> <p>Now you will never miss any updates.</p><p>Thanks for your support 😍</p></div></body>';

    try {
      final sendReport = await send(message, outlookSmtp);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  sendMailFromYandex() async {
    final message = Message()
      ..from = Address(dotenv.env["YANDEX_EMAIL"]!, 'Confirmation Bot')
      ..recipients.add('yigivib607@wisnick.com')
      ..subject = 'This is just a test mail from yandex.'
      // ..text = 'This is the plain text.\nThis is line 2 of the text part.';
      ..html =
          '<body style="text-align: center; font-family: Tahoma, Geneva, Verdana, sans-serif;"> <div style="margin:auto; border-radius: 10px; width: 300px; padding: 10px; box-shadow: 1px 1px 1px 1px rgb(174, 174, 174);"> <img style="height: 150px;" src="https://static.vecteezy.com/system/resources/previews/018/930/122/non_2x/email-marketing-campaign-subscription-on-web-and-sending-email-newsletter-for-discount-or-promotion-information-businessmen-standing-next-to-email-envelope-announcing-promotion-through-megaphone-vector.jpg" alt="newsletter"> <h2>Thanks for accepting our Newsletter 🙌</h2> <p>Now you will never miss any updates.</p><p>Thanks for your support 😍</p></div></body>';

    try {
      final sendReport = await send(message, yandexSmtp);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Mail From App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text("Send Mail From Outlook"),
                onPressed: () {
                  sendMailFromOutlook();
                }),
            ElevatedButton(
                child: Text("Send Mail From Yandex"),
                onPressed: () {
                  sendMailFromYandex();
                }),
          ],
        ),
      ),
    );
  }
}
