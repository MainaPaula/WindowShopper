import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/listing.dart';
import '../notifier/biz_notifier.dart';
import 'biz_registration.dart';
import 'listing_details.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  _ListingScreenState createState() => _ListingScreenState();
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

class _ListingScreenState extends State<ListingScreen> {
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
        backgroundColor: Colors.transparent,
        title: const Text('Listings',style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: /*SizedBox(
        child: ListView.separated(
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
          itemCount: businessNotifier.businessList.length),
      ),*/

           Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.redAccent,
                      child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BizRegistration()));
                        },
                        child: const Text(
                            'Create Listing',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),

          ),
    );
  }
}
