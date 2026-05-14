import 'package:business_listing_app/Screens/DetailsScreen.dart';
import 'package:flutter/material.dart';

import '../Models/Company.dart';

Widget listBuilderWidget(List<Company>companies, String title){
  return ListView.builder(
    itemCount: companies.length,
    itemBuilder: (context, index) {
      final company = companies[index];
      return ListTile(
        leading: Image.network(
          company.icon,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) => Icon(Icons.business),
        ),
        title: Text(company.name),
        subtitle: Text("${company.address} ${company.phone} ${company.webPage}"),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(title: title, company: company,), settings: RouteSettings(name: '/details')));
        },
      );
    },
  );
}