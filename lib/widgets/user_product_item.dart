import 'package:flutter/material.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURl;
  UserProductItem(this.id, this.title, this.imageURl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageURl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id,
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Products>(
                      context,
                      listen: false,
                    ).deleteProduct(id);
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Product Deleted',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } catch (error) {
                    scaffold.showSnackBar(SnackBar(
                      content: Text(
                        'Deleting Failed!',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Theme.of(context).errorColor,
                    ));
                  }
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ));
  }
}
