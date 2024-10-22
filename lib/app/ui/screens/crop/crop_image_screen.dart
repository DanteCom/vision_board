import 'package:vision_board/resources/resources.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'dart:typed_data';

class CropImageScreen extends StatefulWidget {
  final Uint8List image;
  const CropImageScreen({super.key, required this.image});

  @override
  State<CropImageScreen> createState() => _CropImageState();
}

class _CropImageState extends State<CropImageScreen> {
  final _scrollController = ScrollController();
  final _cropController = CropController();
  bool isCropped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ).copyWith(bottom: 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Adding photo', style: AppTextStyles.s20w400ws),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      Container(
                        width: double.infinity,
                        height: SizerUtil.height / 2 - 50,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Crop(
                          controller: _cropController,
                          initialSize: 1,
                          fixArea: true,
                          interactive: true,
                          initialAreaBuilder: (rect) => Rect.fromLTRB(
                              rect.left, rect.top, rect.right, rect.bottom),
                          cornerDotBuilder: (size, edgeAlignment) =>
                              const SizedBox.shrink(),
                          image: widget.image,
                          progressIndicator:
                              const CircularProgressIndicator.adaptive(),
                          onCropped: (image) {
                            isCropped = false;
                            setState(() {});
                            Navigator.pop(context, image);
                          },
                        ),
                      ),
                      const Gap(16),
                      Text(
                        'You can stretch the picture with your fingers to the\ndesired size',
                        style: AppTextStyles.s14w400ws,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    right: 77,
                    left: 77,
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: AppColors.main,
                      disabledColor: AppColors.mainLight,
                      borderRadius: BorderRadius.circular(100),
                      onPressed: isCropped
                          ? null
                          : () {
                              isCropped = true;
                              _cropController.crop();
                              setState(() {});
                            },
                      child: isCropped
                          ? const CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.white,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue'.toUpperCase(),
                                  style: AppTextStyles.s16w500ws,
                                ),
                                const Gap(8),
                                SvgPicture.asset(Vectors.arrowRight),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
