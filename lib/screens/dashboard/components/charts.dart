import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: AspectRatio(
        aspectRatio: 1.3,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, PieTouchResponse? response) {
                setState(() {
                  if (event.isInterestedForInteractions && 
                      response != null && 
                      response.touchedSection != null) {
                    touchedIndex = response.touchedSection!.touchedSectionIndex;
                  } else {
                    touchedIndex = -1;
                  }
                });
              },
            ),
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      
      return PieChartSectionData(
        color: _getSectionColor(i),
        value: _getSectionValue(i),
        title: _getSectionTitle(i),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  // Вспомогательные методы для улучшения читаемости
  Color _getSectionColor(int index) {
    switch(index) {
      case 0: return const Color(0xff0293ee);
      case 1: return const Color(0xfff8b250);
      case 2: return const Color(0xff845bef);
      case 3: return const Color(0xff13d38e);
      default: throw Error();
    }
  }

  double _getSectionValue(int index) {
    switch(index) {
      case 0: return 40;
      case 1: return 30;
      case 2: return 15;
      case 3: return 15;
      default: throw Error();
    }
  }

  String _getSectionTitle(int index) {
    switch(index) {
      case 0: return '28.3%';
      case 1: return '16.7%';
      case 2: return '22.4%';
      case 3: return '2.3%';
      default: throw Error();
    }
  }
}