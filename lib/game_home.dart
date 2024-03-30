import 'package:flutter/material.dart';

import 'package:linebucks/utils/web.dart';
import 'package:linebucks/variables/local_variables.dart';
import 'package:linebucks/variables/modal_variable.dart';
import 'package:linebucks/widgets/commonboxnew.dart';
import 'package:linebucks/widgets/commonmincoinbar.dart';
import 'package:linebucks/widgets/commontop.dart';
import 'package:linebucks/widgets/help.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  late SharedPreferences _prefs;
  String deviceIdK = 'N/A';

  Future<void> _refreshData() async {
    int updatedCoins = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getInt(gameCoinsLabel) ?? 0;
    });

    // Update UI
    setState(() {
      gameCoins = updatedCoins;
    });
  }

  @override
  void initState() {
    super.initState();

    getdeviceId();
    updateCoins(deviceId, gameCoins.toString());
    if (phase != 0 && gameCoins >= phase) {
      _initializeSharedPreferences();
    }
  }

  Future<void> getdeviceId() async {
    var prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString(deviceIdLabel)!;
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // print(phase);

    if (DateTime.fromMillisecondsSinceEpoch(
                    _prefs.getInt('${phase}Coin-Completiontime') ?? 0)
                .toString() !=
            '' &&
        DateTime.fromMillisecondsSinceEpoch(
                    _prefs.getInt('${phase}Coin-Completiontime') ?? 0)
                .toString() ==
            '1970-01-01 05:30:00.000') {
      _prefs.setInt(
          '${phase}Coin-Completiontime', DateTime.now().millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Commontop(
                  refreshCallback: _refreshData,
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonMinCoinBar(
                  text1: otherLinksModel.otherlinks![7].link,
                  text2: otherLinksModel.otherlinks![8].link,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonBoxNew(
                      text: 'MINI TASK',
                      route: '/premium',
                      fontSize: 30.0,
                    ),
                    NeedHelpBox(route: '/help')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
