import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/theme/theme_cubit.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/art_detail_screen/user_interaction_bloc.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_search_screen/dashboard_search_screen.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_bloc.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/news_detail_screen/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SavedItemsPage extends StatefulWidget {
  static String name = 'saved-items';
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  final authBloc = locator.get<AuthBloc>();
  late final profileBloc = BlocProvider.of<ProfileBloc>(context);
  late final userInteractionBloc = BlocProvider.of<UserInteractionBloc>(context);
  late final themeBloc = BlocProvider.of<ThemeCubit>(context);
  late final emailController = TextEditingController(text: profileBloc.state.user?.email);
  late final nameController = TextEditingController(text: profileBloc.state.user?.name);
  final NavigationService navigationService = locator.get();

  _onScrollEnd() {
    final sn = _scrollController;
    if (sn.position.pixels >= sn.position.maxScrollExtent - 100
        // && bloc.state.isLoading != LoadingState.updating
        ) {
      userInteractionBloc.getSavedItems();
    }
  }

  final _scrollController = ScrollController(keepScrollOffset: true);
  late ListModel<InteratedEntityAbstractModel> _list;

  @override
  void initState() {
    _scrollController.addListener(_onScrollEnd);
    _list = ListModel<InteratedEntityAbstractModel>(
      listKey: GlobalKey<SliverAnimatedListState>(),
      initialItems: userInteractionBloc.state.savedItems,
      removedItemBuilder: _buildRemovedItem,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userInteractionBloc.getSavedItems(reload: true);
    });
    super.initState();
  }

  Widget _buildRemovedItem(_, __, ___) {
    return const SizedBox();
  }

  _syncList(UserInteractionBlocState state) {
    if (state.savedItems.isEmpty) {
      _list.listKey.currentState?.removeAllItems(
        (c, a) => const SizedBox(),
        duration: Duration.zero,
      );
      _scrollController.jumpTo(0);
      return;
    }

    List<InteratedEntityAbstractModel> itemsToRemove =
        _list.toSet().difference(state.savedItems.toSet()).toList();
    List<InteratedEntityAbstractModel> itemsToAdd =
        state.savedItems.toSet().difference(_list.toSet()).toList();

    for (var itr in itemsToRemove) {
      _list.removeAt(_list.indexOf(itr));
    }
    for (var ita in itemsToAdd) {
      _list.insert(_list.length, ita);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollEnd);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = Container(
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
        border: Border(
          bottom: kExtraTinyBorder.copyWith(
            color: context.colorTheme.onPrimaryContainer,
          ),
        ),
      ),
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
      height: context.vTopSafeHeight + kToolbarHeight,
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              LeadingBackButton(
                backgroundColor: context.colorTheme.primaryContainer,
                padding: EdgeInsets.only(
                  left: kTinyPadding.left,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Saved Items',
                    style: context.typographyTheme.titleSmall.textStyle.copyWith(
                      color: context.colorTheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: kToolbarHeight)
            ],
          ),
        ),
      ),
    );
    return ColoredBox(
      color: context.colorTheme.background,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [PinnedHeaderSliver(child: header)];
        },
        body: CustomScrollView(
          cacheExtent: 1000,
          slivers: [
            SliverGap(kTinyPadding.bottom),
            BlocListener<UserInteractionBloc, UserInteractionBlocState>(
              listenWhen: (o, n) {
                return o.interactions != n.interactions ||
                    o.savedItems.length != n.savedItems.length;
              },
              listener: (context, state) {
                _syncList(state);
              },
              bloc: userInteractionBloc,
              child: SliverAnimatedList(
                key: _list.listKey,
                initialItemCount: _list.length,
                itemBuilder: (context, index, a) {
                  final data = _list[index];
                  final page = switch (data.entityType) {
                    EntityType.art => ArtDetailScreen.name,
                    EntityType.artist => ArtistDetailScreen.name,
                    EntityType.news => NewsDetailScreen.name,
                    EntityType.event => EventDetailScreen.name,
                    EntityType.community => CommunityDetailScreen.name,
                    EntityType.unknown => null,
                  };
                  if (page == null) {
                    // todo alert for update
                    return const SizedBox();
                  }
                  return Container(
                    margin: EdgeInsets.only(
                      right: kMediumPadding.right,
                      left: kMediumPadding.left,
                      bottom: kMediumPadding.bottom,
                      top: index == 0 ? kMediumPadding.top : 0,
                    ),
                    child: InteractedCardContainer(
                      onTap: () {
                        final current = navigationService.homeUrl;
                        navigationService.homeContext.push(
                          '$current/$page/${data.id}',
                          extra: data.toJson(),
                        );
                      },
                      data: data,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<SliverAnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  SliverAnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index, duration: Duration.zero);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);

  Set<E> toSet() => _items.toSet();
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);
