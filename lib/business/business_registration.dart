import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:window_shopper/business/analytics_screen.dart';
import 'package:window_shopper/models/business_model.dart';

class BusinessRegistration extends StatefulWidget {
  const BusinessRegistration({Key? key}) : super(key: key);

  @override
  _BusinessRegistrationState createState() => _BusinessRegistrationState();
}

class _BusinessRegistrationState extends State<BusinessRegistration> {
  final _auth = FirebaseAuth.instance;

  //form key for validation
  final _formKey = GlobalKey<FormState>();

  final List<String> categories = ['Automotive', 'Business Support', 'Business Supplies', 'Computers', 'Construction', 'Contractors', 'Education', 'Entertainment', 'Food/Dining',
  'Health/Medicine', 'Home/Garden', 'Legal/Financial', 'Manufacturing', 'Wholesale', 'Distribution', 'Merchant(Retail)', 'Miscellaneous', 'Personal Care', 'Real Estate',
  'Travel', 'Transportation'];

  final List<String> counties = ['Momabasa', 'Kwale', 'Kilifi', 'Tana River', 'Lamu', 'Taita Taveta', 'Garissa',
  'Wajir', 'Mandera', 'Marsabit', 'Isiolo', 'Meru', 'Tharaka Nithi', 'Embu', 'Kitui', 'Machakos', 'Makueni', 'Nyandarua',
  'Nyeri', 'Kirinyaga', 'Murang\'a', 'Kiambu', 'Turkana', 'West Pokot', 'Samburu', 'Trans Nzoia', 'Uasin Gishu',
  'Elgeyo Marakwet', 'Nandi', 'Baringo', 'Laikipia', 'Nakuru', 'Narok', 'Kajiado', 'Kericho', 'Bomet', 'Kakamega',
  'Vihiga', 'Bungoma', 'Busia', 'Siaya', 'Kisumu', 'Homa Bay', 'Migori', 'Kisii', 'Nyamira', 'Nairobi City'];

  //Editing controller
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController bizNameController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController bizCategoryController = TextEditingController();
  final TextEditingController bizTypeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController openingHoursController = TextEditingController();
  final TextEditingController closingHoursController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController physicalAddressController = TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController constituencyController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instaController = TextEditingController();
  final TextEditingController pinterestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //fullname field
    final fullnameField = TextFormField(
      autofocus: false,
      controller: fullNameController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.]$');

        if(value!.isEmpty) {
          return ('Please enter your full name');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid name');
        }
        return null;
      },
      onSaved: (value) {
        fullNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Full Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //KRA Pin field
    final kraPinField = TextFormField(
      autofocus: false,
      controller: pinController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z0-9]$');

        if(value!.isEmpty) {
          return ('Please enter your KRA pin');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid pin');
        }
        return null;
      },
      onSaved: (value) {
        pinController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.text_fields),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'KRA Pin Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //business name field
    final businessNameField = TextFormField(
      autofocus: false,
      controller: bizNameController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return ('Please enter your business name');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid name');
        }
        return null;
      },
      onSaved: (value) {
        bizNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.business),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Business Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //registration number
    final regNoField = TextFormField(
      autofocus: false,
      controller: regNoController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z0-9]$');

        if(value!.isEmpty) {
          return ('Please enter your business registration number');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid number');
        }
        return null;
      },
      onSaved: (value) {
        regNoController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.text_fields),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Business Registration Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //business category type
    final bizCategoryField = DropdownButtonFormField<String>(
      autofocus: false,
      items: categories.map((user){
        return DropdownMenuItem(
          value: user,
          child: Text(user),
        );

      }).toList(),
      onChanged: (value) => setState(() => bizCategoryController.text = value!),

      //textInputAction: InputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.category),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Business Category',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //business type field
    final bizTypeField = TextFormField(
      autofocus: false,
      controller: bizTypeController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return ('Please enter your business type');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid type');
        }
        return null;
      },
      onSaved: (value) {
        bizTypeController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.category),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Business Type',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty) {
          return (value = null);
        }
        //regex expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ('Please enter a valid email');
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

        final phoneNoField = TextFormField(
      autofocus: false,
      controller: _phoneNoController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if(value!.isEmpty) {
          return ('Please enter your business phone number');
        }
        //regex expression for phone number validation
        if(!RegExp('^([0|+[0-9]{1,5})?([0-9]{10})').hasMatch(value)) {
          return ('Please enter a valid phone number');
        }
        return null;
      },
      onSaved: (value) {
        _phoneNoController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //opening hours field
    final openingField = TextFormField(
      autofocus: false,
      controller: openingHoursController,
      validator: (value){
        //RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return ('Please enter your opening time');
        }
        return null;
      },
      onSaved: (value) {
        openingHoursController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.access_time),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Opening Hours',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //closing hours field
    final closingField = TextFormField(
      autofocus: false,
      controller: closingHoursController,
      validator: (value){
        //RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return ('Please enter your opening time');
        }
        return null;
      },
      onSaved: (value) {
        closingHoursController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.access_time),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Closing Hours',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //website link field
    final websiteField = TextFormField(
      autofocus: false,
      controller: websiteController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');

        if(value!.isEmpty) {
          return (value = null);
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid link');
        }
      },
      onSaved: (value) {
        websiteController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.link),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Website Link',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //physical address field
    final addressField = TextFormField(
      autofocus: false,
      controller: physicalAddressController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z0-9]$');

        if(value!.isEmpty) {
          return ('Please enter your physical address');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid address');
        }
        return null;
      },
      onSaved: (value) {
        physicalAddressController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Physical Address',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //county field
    final countyField = DropdownButtonFormField<String>(
      autofocus: false,
      items: counties.map((user){
        return DropdownMenuItem(
          value: user,
          child: Text(user),
        );

      }).toList(),
      onChanged: (value) => setState(() => countyController.text = value!),

      //textInputAction: InputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.map),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'County',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //constituency field
    final constituencyField = TextFormField(
      autofocus: false,
      controller: constituencyController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return ('Please enter your constituency');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid constituency');
        }
        return null;
      },
      onSaved: (value) {
        constituencyController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.map),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Constituency',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    // town field
    final townField = TextFormField(
      autofocus: false,
      controller: townController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return ('Please enter your town');
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid town');
        }
        return null;
      },
      onSaved: (value) {
        townController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Town',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //facebook link field
    final facebookField = TextFormField(
      autofocus: false,
      controller: facebookController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return (value = null);
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid link');
        }
        return null;
      },
      onSaved: (value) {
        facebookController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.link),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Facebook Link',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //twitter field
    final twitterField = TextFormField(
      autofocus: false,
      controller: twitterController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return (value = null);
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid link');
        }
        return null;
      },
      onSaved: (value) {
        twitterController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.link),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Twitter Link',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //instagram field
    final instaField = TextFormField(
      autofocus: false,
      controller: instaController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return (value = null);
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid link');
        }
        return null;
      },
      onSaved: (value) {
        instaController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.link),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Instagram link',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    //pinterest field
    final pinterestField = TextFormField(
      autofocus: false,
      controller: pinterestController,
      validator: (value){
        RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

        if(value!.isEmpty) {
          return (value = null);
        }
        if(!regex.hasMatch(value)){
          return ('Enter a valid link');
        }
        return null;
      },
      onSaved: (value) {
        pinterestController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.link),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Pinterest link',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(25),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          postDetailsToFirestore();
        },
        child: const Text(
            'Register',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Business Registration',style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                          'Background Information',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,)),
                      const SizedBox(height: 2),

                      const Divider(
                        color: Colors.redAccent,
                        height: 35,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),

                      fullnameField,
                      const SizedBox(height: 10),

                      kraPinField,
                      const SizedBox(height: 10),

                      businessNameField,
                      const SizedBox(height: 10),

                      regNoField,
                      const SizedBox(height: 10),

                      bizCategoryField,
                      const SizedBox(height: 10),

                      bizTypeField,
                      const SizedBox(height: 20),

                      const Text(
                          'Contact Information',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,)),
                      const SizedBox(height: 2),

                      const Divider(
                        color: Colors.redAccent,
                        height: 35,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),


                      emailField,
                      const SizedBox(height: 10),

                      phoneNoField,
                      const SizedBox(height: 10),

                      openingField,
                      const SizedBox(height: 10),

                      closingField,
                      const SizedBox(height: 10),

                      websiteField,
                      const SizedBox(height: 20),

                      const Text(
                          'Location',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,)),
                      const SizedBox(height: 2),

                      const Divider(
                        color: Colors.redAccent,
                        height: 35,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),

                      addressField,
                      const SizedBox(height: 10),

                      countyField,
                      const SizedBox(height: 10),

                      constituencyField,
                      const SizedBox(height: 10),

                      townField,
                      const SizedBox(height: 10),

                      const Text(
                          'Social Media Information',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,)),
                      const SizedBox(height: 2),

                      const Divider(
                        color: Colors.redAccent,
                        height: 35,
                        thickness: 3,
                        indent: 5,
                        endIndent: 5,
                      ),

                      facebookField,
                      const SizedBox(height: 10),

                      twitterField,
                      const SizedBox(height: 10),

                      instaField,
                      const SizedBox(height: 10),

                      pinterestField,
                      const SizedBox(height: 10),

                      registerButton,
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  //posting data to firebase function
  postDetailsToFirestore() async {
    //calling Firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //calling BusinessModel
    User? business = _auth.currentUser;
    BusinessModel businessModel = BusinessModel();

    //writing the values
    businessModel.bizId = business!.uid;
    businessModel.fullName = fullNameController.text;
    businessModel.kraPin = pinController.text;
    businessModel.bizName = bizNameController.text;
    businessModel.regNo = regNoController.text;
    businessModel.bizCategory = bizCategoryController.text;
    businessModel.bizType = bizTypeController.text;
    businessModel.email = emailController.text;
    businessModel.phoneNumber = _phoneNoController.text;
    businessModel.openingHrs = openingHoursController.text;
    businessModel.closingHrs = closingHoursController.text;
    businessModel.website = websiteController.text;
    businessModel.physicalAddress = physicalAddressController.text;
    businessModel.county = countyController.text;
    businessModel.constituency = constituencyController.text;
    businessModel.town = townController.text;
    businessModel.facebook = facebookController.text;
    businessModel.twitter = twitterController.text;
    businessModel.insta = instaController.text;
    businessModel.pinterest = pinterestController.text;


    //sending the values
    await firebaseFirestore
        .collection("businesses")
        .doc(business.uid)
        .set(businessModel.toMap());
    Fluttertoast.showToast(msg: 'Listing created successfully');

    Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsScreen()));
  }
}
