import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_shopper/business/chats.dart';
import 'package:window_shopper/business/rating.dart';
import 'package:window_shopper/models/reviews.dart';
import 'package:window_shopper/notifier/biz_notifier.dart';
import 'storage_service.dart';


class BizDetail extends StatefulWidget {
  const BizDetail({Key? key}) : super(key: key);

  @override
  State<BizDetail> createState() => _BizDetailState();
}

class _BizDetailState extends State<BizDetail> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
        .instance.collection('businesses');
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(
        context, listen: false);
    var listingId = businessNotifier.currentBusiness.bizId.toString();
    var businessName = businessNotifier.currentBusiness.bizName.toString();
    final _auth = FirebaseAuth.instance;
    var reviewDocId;
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    final Storage storage = Storage();

    //form key for validation
    final _formKey = GlobalKey<FormState>();
    var ratings;
    var name;

    final TextEditingController review = TextEditingController();

    void initState() {
      setState(() {
        super.initState();
        businesses.where('users', isEqualTo: {currentUser})
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            reviewDocId = querySnapshot.docs.single.id;
          } else {
            businesses.add({'business owner': {listingId}
            }).then((value) =>
            {
              reviewDocId = value,
            });
          }
        }).catchError((e) {});
      });
    }

    void callChatScreen(userId, userName) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              ChatScreen(
                chatUsersenderId: userId,
                chatUserName: userName,)
      ));
    }

    /*Future<Widget> _getImage(BuildContext context, String imageName) async {
      late Image image;
      await FirebaseStorageService.loadImage(context, imageName).then((value) {
        image = Image.network(value.toString(), fit: BoxFit.scaleDown);
      });
      return image;
    }*/

    submitReview () async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      User? user = _auth.currentUser;
      name = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get()
          .then((value) {
        return value.data()!['userName'];
      });

      ReviewModel reviewModel = ReviewModel();

      reviewModel.reviewId = user!.uid;
      reviewModel.rating = ratings;
      reviewModel.username = name;
      reviewModel.review = review.text;
      reviewModel.listing = FirebaseFirestore.instance
          .collection('businesses')
          .doc(currentUser)
          .get()
          .then((value) {
        return value.data()!['userName'];
      }).toString();

      await firebaseFirestore
      .collection('reviews')
      .doc(user.uid)
      .collection("reviewDetails")
      .doc(reviewDocId)
      .set(reviewModel.toMap());

    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(businessNotifier.currentBusiness.bizName.toString(),
            style: TextStyle(fontSize: 36,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image.network(businessNotifier.currentBusiness.logo),
                /*FutureBuilder(
                  future: _getImage(context, ""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: snapshot.data as Widget,
                      );
                    }

                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),*/
                FutureBuilder(
                  future: storage.downloadURL('image.jpg'),
                  builder: (BuildContext context,
                      AsyncSnapshot<String> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                        height: 250,
                        child: Image.network(snapshot.data!, fit: BoxFit.contain,)
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),

                Text("Phone: ${businessNotifier.currentBusiness.phoneNumber
                    .toString()}",
                    style: const TextStyle(fontSize: 18, color: Colors.black)),
                const SizedBox(height: 10),

                Text("Opening Hours: ${businessNotifier.currentBusiness.firstBizDay
                    .toString()} - ${businessNotifier.currentBusiness.lastBizDay
                    .toString()} ${businessNotifier.currentBusiness.openingHrs
                    .toString()}",
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                const SizedBox(height: 10),

                Text("Closing Hours: ${businessNotifier.currentBusiness.firstBizDay
                    .toString()} - ${businessNotifier.currentBusiness.lastBizDay
                    .toString()} ${businessNotifier.currentBusiness.closingHrs
                    .toString()}",
                    style: const TextStyle(fontSize: 18, color: Colors.black)),
                const SizedBox(height: 10),

                const Text("Business Overview",
                    style: TextStyle(fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                Text(businessNotifier.currentBusiness.bizDescription.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.black)),
                const SizedBox(height: 10),

                const Text("Gallery",
                    style: TextStyle(fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                const Text("Reviews",
                    style: TextStyle(fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                const Text("Submit a review",
                    style: TextStyle(fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                const Text("Rate the listing: ", style: const TextStyle(fontSize: 18, color: Colors.black)),
                const SizedBox(height: 10),

                Rating((rating) {
                    ratings = rating.toString();
                }),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: review,
                    onSaved: (value) {
                      review.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: 'Enter your review',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(25),
                color: Colors.redAccent,
                child: MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  minWidth: 200,
                  onPressed: () {
                    submitReview();
                  },
                  child: const Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
              ),

              IconButton(
                  onPressed: () {
                    callChatScreen(listingId, businessName);
                  },
                  icon: const Icon(Icons.chat_bubble))

              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }


}*/
