import 'package:flutter/material.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return Obx(() {
    //   final isNetworkImage = controller.user.value.profilePicture.isNotEmpty;
    //   final image = isNetworkImage ? controller.user.value.profilePicture : TImages.user;
    //   return ListTile(
    //     leading: TCircularImage(padding: 0, image: image, width: 50, height: 50, isNetworkImage: isNetworkImage),
    //     title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
    //     subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
    //     trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white)),
    //   );
    // });
  }
}
