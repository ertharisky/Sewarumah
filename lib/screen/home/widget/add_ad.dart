import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/ad.dart';
import 'package:sewarumah/model/repo/ad.dart';
import 'package:sewarumah/network/api/ad/ad.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/ad_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahAdPage extends StatefulWidget {
  const TambahAdPage({Key? key}) : super(key: key);

  @override
  State<TambahAdPage> createState() => _TambahAdPageState();
}

class _TambahAdPageState extends State<TambahAdPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController luasController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Iklan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(children: [
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
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Dio dio = Dio();
                      DioClient dioClient = DioClient(dio);
                      AdApi adApi = AdApi(dioClient: dioClient);
                      AdRepository adRepository = AdRepository(adApi: adApi);
                      final prefs = await SharedPreferences.getInstance();
                      try {
                        ModelAd modelAd = await adRepository.createAdReq(
                            namaController.text,
                            alamatController.text,
                            luasController.text,
                            hargaController.text,
                            deskripsiController.text,
                            prefs.getString("token")!);

                        context.read<AdProvider>().addAd(modelAd);

                        const snackBar = SnackBar(
                          content: Text('Data berhasil diinput!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      } catch (e) {
                        String err = e.toString();
                        print(err);
                        final snackBar = SnackBar(
                          content: Text(err),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: const Text("Tambah"))
            ]),
          ),
        ),
      ),
    );
  }
}
