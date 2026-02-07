import 'package:chatgpt_app/features/home/data/models/chat_message_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatMessage', () {
    const message = ChatMessage(
      text: 'Hello',
      isUser: true,
      status: MessageStatus.success,
    );

    test('toJson returns correct map', () {
      final json = message.toJson();
      expect(json, {
        'text': 'Hello',
        'isUser': true,
        'status': 1, // MessageStatus.success index
      });
    });

    test('fromJson returns correct object', () {
      final json = {'text': 'Hello', 'isUser': true, 'status': 1};
      final result = ChatMessage.fromJson(json);
      expect(result.text, 'Hello');
      expect(result.isUser, true);
      expect(result.status, MessageStatus.success);
    });

    test('fromJson handles missing status (defaulting to success/0)', () {
      // Logic in fromJson: values[json['status'] ?? 0]
      // MessageStatus.sending is 0.

      final json = {'text': 'Hello', 'isUser': true};
      final result = ChatMessage.fromJson(json);
      expect(result.status, MessageStatus.sending); // index 0
    });

    test('shouldAnimate is not serialized and defaults to false', () {
      const msg = ChatMessage(text: 'hi', isUser: false, shouldAnimate: true);
      final json = msg.toJson();
      expect(json.containsKey('shouldAnimate'), false);

      final restored = ChatMessage.fromJson(json);
      expect(restored.shouldAnimate, false);
    });
  });
}
