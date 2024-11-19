import 'dart:io';
import 'package:flutter/material.dart';
import 'package:general/screens/auth.dart';
import 'package:general/storage/flutter_secure_storage.dart';
import 'package:general/storage/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerPlate extends StatefulWidget {
  const DrawerPlate({super.key});

  @override
  State<DrawerPlate> createState() => _DrawerPlateState();
}

class _DrawerPlateState extends State<DrawerPlate> {
  final _secuerStorage = MySecureStorage();
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> signOut(context) async {
    await _secuerStorage.deleteEmailAndPassword();
    await removeImage();
    await _secuerStorage.deleteLocale();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  Future<void> _loadImage() async {
    final imagePath = await getImagePath();
    if (imagePath != null) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  Future<void> getImage() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        await saveImagePath(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: _selectedImage == null
                      ? null
                      : FileImage(_selectedImage!),
                  child: _selectedImage == null
                      ? Text(AppLocalizations.of(context)!.image)
                      : null,
                ),
                IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(AppLocalizations.of(context)!.home),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/notification');
                },
                leading: const Icon(Icons.notifications),
                title: Text(AppLocalizations.of(context)!.notification),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () => signOut(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
