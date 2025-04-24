import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:map_launcher/map_launcher.dart';

// Extracts the domain from a given url.
///
/// Example: https://www.google.com/search?q=flutter -> google.com
String extractPathWithoutSchema(String domain) {
  RegExp pathRegExp = RegExp(r'^(?:https?://)?(?:www\.)?([^/]+)(.*)$');
  final match = pathRegExp.firstMatch(domain);
  if (match != null) {
    String withoutSchema = match.group(1) ?? '';
    return withoutSchema.startsWith('www.')
        ? withoutSchema.substring(4)
        : withoutSchema;
  }
  return '';
}

class UrlUtils {
  static launchPhone({required String phoneNum}) async {
    try {
      Uri phone = Uri(scheme: 'tel', path: phoneNum);
      await launchUrl(phone);
    } catch (_) {
      debugPrint('Invalid Phone Number: $phoneNum');
    }
  }

  static launchSMS({required String phoneNum}) async {
    try {
      Uri phone = Uri(scheme: 'sms', path: phoneNum);
      await launchUrl(phone);
    } catch (_) {
      debugPrint('Invalid Phone Number: $phoneNum');
    }
  }

  static launchEmail({required String emailAddress}) async {
    try {
      Uri email = Uri(scheme: 'mailto', path: emailAddress);
      await launchUrl(email);
    } catch (_) {
      debugPrint('Invalid Email: $emailAddress');
    }
  }

  static void openUrl({required String url}) async {
    try {
      Uri link = Uri(
        scheme: !url.contains('https://') ? 'https' : '',
        path: url,
      );
      await launchUrl(link);
    } catch (e) {
      debugPrint('Invalid link: $url  $e');
    }
  }

  static void openUrlInAppWebView({required String url}) async {
    try {
      Uri link = Uri.parse(url); // Parse the URL string into Uri
      await launchUrl(
        link,
        mode: LaunchMode.platformDefault,
        webViewConfiguration:
            const WebViewConfiguration(), // Optional: Customize WebViewConfiguration if needed
        webOnlyWindowName:
            '_blank', // Optional: Set webOnlyWindowName if needed
      );
    } catch (e) {
      debugPrint('Invalid link: $url $e');
    }
  }

  // static showDirections(
  //     {required String latitude, required String longitude}) async {
  //   try {
  //     final coOrds = Coords(latitude.isNotEmpty ? double.parse(latitude) : 0.0,
  //         longitude.isNotEmpty ? double.parse(longitude) : 0.0);
  //     final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
  //     await availableMaps.first.showDirections(
  //       destination: coOrds,
  //     );
  //   } catch (_) {
  //     debugPrint(
  //         'Invalid Latitude or Longitude: \nlatitude: $latitude\nlongitude: $longitude');
  //   }
  // }

  static launchWhatsApp({
    required String contact,
    String textMessage = 'Hi, I would like to know about the Product',
  }) async {
    var androidUrl = 'https://whatsapp://send?phone=$contact&text=$textMessage';
    var iosUrl = 'https://wa.me/$contact?text=${Uri.parse(textMessage)}';

    try {
      if (!Platform.isIOS) {
        await launchUrl(
          Uri.parse(iosUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        await launchUrl(
          Uri.parse(androidUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Invalid Phone Number: $contact $e');
    }
  }
}
