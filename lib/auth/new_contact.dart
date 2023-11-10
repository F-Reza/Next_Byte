
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class NewContact extends StatefulWidget {
  static const String routeName = '/new';

  const NewContact({Key? key}) : super(key: key);

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  String? _dob;
  String? _genderGroupValue;
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;

  final formKey = GlobalKey <FormState>();


  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    addressController.dispose();
    websiteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _saveContactInfo,
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              Card(
                color: Colors.white54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15,),
                    Card(
                      elevation: 10,
                      child: _imagePath == null ?
                      Image.asset('images/person.png',height: 160, width: 150,fit: BoxFit.cover,) :
                      Image.file(File(_imagePath!),height: 160, width: 150,fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                            onPressed: (){
                              _imageSource = ImageSource.camera;
                              _getImage();
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera')),
                        TextButton.icon(
                            onPressed: (){
                              _imageSource = ImageSource.gallery;
                              _getImage();
                            },
                            icon: const Icon(Icons.photo),
                            label: const Text('Gallery')),
                      ],
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty!';
                  }
                  if (value.length > 26) {
                    return 'name must be in 26 character';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty!';
                  }
                  if (value.length > 14) {
                    return 'number must be in 14 character';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: websiteController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Website',
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 10,),
              Card(
                color: Colors.white54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: _selectDate,
                        child: const Text('Select Date of Birth: ')),
                    Text(_dob == null ? 'No Date Selected' : _dob!)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Card(
                color: Colors.white54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Select Gender: '),
                    Radio<String>(
                      value: 'Male',
                      groupValue: _genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _genderGroupValue = value;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          _genderGroupValue = value;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  void _saveContactInfo() async {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: nameController.text,
        number: numberController.text,
        email: emailController.text,
        address: addressController.text,
        dob: _dob,
        gender: _genderGroupValue,
        image: _imagePath,
        website: websiteController.text
      );
      //print(contact.toString());
      final status = await Provider.of<ContactProvider>(context, listen: false)
      .insertContact(contact);
      if(status){
        Navigator.pop(context);
      }else{
        
      }
    }
  }


  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker()
        .pickImage(source: _imageSource);
    if(selectedImage!=null){
      setState((){
        _imagePath = selectedImage.path;
      });
    }
  }


}
