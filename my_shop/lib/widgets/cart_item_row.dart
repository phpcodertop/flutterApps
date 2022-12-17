import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartRowItem extends StatelessWidget {
  final String? id;
  final double? price;
  final int? quantity;
  final String? title;
  final String? productId;

  CartRowItem({
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (ctx) {
          return AlertDialog(
            title:  const Text('Are you sure?'),
            content: const Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(ctx).pop(false);
              }, child: const Text('NO')),
              TextButton(onPressed: () {
                Navigator.of(ctx).pop(true);
              }, child: const Text('Yes')),
            ],
          );
        });
      },
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title!),
            subtitle: Text('Total: \$${(price! * quantity!)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
