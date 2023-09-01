// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/news_model.dart';
import 'package:flutter_scale/screens/tabbarmenu/news/news_items_horizontal.dart';
import 'package:flutter_scale/screens/tabbarmenu/news/news_items_vertical.dart';
import 'package:flutter_scale/services/rest_api.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'ข่าวล่าสุด ',
                // + DateTime.now().second.toString() +' นาทีที่แล้ว',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 210,
              // child: newsItemHorizontalList(),
              child: FutureBuilder(
                future: CallAPI().getLastNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('มีข้อผิดพลาด โปรดลองใหม่อีกครั้ง'),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<NewsModel> news = snapshot.data;
                    return newsItemHorizontalList(news);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'ข่าวทั้งหมด',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: CallAPI().getAllNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('มีข้อผิดพลาด โปรดลองใหม่อีกครั้ง'),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<NewsModel> news = snapshot.data;
                    return newsItemVerticalList(news);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
