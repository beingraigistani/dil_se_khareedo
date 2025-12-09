import 'package:flutter/material.dart';

import '../presentation/screens/splash_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/product_detail_screen.dart';
import '../presentation/screens/cart_screen.dart';
import '../presentation/screens/checkout_screen.dart';
import '../presentation/screens/orders_screen.dart';
import '../presentation/screens/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String productDetail = '/product';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String profile = '/profile';

  /// onGenerateRoute implementation that returns the registered screens.
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
      case login:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const LoginScreen(),
        );
      case signup:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const SignupScreen(),
        );
      case home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );
      case productDetail:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const ProductDetailScreen(),
        );
      case cart:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const CartScreen(),
        );
      case checkout:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const CheckoutScreen(),
        );
      case orders:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const OrdersScreen(),
        );
      case profile:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => const ProfileScreen(),
        );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => Scaffold(
            body: Center(child: Text('No route for "${settings.name}"')),
          ),
        );
    }
  }

  /// Returns a simple route table for quick access (optional).
  static Map<String, WidgetBuilder> routes() {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginScreen(),
      signup: (context) => const SignupScreen(),
      home: (context) => const HomeScreen(),
      productDetail: (context) => const ProductDetailScreen(),
      cart: (context) => const CartScreen(),
      checkout: (context) => const CheckoutScreen(),
      orders: (context) => const OrdersScreen(),
      profile: (context) => const ProfileScreen(),
    };
  }
}
