import 'dart:io';

void main(List<String> args){
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 9000).then((RawDatagramSocket socket){
    print('Datagram socket ready to receive');
    print('${socket.address.address}:${socket.port}');


    socket.listen((RawSocketEvent e){
      Datagram? d = socket.receive();
      if (d == null) return;

      String message = new String.fromCharCodes(d.data).trim();
      print('Datagram from ${d.address.address}:${d.port}: ${message}');

      /*
      *
      *
      *
      *
      * */

    });
  });
}