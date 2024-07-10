import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spag/models/users/gym.dart';
import 'package:spag/models/offer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spag/presentation/widgets/nav_bar.dart';
import 'package:spag/providers/user_provider.dart';

// Service imports
import 'package:spag/services/image_service.dart';

class GymHomePage extends StatefulWidget {
  const GymHomePage({
    super.key,
  });

  @override
  State<GymHomePage> createState() => _GymHomePageState();
}

class _GymHomePageState extends State<GymHomePage> {
  @override
  Widget build(BuildContext context) {
    // Capturar el contexto antes de entrar en el bloque asíncrono de los mensajes de acierto/fallo al subir una imagen
    final scaffoldContext = ScaffoldMessenger.of(context);
    GymModel gym =
        Provider.of<UserProvider>(context, listen: false).user as GymModel;

    return Scaffold(
      appBar: const NavBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  icon:
                      const Icon(Icons.add_photo_alternate_outlined, size: 28),
                  onPressed: () async {
                    final imagen = await getImage();
                    if (imagen == null) {
                      return;
                    }
                    final uploaded =
                        await uploadImage(File(imagen.path), gym.id.toString());
                    if (uploaded) {
                      scaffoldContext.showSnackBar(const SnackBar(
                        content: Text("Imagen subida correctamente"),
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      scaffoldContext.showSnackBar(const SnackBar(
                        content: Text("Error al subir la imagen"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              gym.name,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: gym.getOffers(
                    // filters,
                    // orderBy: orderBy,
                    // descending: isDescending,
                    ),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        OfferModel offer = (snapshot.data?[index])!;
                        return Dismissible(
                          confirmDismiss: (direction) async {
                            bool result = false;

                            result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Confirm deletion of ${offer.title}"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(
                                                context, false);
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .cancel)),
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(context, true);
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .confirm,
                                              style: const TextStyle(
                                                  color: Colors.red))),
                                    ],
                                  );
                                });

                            return result;
                          },
                          onDismissed: (direction) async {
                            await offer.delete();
                            snapshot.data?.removeAt(index);
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                ],
                              ),
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          key: Key((offer.id.toString())),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              child: Text(
                                offer.title[0],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 28),
                              ),
                            ),
                            title: Text(offer.title),
                            subtitle: Text(
                              offer.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              "${offer.price} €",
                              style: const TextStyle(fontSize: 16),
                            ),
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, '/gym/updateOffer',
                                  arguments: offer);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            '/gym/addOffer',
          );
          // Actualiza la página para volver a cargar la lista de ofertas
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
