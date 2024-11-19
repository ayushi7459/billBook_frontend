import 'package:flutter/material.dart';
import 'package:general/permissions/gps_permission.dart';
import 'package:general/models/user.dart';
import 'package:general/screens/user_card/edit_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserItem extends StatefulWidget {
  UserItem(this.user, {super.key});

  User user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  void _onTapCard(BuildContext context) {
    getLocation();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Edituser(
        user: widget.user,
        onEdit: (updatedUser) {
          setState(() {
            widget.user = updatedUser;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTapCard(context);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.user.firstName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              Text(
                '${AppLocalizations.of(context)!.email}: ${widget.user.email}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '${AppLocalizations.of(context)!.mobile}: ${widget.user.phone}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '${AppLocalizations.of(context)!.gender}: ${widget.user.gender}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
