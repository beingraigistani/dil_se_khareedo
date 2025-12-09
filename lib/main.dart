import 'package:dil_se_khareedo/firebase_options.dart';
import 'package:dil_se_khareedo/presentation/screens/splash_screen.dart';
import 'package:dil_se_khareedo/presentation/state/authentication_provider.dart';
import 'package:dil_se_khareedo/presentation/state/category_provider.dart';
import 'package:dil_se_khareedo/presentation/state/user_provider.dart';
import 'package:dil_se_khareedo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/state/product_provider.dart';
import 'presentation/state/cart_provider.dart';
import 'core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),



      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter E-Commerce',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
