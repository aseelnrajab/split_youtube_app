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
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 16.sp),
      ),
    );
  }

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
                            _buildControlButton(
                                icon: Icons.cameraswitch,
                                onPressed: onSwitchCamera),
                            SizedBox(width: 15.w),
                            _buildControlButton(
                                icon: Icons.videocam_off,
                                onPressed: onHideCamera),
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
                  style: TextStyle(fontSize: 12.sp),
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
