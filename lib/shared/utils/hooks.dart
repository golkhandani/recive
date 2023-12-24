import 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_hooks/flutter_hooks.dart' show useEffect;
export 'package:hooked_bloc/hooked_bloc.dart' show useBloc, useBlocBuilder, useBlocComparativeBuilder, useBlocListener;

typedef StatefulHook = StatefulHookWidget;
typedef StatelessHook = HookWidget;

const effectRunOnce = [];
const effectRunEvery = null;
effectRunKeys(List<dynamic> keys) => keys;
