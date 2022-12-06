import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/screens/main_screens/home_screen.dart';
import 'package:seller_app/widgets/custom_text_field.dart';
import 'package:seller_app/widgets/error_dialog.dart';
import 'package:seller_app/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_storage;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  Position? position;
  List<Placemark>? placeMarks;
  String sellerImageUrl = '';
  String completeAddress = '';

  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    position = newPosition;
    placeMarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark pMark = placeMarks![0];
    completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    locationController.text = completeAddress;
  }

  Future<void> formValidation() async{
    if(imageXFile == null) {
      showDialog(context: context, builder: (c) {
        return ErrorDialog(
          message: 'Please select an image',
        );
      });
    } else {
      if(passwordController.text == confirmPasswordController.text) {
        if(confirmPasswordController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.isNotEmpty && locationController.text.isNotEmpty) {
          showDialog(context: context, builder: (c) {
            return LoadingDialog(
              message: 'Registration',
            );
          });

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          f_storage.Reference reference = f_storage.FirebaseStorage.instance.ref().child('sellers').child(fileName);
          
          f_storage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));

          f_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url)  {
            sellerImageUrl = url;
            authenticateSellerAndSignUp();
          });

          // upload the image
        } else {
          showDialog(context: context, builder: (c) {
            return ErrorDialog(
              message: 'Please fill all fields.',
            );
          });
        }

      } else {
        showDialog(context: context, builder: (c) {
          return ErrorDialog(
            message: 'Password Mismatch',
          );
        });
      }
    }
  }

  void authenticateSellerAndSignUp() async{
    User? currentUser;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((auth) {
      currentUser = auth.user;
      if(currentUser != null) {
        saveDataToFireStore(currentUser!).then((value) {
          Navigator.pop(context);
          Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());

          Navigator.pushReplacement(context, newRoute);
        });
      }
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(context: context, builder: (c) {
        return ErrorDialog(
          message: error.message.toString(),
        );
      });
    });
  }

  Future saveDataToFireStore(User currentUser) async{
    FirebaseFirestore.instance.collection('sellers').doc(currentUser.uid).set({
      "sellerUID" : currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName" : nameController.text.trim(),
      "phone" : phoneController.text.trim(),
      "address" : completeAddress,
      "status" : 'approved',
      "earnings" : 0.0,
      "lat" : position!.latitude,
      "lng" : position!.longitude,
      "sellerAvatarUrl" : sellerImageUrl,
    });

    SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("uid", currentUser.uid);
    await sharedPreferences.setString("photoUrl", sellerImageUrl);
    await sharedPreferences.setString("name", nameController.text.trim());
    await sharedPreferences.setString("email", emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () { _getImage(); },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage:
                  imageXFile == null ? null : FileImage(File(imageXFile!.path)),
              child: imageXFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: 'Name',
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: 'Email',
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: 'Password',
                  isObscure: true,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  isObscure: true,
                ),
                CustomTextField(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: 'Phone',
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.my_location,
                  controller: locationController,
                  hintText: 'Cafe/Restaurant Address',
                  isObscure: false,
                  enabled: false,
                ),
                Container(
                  width: 400,
                  height: 40,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () { getCurrentLocation(); },
                    icon: const Icon(Icons.my_location),
                    label: const Text(
                      'Get My Location',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async{
              await formValidation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)
            ),
            child: const Text(
              'SignUp',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
