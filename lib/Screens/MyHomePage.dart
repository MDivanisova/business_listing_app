import 'package:business_listing_app/Widgets/ListBuilderWidget.dart';
import 'package:flutter/material.dart';

import '../Models/Company.dart';
import '../Services/DatabaseHelper.dart';
import '../Services/ProximityTrackerService.dart';
import '../Widgets/AppBarWidget.dart';

import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<Company> fun = [];
  List<Company> services = [];
  List<Company> industry = [];
  List<Company> education = [];
  String filter = "";
  late final ProximityTracker _tracker;

  @override
  void initState()  {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _tracker.stop();
    super.dispose();
  }

  Future<void> _fetchData() async {
    List<Company> funData = await DatabaseHelper.instance.getAllCompanies('Fun');
    List<Company> servicesData = await DatabaseHelper.instance.getAllCompanies('Services');
    List<Company> industryData = await DatabaseHelper.instance.getAllCompanies('Industry');
    List<Company> educationData = await DatabaseHelper.instance.getAllCompanies('Education');
    setState(() {
      fun = funData;
      services = servicesData;
      industry = industryData;
      education = educationData;
    });

    _tracker = ProximityTracker(fun + services + industry + education);
    _tracker.start();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: appBarWidget(widget.title, context),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Services'),
              Tab(text: 'Fun'),
              Tab(text: 'Industry'),
              Tab(text: 'Education'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                    child: listBuilderWidget(
                        services.where((company) => company.name.toLowerCase().contains(filter.toLowerCase())).toList(),
                        widget.title
                    )
                ),
                Center(
                    child: listBuilderWidget(
                        fun.where((company) => company.name.toLowerCase().contains(filter.toLowerCase())).toList(),
                        widget.title
                    )
                ),
                Center(
                    child: listBuilderWidget(
                        industry.where((company) => company.name.toLowerCase().contains(filter.toLowerCase())).toList(),
                        widget.title
                    )
                ),
                Center(
                    child: listBuilderWidget(
                        education.where((company) => company.name.toLowerCase().contains(filter.toLowerCase())).toList(),
                        widget.title
                    )
                ),
              ],
            ),
          ),
          SearchBar(
            hintText: "Search",
            onChanged: (value){
              setState(() {
                filter = value;
              });
            },
          ),
          SizedBox(height: 50),
        ],
      ),
      ),
    );
  }
}
