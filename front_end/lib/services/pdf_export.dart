import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportPlanAsPdf(Map<String, dynamic> plan) async {
  final pdf = pw.Document();
  final days = plan["week_plan"] as List<dynamic>;

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Center(
          child: pw.Text(
            "Weekly Nutrition Plan",
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 20),
        ...days.map((day) => _pdfDay(day)),
      ],
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/nutrition_plan.pdf");

  await file.writeAsBytes(await pdf.save());

  await Printing.sharePdf(bytes: await pdf.save(), filename: "nutrition_plan.pdf");
}

pw.Widget _pdfDay(dynamic day) {
  final meals = day["meals"];

  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(day["day"],
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        _pdfMeal("Breakfast", meals["breakfast"]),
        _pdfMeal("Lunch", meals["lunch"]),
        _pdfMeal("Dinner", meals["dinner"]),
        _pdfMeal("Snacks", meals["snacks"]),
      ],
    ),
  );
}

pw.Widget _pdfMeal(String title, List<dynamic> options) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(title,
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
      ...options.map((e) => pw.Text("• $e")),
      pw.SizedBox(height: 10),
    ],
  );
}
