import 'dart:convert';
import 'package:http/http.dart' as http;

class MixpanelService {
  Future<void> sendEventToMixpanel(String event, String description) async {
    String apiUrl = 'https://pursueit.in:8080/user/addEvent';

    Map<String, dynamic> requestBody = {
      "Event": event,
      "Object": description,
    };
    String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );
      if (response.statusCode == 200) {
        print('Event sent successfully');
      } else {
        print('Failed to send event. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending event: $e');
    }
  }
}
