import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class GreetingHeader extends StatelessWidget {
  final String name;
  final int notificationCount;
  final String avatarUrl;

  const GreetingHeader({
    super.key,
    required this.name,
    this.notificationCount = 0,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildGreeting(), buildActions()],
    );
  }

  Widget buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $name 👋',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Find your best product',
          style: TextStyle(color: AppColors.textGrey, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildActions() {
    return Row(
      children: [
        buildNotificationBell(),
        const SizedBox(width: 12),
        buildAvatar(),
      ],
    );
  }

  Widget buildNotificationBell() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.notifications_outlined,
          size: 28,
          color: AppColors.textDark,
        ),
        if (notificationCount > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$notificationCount',
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildAvatar() {
    return CircleAvatar(radius: 20, backgroundImage: NetworkImage(avatarUrl));
  }
}
