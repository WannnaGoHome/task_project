// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'num_wm.dart';


@RoutePage()
class NumbersScreen extends ElementaryWidget<NumbersWidgetModel> {
  const NumbersScreen({super.key}) : super(createNumbersWidgetModel);

  @override
  Widget build(NumbersWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 248, 131, 170),
        foregroundColor: Colors.white,
        title: Text(
          "Факты о цифрах",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: wm.numberController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: Colors.pink[900],
                fontSize: 18.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Введите число',
                labelStyle: GoogleFonts.montserrat(
                  color: Colors.pink[700],
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            StateNotifierBuilder<String>(
              listenableState: wm.factText,
              builder: (_, fact) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    fact ?? 'Здесь будет ваш факт',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      height: 1.4,
                      color: Colors.pink[900],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 25.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 136, 210, 194),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              onPressed: () {
                wm.onShowFactPressed();
              },
              child: Text(
                'Узнать факт',
                style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 12.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 248, 131, 170),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              onPressed: () {wm.onRandomFactPressed();},
              child: Text(
                'Рандомный факт',
                style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
