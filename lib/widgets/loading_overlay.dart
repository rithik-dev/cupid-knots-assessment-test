import 'package:cupid_knot_assessment_test/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void startLoading(BuildContext context, String screenId) {
  try {
    LoadingController.of(context, listen: false).startLoading(screenId);
  } catch (_) {}
}

void stopLoading(BuildContext context, {bool notify = true}) {
  try {
    LoadingController.of(context, listen: false).stopLoading(notify: notify);
  } catch (_) {}
}

class LoadingOverlay extends StatefulWidget {
  static const id = 'LoadingOverlay';

  final String? screenId;
  final Color? loaderColor;
  final Widget child;

  const LoadingOverlay({
    this.screenId,
    this.loaderColor,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  void initState() {
    stopLoading(context, notify: false);
    super.initState();
  }

  @override
  void dispose() {
    stopLoading(context, notify: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingController>(
      builder: (context, loadingCon, _) {
        final isLoading = loadingCon.isLoading(widget.screenId!);

        return WillPopScope(
          onWillPop: () async => !isLoading,
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.child,
              if (isLoading) ...[
                ModalBarrier(
                  dismissible: false,
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.1),
                ),
                Positioned(
                  child: LinearProgressIndicator(color: widget.loaderColor),
                  top: 0,
                  left: 0,
                  right: 0,
                )
                // else
                //   CustomLoader(color: widget.loaderColor),
              ],
            ],
          ),
        );
      },
    );
  }
}
