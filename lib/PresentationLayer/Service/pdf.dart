import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfApi {
  static Future<File> generateCenteredText(
      month,
      date,
      transportationMode,
      designationPIC,
      location,
      equipmentName,
      tagNo,
      serialNo,
      model,
      physicalCondition,
      statusEquipment,
      referenceNo,
      acknowledgmentReceipt,
      acknowledgmentReceiptName,
      acknowledgmentReceiptDate) async {
    final pdf = pw.Document();

    //date only
    var myFormat = DateFormat('d-MM-yyyy');

    var value = pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text("Equipment Delivery Form",
                    style: pw.TextStyle(
                        font: pw.Font.timesBold(),
                        fontSize: 20,
                        decoration: pw.TextDecoration.underline))
              ]),
              pw.SizedBox(height: 30),
              pw.Divider(thickness: 1, color: const PdfColor(0, 0, 0, 1.0)),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Month : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(month,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Date : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(date,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Transportation Mode : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(transportationMode,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("PIC Name & Designation : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(designationPIC,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Location : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(location,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Equipment Name : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(equipmentName,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
                pw.Text("Tag no : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(tagNo,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Serial No : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(serialNo,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Model : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(model,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Physical Condition : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(physicalCondition,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Status Equipment : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(statusEquipment,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Reference No : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(referenceNo,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Acknowledge Receipt from Admin : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(acknowledgmentReceipt,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Admin Name: ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(acknowledgmentReceiptName,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Acknowledgement Receipt (Date) : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(acknowledgmentReceiptDate,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline
                    )),
              ]),
            ]);
          }),
    );
    return saveDocument(name: 'EquipmentDeliveryDetails.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
