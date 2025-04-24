import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_demo/core/core.dart';

class CustomNetWorkWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final String? errorImage;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final BoxBorder? boxBorder;
  final bool hasShadow;
  final BoxFit? boxFit;
  final Alignment? alignment;

  final String initials;
  final Color? backgroundColor;
  final double? fontSize;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const CustomNetWorkWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.errorImage,
    this.shape,
    this.borderRadius,
    this.boxBorder,
    this.hasShadow = false,
    this.boxFit,
    this.alignment,
    this.backgroundColor,
    this.memCacheWidth,
    this.memCacheHeight,
  }) : initials = '',
       fontSize = null;

  const CustomNetWorkWidget.withInitials({
    super.key,
    required this.url,
    required this.initials,
    this.backgroundColor,
    this.height,
    this.width,
    this.shape,
    this.borderRadius,
    this.boxBorder,
    this.hasShadow = false,
    this.boxFit,
    this.alignment,
    this.fontSize,
    this.memCacheWidth,
    this.memCacheHeight,
  }) : errorImage = null;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty || !url.startsWith('http')) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: boxBorder,
          borderRadius:
              shape == BoxShape.circle
                  ? null
                  : (borderRadius ?? const BorderRadius.all(AppRadius.medium)),
          shape: shape ?? BoxShape.rectangle,
          boxShadow:
              hasShadow
                  ? [
                    BoxShadow(
                      color: context.colorScheme.onSecondary,
                      blurRadius: 2,
                      offset: const Offset(5, 5),
                      spreadRadius: -2,
                    ),
                  ]
                  : null,
          color:
              backgroundColor ??
              context.colorScheme.onSurface.withValues(alpha: .2),
        ),
        alignment: Alignment.center,
        child:
            initials.isEmpty
                ? const Icon(Icons.broken_image_rounded)
                : Text(
                  initials,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: context.colorScheme.surface,
                  ),
                ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        alignment: alignment ?? Alignment.center,
        width: width,
        height: height,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        imageBuilder:
            (ctx, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit ?? BoxFit.fill,
                ),
                border: boxBorder,
                borderRadius:
                    shape == BoxShape.circle
                        ? null
                        : (borderRadius ??
                            const BorderRadius.all(AppRadius.medium)),
                shape: shape ?? BoxShape.rectangle,
                boxShadow:
                    hasShadow
                        ? [
                          BoxShadow(
                            color: context.colorScheme.onTertiary,
                            blurRadius: 5,
                            offset: const Offset(5, 5),
                            spreadRadius: -2,
                          ),
                          BoxShadow(
                            color: context.colorScheme.onTertiary,
                            blurRadius: 5,
                            offset: -const Offset(5, 5),
                            spreadRadius: -2,
                          ),
                        ]
                        : null,
              ),
            ),
        placeholder: (context, url) {
          return Container(
            padding: const EdgeInsets.all(AppPadding.small),
            decoration: BoxDecoration(
              color: context.colorScheme.outlineVariant,
              border: boxBorder,
              borderRadius: borderRadius,
              shape: shape ?? BoxShape.rectangle,
            ),
            // child: const Center(
            //   child: CupertinoActivityIndicator(),
            // ),
          );
        },
        errorWidget: (context, url, error) => _errorWidget(context),
      );
    }
  }

  Container _errorWidget(BuildContext context) {
    return Container(
      width: width ?? context.width * 0.14,
      height: height ?? context.width * 0.14,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: borderRadius,
        shape: shape ?? BoxShape.circle,
        // decorationImage: const DecorationImage(
        //   image: AssetImage(
        //     AssetList.logoPng,

        //   ),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: const Icon(Icons.broken_image_rounded),
    );
  }
}
