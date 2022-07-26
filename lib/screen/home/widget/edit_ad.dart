import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/model/repo/ad.dart';
import 'package:sewarumah/network/api/ad/ad.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/ad_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAdPage extends StatefulWidget {
  EditAdPage({Key? key, required this.modelAd, required this.index})
      : super(key: key);
  ModelAd modelAd;
  int index;

  @override
  State<EditAdPage> createState() => _EditAdPageState();
}

class _EditAdPageState extends State<EditAdPage> {
  final _formKey = GlobalKey<FormState>();

  getProcess(int status) {
    if (status == 1) {
      return "Tersedia";
    } else if (status == 2) {
      return "Terjual";
    }
    return "Tersedia";
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: widget.modelAd.nama);
    TextEditingController alamatController =
        TextEditingController(text: widget.modelAd.alamat);
    TextEditingController hargaController =
        TextEditingController(text: widget.modelAd.harga);
    TextEditingController luasController =
        TextEditingController(text: widget.modelAd.luas);
    TextEditingController deskripsiController =
        TextEditingController(text: widget.modelAd.deskripsi);
    return ChangeNotifierProvider<AdProvider>(
      create: (context) => AdProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Iklan"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 254, 206, 144)),
                        child: Text(
                          getProcess(widget.modelAd.status),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 190, 74, 3),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Nama',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Nama",
                      ),
                      controller: namaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Alamat',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Alamat",
                      ),
                      controller: alamatController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Harga',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Harga",
                      ),
                      controller: hargaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Luas',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Luas",
                      ),
                      controller: luasController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Deskripsi',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Deskripsi",
                      ),
                      controller: deskripsiController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueGrey)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Dio dio = Dio();
                              DioClient dioClient = DioClient(dio);
                              AdApi adApi = AdApi(dioClient: dioClient);
                              AdRepository adRepository =
                                  AdRepository(adApi: adApi);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              try {
                                ModelAd model = await adRepository.updateAdReq(
                                    widget.modelAd.id,
                                    namaController.text,
                                    alamatController.text,
                                    luasController.text,
                                    hargaController.text,
                                    deskripsiController.text,
                                    "update",
                                    prefs.getString("token")!);

                                context
                                    .read<AdProvider>()
                                    .updateAd(widget.index, model);

                                const snackBar = SnackBar(
                                  content: Text('Data berhasil diupdate!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              } catch (e) {
                                String err = e.toString();
                                print(err);
                                final snackBar = SnackBar(
                                  content: Text(err),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: const Text("Update")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Dio dio = Dio();
                              DioClient dioClient = DioClient(dio);
                              AdApi adApi = AdApi(dioClient: dioClient);
                              AdRepository adRepository =
                                  AdRepository(adApi: adApi);
                              final prefs =
                                  await SharedPreferences.getInstance();

                              try {
                                await adRepository.updateAdReq(
                                    widget.modelAd.id,
                                    namaController.text,
                                    alamatController.text,
                                    luasController.text,
                                    hargaController.text,
                                    deskripsiController.text,
                                    "hapus",
                                    prefs.getString("token")!);

                                context
                                    .read<AdProvider>()
                                    .deleteAd(widget.index);

                                const snackBar = SnackBar(
                                  content: Text('Data berhasil dihapus!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              } catch (e) {
                                String err = e.toString();
                                print(err);
                                final snackBar = SnackBar(
                                  content: Text(err),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: const Text("Delete")),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
