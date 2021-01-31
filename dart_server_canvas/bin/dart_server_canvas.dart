import 'package:socket_io/socket_io.dart';

import 'models/offset.dart';

void main(List<String> args) {
  final io = Server();
  io.on('connection', (client) {
    print('Client connected $client');

    client.join('canvasRoom');

    client.on('canvas', (data) {
      final offset = Offset.fromJson(data);

      io.to('canvasRoom').emit('draw', offset.toJson());
    });

    client.on('endLine', (data) {
      io.to('canvasRoom').emit('endLine', null);
    });

    client.on('clearCanvas', (data) {
      io.to('canvasRoom').emit('cleaningCanvas');
      io.to('canvasRoom').emit('endLine', null);
    });

  });
  io.listen(3000);
}
