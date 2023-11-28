import 'package:app/application/app_constants.dart';
import 'package:app/application/di.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:app/presentation/storeDetails/viewmodel/storedetails_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.storeDetails).tr(),
        elevation: AppSizeManager.s0,
        iconTheme: IconThemeData(color: ColorManager.white),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outPutStateRender,
        builder: (context, snapshot) {
          return snapshot.data?.getContentScreen(
                context: context,
                currentContentScreen: StoreDetailsBody(
                  streamGetData: _viewModel.storedetailsOutput,
                ),
                retryFunction: () => _viewModel.start(),
              ) ??
              StoreDetailsBody(
                streamGetData: _viewModel.storedetailsOutput,
              );
        },
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.end();
    super.dispose();
  }
}

class StoreDetailsBody extends StatelessWidget {
  final Stream<StoreDetailsObject> streamGetData;
  const StoreDetailsBody({
    super.key,
    required this.streamGetData,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StoreDetailsObject>(
        stream: streamGetData,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image
                ImageNetworDetails(
                  imagePath: snapshot.data?.image,
                ),
                //details title
                const SectionTitle(title: AppStrings.details),
                // details body
                SectionMessageBody(message: snapshot.data?.details),
                // services title
                const SectionTitle(title: AppStrings.services),
                // services body
                SectionMessageBody(message: snapshot.data?.services),
                // aboutStore title
                const SectionTitle(title: AppStrings.about),
                // aboutStore body
                SectionMessageBody(message: snapshot.data?.about),
              ],
            ),
          );
        });
  }
}

class ImageNetworDetails extends StatelessWidget {
  final String? imagePath;
  const ImageNetworDetails({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return imagePath == null ? Container() : Image.network(imagePath!);
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ).tr(),
    );
  }
}

class SectionMessageBody extends StatelessWidget {
  final String? message;
  const SectionMessageBody({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPaddingManager.p8),
      child: Text(
        message == null ? AppConstant.emptyString : message!,
        style: Theme.of(context).textTheme.headlineSmall,
        maxLines: 5,
        overflow: TextOverflow.clip,
      ).tr(),
    );
  }
}
