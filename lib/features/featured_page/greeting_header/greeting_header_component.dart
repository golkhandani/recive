import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/features/featured_page/greeting_header/bloc/greeting_header_bloc.dart';
import 'package:recive/features/notification/notification_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';

class GreetingHeader extends HookWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<GreetingHeaderBloc>();
    final state = useBlocBuilder(bloc);
    useEffect(() {
      bloc.add(const GreetingHeaderEvent.load());
      return;
    }, []);
    // Then observe state's updates
    // `buildWhen` param will override builderCondition locally

    // Create a listener for the side-effect
    // useBlocListener(bloc, (cubit, value, context) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text("Button clicked"),
    //   ));
    // });
    return Container(
      color: context.theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Greeting",
                style: context.textTheme.titleSmall,
              ),
              if (state.isLoading || !state.hasUser) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: 120,
                  child: LinearProgressIndicator(
                    backgroundColor: context.schema.primary,
                    color: context.schema.primaryContainer,
                  ),
                ),
              ] else ...[
                Text(
                  state.user!.name,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              navigationService.navigateTo(NotificationScreen.name);
            },
            child: Badge(
              backgroundColor: context.schema.error,
              largeSize: state.isLoading && !state.hasNotification ? 0 : 24,
              isLabelVisible: true,
              textColor: context.schema.onError,
              textStyle: context.textTheme.labelSmall!.copyWith(
                color: context.schema.onError,
                fontWeight: FontWeight.bold,
              ),
              label: SizedBox(
                width: 16,
                height: 16,
                child: Center(
                  child: Text(
                    state.notificationCount.toString(),
                  ),
                ),
              ),
              smallSize: state.isLoading && !state.hasNotification ? 0 : 24,
              child: Iconify(
                Mdi.notifications,
                color: context.schema.primaryContainer,
                size: 36,
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              navigationService.navigateTo('settings');
            },
            child: Iconify(
              Mdi.settings,
              color: context.schema.primaryContainer,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
