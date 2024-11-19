import 'package:flutter/material.dart';
import 'package:general/models/user.dart';
import 'package:general/services/dio_http.dart';
import 'user_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UsersList extends StatefulWidget {
  const UsersList({super.key, required this.users, required this.onRemoveUser});
  final List<User> users;
  final void Function(User) onRemoveUser;

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final DioHttp _userService = DioHttp();
  late List<User> _users;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _users = widget.users;
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _userService.fetchUser();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _removeUser(User user) {
    final userIndex = _users.indexOf(user);
    setState(() {
      _users.remove(user);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text(AppLocalizations.of(context)!.user_deleted),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.undo,
        onPressed: () {
          setState(() {
            _users.insert(userIndex, user);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return  Center(child: Text(AppLocalizations.of(context)!.failed_to_load_user_data));
    }

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) => _removeUser(_users[index]),
        key: ValueKey(_users[index]),
        child: UserItem(_users[index]),
      ),
    );
  }
}
