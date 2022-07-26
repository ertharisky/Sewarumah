import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/penilaian/pages/penilaian_list.dart';
import 'package:sewarumah/penilaian/services/penilaian_service.dart';

class Provider extends StatelessWidget {
  const Provider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PenilaianService>(
      create: (_) => PenilaianService(),
      child: const MaterialApp(
        home: PenilaianListPage(),
      ),
    );
  }
}
