import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:general/permissions/gps_permission.dart';
import 'package:general/models/user.dart';
import 'package:general/services/dio_http.dart';
import 'package:general/screens/user_card/new_user.dart';
import 'package:general/screens/user_card/users_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final DioHttp _userService = DioHttp();
  final List<User> _registeredUsers = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.requestPermission();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userService.fetchUser();
      setState(() {
        _registeredUsers.addAll(users);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _onTapAdd() {
    getLocation();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewUser(onAddUser: _addUser),
    );
  }

  void _addUser(User user) async {
    try {
      bool isAdded = await _userService.addUser(user);
      if (isAdded) {
        setState(() {
          _registeredUsers.add(user);
        });
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(AppLocalizations.of(context)!.user_added_successfully)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
      );
    }
  }

  void _removeUser(User user) {
    final userIndex = _registeredUsers.indexOf(user);
    setState(() {
      _registeredUsers.remove(user);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text(AppLocalizations.of(context)!.user_deleted),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.undo,
        onPressed: () {
          setState(() {
            _registeredUsers.insert(userIndex, user);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _hasError
                    ?  Center(child: Text(AppLocalizations.of(context)!.failed_to_load_user_data))
                    : UsersList(
                        users: _registeredUsers,
                        onRemoveUser: _removeUser,
                      ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              onPressed: _onTapAdd,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
