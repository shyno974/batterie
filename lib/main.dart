import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 230,
                  child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                        widget: Container(
                          child: const Text.rich(TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: '70%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40),
                            ),
                            TextSpan(
                                text: ' \n   Capacité restante ',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 8)),
                          ])),
                        ),
                      )
                    ],
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      RadialBarSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.nom,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          pointColorMapper: (GDPData data, _) => data.color,
                          // dataLabelSettings: DataLabelSettings(isVisible: true),
                          trackOpacity: 0.3,
                          cornerStyle: CornerStyle.bothCurve,
                          enableTooltip: true,
                          maximumValue: 100)
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Row(
                        children: const [
                          Text('-',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 135, 38, 31),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Text("80.0V",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: const [
                          Text('-',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 26, 114, 185),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Text("50.0A",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: const [
                          Text('-',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 35, 156, 39),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Text("75.0%",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: const [
                          Text('-',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 135, 38, 31),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Text("26°C",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      child: Text("Capacité restante",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      child: Text("150.3/200.0 Ah",
                          style: TextStyle(color: Colors.green)),
                    ),
                    Container(
                      child: Text("Puissance restante",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      child: Text("3607.2Wh/4800Wh",
                          style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "VEILLE",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('V', 80, const Color.fromARGB(255, 135, 38, 31)),
      GDPData('A', 25, const Color.fromARGB(255, 26, 114, 185)),
      GDPData('%', 75, const Color.fromARGB(255, 35, 156, 39)),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.nom, this.gdp, this.color);
  final String nom;
  final int gdp;
  final Color color;
}
