import 'package:business_listing_app/Widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

import '../Models/Company.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final Company company;
  const DetailsScreen({super.key, required this.title, required this.company});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appBarWidget(title, context),
         body: Padding(
             padding: EdgeInsetsGeometry.all(16),
             child: Column(
               children: [
                 Row(
                   children: [
                     Image.network(
                       width: 100,
                       height: 100,
                       company.icon,
                       loadingBuilder: (context, child, loadingProgress) {
                         if (loadingProgress == null) return child;
                         return CircularProgressIndicator();
                       },
                       errorBuilder: (context, error, stackTrace) => Icon(Icons.business),
                     ),
                     SizedBox( width: 20),
                     Column(
                       children: [
                         Row(
                           children: [
                             Text(
                                 style: TextStyle(
                                     fontWeight: FontWeight(1000)
                                 ),
                                 "Name:"),
                             SizedBox(width: 10),
                             Text(company.name),
                           ],
                         ),
                         SizedBox(height: 10),
                         Row(
                           children: [
                             Text(
                                 style: TextStyle(
                                     fontWeight: FontWeight(1000)
                                 ),
                                 "Lat:"),
                             SizedBox(width: 10),
                             Text('${company.lat}'),
                             SizedBox(width: 20),
                             Text(
                                 style: TextStyle(
                                     fontWeight: FontWeight(1000)
                                 ),
                                 "Lon:"),
                             SizedBox(width: 10),
                             Text('${company.lon}'),
                           ],
                         )

                       ],
                     )
                   ],
                 ),
                 SizedBox( height: 20,),
                 Row(
                   children: [
                     Text(
                         style: TextStyle(
                             fontWeight: FontWeight(1000)
                         ),
                         "Category: "),
                     SizedBox( width: 10,),
                     Text(company.category),
                   ],
                 ),
                 SizedBox( height: 20,),
                 Row(
                   children: [
                     Text( 
                         style: TextStyle(
                           fontWeight: FontWeight(1000)
                         ),
                         "Address: "),
                     SizedBox(width: 10),
                     Text(
                         textAlign: TextAlign.left,
                         company.address
                     ),
                   ]
                 ),
                 SizedBox( height: 20,),
                 Row(
                   children: [
                     Text(
                         style: TextStyle(
                           fontWeight: FontWeight(1000)
                         ),
                         "Phone: "),
                     SizedBox( width: 10,),
                     Text(company.phone),
                   ],
                 ),
                 SizedBox( height: 20,),
                 Row(
                   children: [
                     Text(
                         style: TextStyle(
                             fontWeight: FontWeight(1000)
                         ),
                         "Email: "),
                     SizedBox( width: 10,),
                     Text(company.email),
                   ],
                 ),
                 SizedBox( height: 20,),
                 Row(
                   children: [
                     Text(
                         style: TextStyle(
                             fontWeight: FontWeight(1000)
                         ),
                         "WebPage: "),
                     SizedBox( width: 10,),
                     Text(company.webPage),
                   ],
                 ),
               ],
             )
         )
     );
  }


}