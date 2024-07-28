import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vizmo_app/utils/app_colors.dart';
import 'package:vizmo_app/utils/app_constants.dart';

enum EventStatus {
  confirmed,
  pending,
  cancelled,
}

class EventTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final EventStatus isConfirmed;
  final bool isGroupEvent;
  final Function()? onTap;

  const EventTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isConfirmed,
    required this.isGroupEvent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.padding10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(
                  isGroupEvent ? Icons.event : Icons.supervised_user_circle,
                  color: AppColors.deepPurple,
                  size: AppConstants.fontSize28,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: AppConstants.fontSize14,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppConstants.fontSize14,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: AppConstants.fontSize16,
                          color: Colors.blueGrey,
                        ),
                        const Gap(4),
                        Text(
                          time,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: AppConstants.fontSize14,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(16),
              CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: Icon(
                  size: AppConstants.fontSize26,
                  isConfirmed == EventStatus.cancelled
                      ? Icons.cancel
                      : isConfirmed == EventStatus.confirmed
                          ? Icons.check_circle
                          : isConfirmed == EventStatus.pending
                              ? Icons.pending
                              : Icons.check_circle_outline,
                  color: isConfirmed == EventStatus.cancelled
                      ? AppColors.redColor
                      : isConfirmed == EventStatus.confirmed
                          ? AppColors.greenColor
                          : isConfirmed == EventStatus.pending
                              ? AppColors.greyColor
                              : AppColors.greyColor,
                ),
              ),
              const Gap(8)
            ],
          ),
        ),
      ),
    );
  }
}
