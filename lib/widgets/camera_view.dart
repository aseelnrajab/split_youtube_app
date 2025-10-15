import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:split_youtube_app/l10n/app_localizations.dart';

class CameraView extends StatelessWidget {
  final bool isVisible;
  final bool isInitialized;
  final CameraController? cameraController;
  final VoidCallback onSwitchCamera;
  final Future<void> Function() onInitializeCamera;
  final VoidCallback onHideCamera;

  const CameraView({
    required this.isVisible,
    required this.isInitialized,
    required this.cameraController,
    required this.onSwitchCamera,
    required this.onInitializeCamera,
    required this.onHideCamera,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isVisible
          ? (isInitialized
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          width: cameraController!.value.previewSize!.width,
                          height: cameraController!.value.previewSize!.height,
                          child: CameraPreview(cameraController!),
                        ),
                      ),

                      Positioned(
                        bottom: 16.h,
                        left: 50.w,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FloatingActionButton.small(
                              heroTag: AppLocalizations.of(context)!.switchCam,
                              onPressed: onSwitchCamera,
                              backgroundColor: Colors.black54,
                              child: const Icon(Icons.cameraswitch),
                            ),
                            // SizedBox(width: 5.w),
                            FloatingActionButton.small(
                              heroTag: AppLocalizations.of(context)!.hideCamera,
                              onPressed: onHideCamera,
                              backgroundColor: Colors.black54,
                              child: const Icon(Icons.videocam_off),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator(strokeWidth: 2.w)))
          : Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.videocam, size: 20.sp),
                label: Text(
                  AppLocalizations.of(context)!.enableCamera,
                  style: TextStyle(fontSize: 16.sp),
                ),
                onPressed: () => onInitializeCamera(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
    );
  }
}
