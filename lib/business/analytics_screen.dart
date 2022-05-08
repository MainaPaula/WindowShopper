import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_shopper/business/listing_details.dart';
import 'package:window_shopper/business/search.dart';
import '../models/listing.dart';
import '../notifier/biz_notifier.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}
void getBusinesses(BusinessNotifier businessNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('listings').get();
  List<Businesses> _businessList = [];

  snapshot.docs.forEach((element) {
    Businesses business = Businesses.fromMap(element.data());
    _businessList.add(business);
  });

  businessNotifier.businessList = _businessList;
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(context, listen: false);
    getBusinesses(businessNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const Text('Analytics',style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: (){
                showSearch(context: context, delegate: InfoSearch());
              },
              icon: Icon(Icons.search),
              color: Colors.redAccent,
            ),

          ],/*
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),*/
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(businessNotifier.businessList[index].bizName.toString()),
                subtitle: Text(businessNotifier.businessList[index].email.toString()),
                onTap: (){
                  businessNotifier.currentBusiness = businessNotifier.businessList[index];
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BizDetail()));
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.black,
              );
            },
            itemCount: businessNotifier.businessList.length)
    );
  }
}
