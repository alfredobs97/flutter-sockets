import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Sockets {
  final socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
  });

  final _paintStreamController = StreamController<Offset>.broadcast();
  final _clearStreamController = StreamController<bool>.broadcast();

  bool isConnected = false;

  Sockets() {
    socket.onConnect((_) {
      isConnected = true;
    });
  }

  emitPaint(double dx, double dy) {
    if (isConnected) {
      socket.emit('canvas', '{"dx": $dx, "dy": $dy}');
    }
  }

  emitEndLine() {
    if (isConnected) {
      socket.emit('endLine');
    }
  }

  emitClearCanvas() {
    if (isConnected) {
      socket.emit('clearCanvas', '');
    }
  }

  Stream<Offset> recivedPaint() {
    if (isConnected) {
      socket.on('draw', (data) {
        final offset = jsonDecode(data);

        _paintStreamController.add(Offset(offset['dx'], offset['dy']));
      });

      socket.on('endLine', (data) => _paintStreamController.add(null));
    }

    return _paintStreamController.stream;
  }

  Stream<bool> clearCanvas() {
    if (isConnected) {
      socket.on('cleaningCanvas', (_) {
        _clearStreamController.add(true);
      });
    }

    return _clearStreamController.stream;
  }
}
