// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class QRCodeScannerScreen extends StatefulWidget {
//   const QRCodeScannerScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _QRCodeScannerScreenState();
// }
//
// class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String? qrCodeResult;
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Сканировать QR-код'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.blue,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: 300,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (qrCodeResult != null)
//                   ? Text('Результат: $qrCodeResult')
//                   : const Text('Сканируйте QR-код'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrCodeResult = scanData.code;
//       });
//
//       // Если QR-код содержит URL, откройте его
//       if (_isURL(qrCodeResult)) {
//         _launchURL(qrCodeResult!);
//       }
//     });
//   }
//
//   bool _isURL(String? code) {
//     // Проверка, является ли код ссылкой
//     if (code == null) return false;
//     final uri = Uri.tryParse(code);
//     return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
//   }
//
//   Future<void> _launchURL(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Не удалось открыть $url';
//     }
//   }
// }
