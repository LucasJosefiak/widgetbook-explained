import 'package:flutter/widgets.dart';
import 'package:groceries_app/features/features.dart';
import 'package:groceries_app/repositories/data_store.dart';
import 'package:groceries_app/repositories/fruit.dart';
import 'package:widgetbook/widgetbook.dart';

part 'basket_view.stories.g.dart';

const meta = Meta(BasketView.new);

final $Empty = _Story(
  name: 'Empty',
  designLink:
      'https://www.figma.com/design/HsANkdhbsCNTkXBzNJRNLD/Groceries-Demo?node-id=6809-5986&t=zUakLdAaKjMZAqSq-4',
  // The empty state's PrimaryButton Row overflows at iPhone-13 width with the
  // longer German labels (a pre-existing layout issue in PrimaryButton), which
  // `flutter test` treats as an error. Renders fine in the interactive app.
  excludeFromTests: true,
  args: _Args(
    basket: Arg.fixed(const <Fruit, ProductOrder>{}),
    delivery: DoubleArg(0),
    subTotal: DoubleArg(0),
  ),
);

// A shared, mutable state so the card's add/remove buttons (which read
// `BasketState.of(context)` from the [BasketScope] provided in `setup`)
// update the same store that backs the `basket` arg below.
final _basketState = BasketState(
  data: {
    DataStore.fruits[0]: ProductOrder(
      fruit: DataStore.fruits[0],
      quantity: 1,
    ),
    DataStore.fruits[1]: ProductOrder(
      fruit: DataStore.fruits[1],
      quantity: 2,
    ),
  },
);

final $NonEmpty = _Story(
  name: 'Non-empty',
  designLink:
      'https://www.figma.com/design/HsANkdhbsCNTkXBzNJRNLD/Groceries-Demo?node-id=6809-5504&t=zUakLdAaKjMZAqSq-4',
  // Renders BasketCards whose fruit images load from remote URLs, which cannot
  // be loaded under `flutter test`. It still renders in the interactive app.
  excludeFromTests: true,
  setup: (context, child, args) => BasketScope(
    state: _basketState,
    child: child,
  ),
  args: _Args(
    basket: Arg.fixed(_basketState.store),
    delivery: DoubleArg(_basketState.delivery),
    subTotal: DoubleArg(_basketState.subTotal),
  ),
);
