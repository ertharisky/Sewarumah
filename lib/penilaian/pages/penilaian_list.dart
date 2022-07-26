import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/penilaian/pages/penilaian_edit.dart';
import 'package:sewarumah/penilaian/services/penilaian_service.dart';

class PenilaianListPage extends StatelessWidget {
  const PenilaianListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('PENILAIAN KONSULTAN'),
            Expanded(
                child: Consumer<PenilaianService>(
              //berasal dari library provider
              builder: ((context, penilaian, _) => ListView.builder(
                  itemCount: penilaian.listKonsultan.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        penilaian.selectedIndex = index;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PenilaianEditPage()),
                        );
                      },
                      child: Container(
                        color: Colors.cyan[50],
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  Text(penilaian.listKonsultan[index]['nama']),
                            ),
                            Text(penilaian.listKonsultan[index]['nilai']
                                .toString())
                          ],
                        ),
                      ),
                    );
                  })),
            ))
          ],
        ),
      ),
    );
  }
}
