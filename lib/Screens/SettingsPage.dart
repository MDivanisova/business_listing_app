import 'package:business_listing_app/Models/Company.dart';
import 'package:business_listing_app/Widgets/AppBarWidget.dart';
import 'package:business_listing_app/Widgets/CheckBox.dart';
import 'package:business_listing_app/Widgets/InputFieldWidget.dart';
import 'package:flutter/material.dart';
import '../Services/DatabaseHelper.dart';
import 'MyHomePage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage>{
  bool Industry = false;
  bool Fun = false;
  bool Education = false;
  bool Services = false;
  Company c =  Company(id: 0, category: "", name: "", icon: "", address: "", phone: "", webPage: "", lon: 0, lat: 0, email: "");



  bool validate(){
    if(c.name == ''){
        return false;
    }
    if(c.address == ''){
      return false;
    }
    if(c.lat == 0){
      return false;
    }
    if(c.lon == 0){
      return false;
    }
    if(c.email == ''){
      return false;
    }
    if(c.phone == ''){
      return false;
    }
    if(c.webPage == ''){
      return false;
    }
    if(c.icon == ''){
      return false;
    }
    if(!Industry && !Fun && !Services && !Education){
      return false;
    }
    return true;
  }


  Future<void> submit() async{
    if(validate()){
      if(Industry){
        c.category = 'Industry';
      }
      if(Fun){
        c.category = 'Fun';
      }
      if(Services){
        c.category = 'Services';
      }
      if(Education){
        c.category = 'Education';
      }
      await DatabaseHelper.instance.insertCompany(c);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: widget.title), settings: RouteSettings(name: '/')));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some values are missing'))
      );
    }
  }


  @override
  Widget build(BuildContext context){
    double scHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarWidget(widget.title, context),
      body: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: ListView(
            children: [
              inputField( (value){
                setState(() {
                  c.name = value;
                });
              }, "Name",TextInputType.text),
              SizedBox(height: scHeight * 0.02),
              inputField( (value){
                setState(() {
                  c.address = value;
                });
              }, "Address",TextInputType.text),
              SizedBox(height: scHeight * 0.02),
              Row(
                children: [
                  Expanded(child: inputField( (value){
                    setState(() {
                      if(value == ''){
                        c.lat = 0;
                      }else{
                        c.lat = double.parse(value);
                      }
                    });
                  }, "Lat",TextInputType.number),),
                  SizedBox(width: 16),
                  Expanded(child: inputField( (value){
                    setState(() {
                      if(value == ''){
                        c.lon = 0;
                      }else{
                        c.lon = double.parse(value);
                      }
                    });
                    }, "Lon",TextInputType.number),)
                ],
              ),
              SizedBox(height: scHeight * 0.02),
              inputField( (value){
                setState(() {
                  c.email = value;
                });
              }, "Email address",TextInputType.text),
              SizedBox(height: scHeight * 0.02),
              inputField( (value){
                setState(() {
                  c.icon = value;
                });
              }, "Icon link",TextInputType.text),
              SizedBox(height: scHeight*0.02),
              const Text("Category"),
              checkBoxWidget(context,'Industry', Industry, (val) => setState(() => Industry = val!)),
              checkBoxWidget(context, 'Fun', Fun, (val) => setState(() => Fun = val!)),
              checkBoxWidget(context, 'Education', Education, (val) => setState(() => Education = val!)),
              checkBoxWidget(context, 'Services', Services, (val) => setState(() => Services = val!)),
              SizedBox(height: scHeight * 0.02),
              inputField( (value){
                setState(() {
                  c.phone = value;
                });
              }, "Telephone",TextInputType.text),
              SizedBox(height: scHeight * 0.02),
              inputField( (value){
                setState(() {
                  c.webPage = value;
                });
              }, "Web site",TextInputType.text),
              SizedBox(height: scHeight * 0.03),
              ElevatedButton(
                  onPressed: submit,
                  child: const Text("Submit"))
            ],

          ),
      )
    );
  }

}