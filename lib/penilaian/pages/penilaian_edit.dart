import 'package:flutter/material.dart';
import 'package:sewarumah/penilaian/services/penilaian_service.dart';
import 'package:provider/provider.dart';

class PenilaianEditPage extends StatefulWidget {
  const PenilaianEditPage({Key? key}) : super(key: key);

  @override
  State<PenilaianEditPage> createState() => _PenilaianEditPageState();
}

class _PenilaianEditPageState extends State<PenilaianEditPage> {
  final TextEditingController nilaiBaruController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<PenilaianService>(
              builder: (context, penilaian, child) => Column(children: [
                    Text(penilaian.listKonsultan[penilaian.selectedIndex!]
                        ['nama']),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('input nilai baru'),
                    TextFormField(
                      controller: nilaiBaruController,
                      keyboardType: TextInputType.number,
                    ),
                    TextButton(
                      onPressed: () {
                        penilaian.updateNilaiKonsultan(penilaian.selectedIndex!,
                            int.parse(nilaiBaruController.text));
                      },
                      child: const Text('Save data'),
                    )
                  ]))),
    );
  }
}
