import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utility/asset_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetPaths.backgroundSvg,
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,

          ),

          Center(child: SvgPicture.asset(
            AssetPaths.appLogoSvg,
            width: 140,
          ),
          ),


        ],
      ),
    );
  }
}
