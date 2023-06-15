import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/components/async_search_bar.dart';
import 'package:recive/components/big_square_card.dart';
import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/features/featured/featured_screen.dart';
import 'package:recive/features/notification/notification_screen.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/scaffold_shell.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/models/recive.model.dart';
import 'package:recive/router/navigation_service.dart';

final extraRoutes = [
  GoRoute(
    name: 'privacy',
    path: '/privacy',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'about',
    path: '/about',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'contact',
    path: '/contact',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

final authRoutes = [
  GoRoute(
    name: 'login',
    path: '/login',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'signup',
    path: '/signup',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

final dashboardExtraRoutes = [
  GoRoute(
    name: NotificationScreen.name,
    path: '/${NotificationScreen.name}',
    builder: (context, state) => const NotificationScreen(),
  ),
  GoRoute(
    name: 'settings',
    path: '/settings',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

final initRoutes = [
  GoRoute(
    name: SplashScreen.name,
    path: '/${SplashScreen.name}',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    name: 'intro',
    path: '/intro',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

final dashboardRoutes = [
  ...dashboardExtraRoutes,
  GoRoute(
    name: DashboardScreen.name,
    path: '/${DashboardScreen.name}',
    redirect: (context, state) => state.namedLocation(
      DashboardWrapper.dashboardRouteNameToSelectedIndexMap.keys.first,
    ),
    builder: (context, state) => const DashboardScreen(),
  ),
  ShellRoute(
    navigatorKey: dashboardNavigatorKey,
    builder: (BuildContext context, GoRouterState state, Widget child) {
      return DashboardWrapper(child: child);
    },
    routes: <RouteBase>[
      GoRoute(
        name: FeaturedScreen.name,
        path: '/${DashboardScreen.name}/${FeaturedScreen.name}',
        builder: (context, state) => const FeaturedScreen(),
      ),
      GoRoute(
        name: RecipesScreen.name,
        path: '/${DashboardScreen.name}/${RecipesScreen.name}',
        builder: (context, state) => const RecipesScreen(),
      ),
      GoRoute(
        name: ProfileScreen.name,
        path: '/${DashboardScreen.name}/${ProfileScreen.name}',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
];

class TestRoute extends StatelessWidget {
  const TestRoute({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(child: Center(child: Text(text)));
  }
}

class SplashScreen extends StatelessWidget {
  static const name = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TestRoute(
      text: SplashScreen.name,
    );
  }
}

final recive = Recive.fromJson({
  "title": "Classic Chocolate Chip Cookies",
  "creatorSummary": {
    "firstName": "Mita",
    "lastName": "Takashi",
    "imageUrl":
        "https://unsplash.com/photos/I7A_pHLcQK8/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8M3x8YnVyZ2VyfGVufDB8fHx8MTY4NTMwODcyMnww&force=true&w=1920",
  },
  "origin": {
    "code": "KR",
    "country": "Korea",
    "state": "Areso",
    "city": "Seol",
    "title": "Korean"
  },
  "ingredients": [
    {
      "amount": 2,
      "measurement": "cups",
      "svgIcon": "flour_icon.svg",
      "name": "All-purpose flour"
    },
    {
      "amount": 1,
      "measurement": "cup",
      "svgIcon": "sugar_icon.svg",
      "name": "Granulated sugar"
    },
    {
      "amount": 1,
      "measurement": "cup",
      "svgIcon": "butter_icon.svg",
      "name": "Unsalted butter"
    },
  ],
  "instructions": [
    {
      "name": "Preparation",
      "description": "Preheat the oven...",
      "preparationTimeMinute": 15,
      "imageUrls": ["preparation_step1.jpg", "preparation_step2.jpg"]
    },
    {
      "name": "Baking",
      "description": "Scoop cookie dough...",
      "preparationTimeMinute": 10,
      "imageUrls": ["baking_step1.jpg", "baking_step2.jpg", "baking_step3.jpg"]
    },
  ],
  "difficultyLevel": "easy",
  "preparationTimeMinute": 30,
  "cookingTimeMinute": 10,
  "serving": "24 piece",
  "cuisineType": "Dessert",
  "calories": 150,
  "imageUrls": [
    "https://unsplash.com/photos/I7A_pHLcQK8/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8M3x8YnVyZ2VyfGVufDB8fHx8MTY4NTMwODcyMnww&force=true&w=1920",
    "https://unsplash.com/photos/MqT0asuoIcU/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8OHx8Zm9vZHxlbnwwfHx8fDE2ODU0MTcyNTN8MA&force=true&w=1920",
    "https://unsplash.com/photos/ZuIDLSz3XLg/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8Nnx8Zm9vZHxlbnwwfHx8fDE2ODU0MTcyNTN8MA&force=true&w=1920",
    "https://unsplash.com/photos/IGfIGP5ONV0/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8MTF8fGZvb2R8ZW58MHx8fHwxNjg1NDE3MjUzfDA&force=true&w=1920"
  ],
  "tags": ["Classic", "Cookies", "Dessert"],
  "allergens": [
    {"name": "Milk", "infoLink": "https://example.com/allergens/milk"},
    {"name": "Eggs", "infoLink": "https://example.com/allergens/eggs"}
  ],
  "source": "The Baker's Cookbook",
  "variations": ["Oatmeal Raisin", "Double Chocolate"]
});

final List<String> list = List.generate(20, (index) => "Text $index");

class RecipesScreen extends StatelessWidget {
  static const name = 'recipes';
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TestRoute(
      text: RecipesScreen.name,
    );
  }
}

class RecipeScreen extends StatelessWidget {
  static const name = 'recipes/:id';
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TestRoute(
      text: RecipeScreen.name,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  static const name = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TestRoute(
      text: ProfileScreen.name,
    );
  }
}
