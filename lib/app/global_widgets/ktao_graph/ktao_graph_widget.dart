import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_controller.dart';
import 'package:ktao/app/utils/math_util.dart';

class KTaoGraph extends StatelessWidget {
  final Map<String, List<double>> lectXmes;
  final List<double> tasasConsumo;
  KTaoGraph({
    Key key,
    this.lectXmes,
    this.tasasConsumo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<KtaoGraphController>(
          init: KtaoGraphController(lectXmes: this.lectXmes),
          builder: (_) {
            return Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      // color: Color(0xff232d37),
                      color: Color(0xb590d4fe), //ARGB
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: LineChart(
                        _.showAvg ? avgData() : mainData(_),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      //! TODO: en proximos release agregar funcionalidad de mostrar otro grafico cuando se presione el TextButton
                      // _.showAvg = !_.showAvg;
                      // _.update();
                    },
                    child: Text(
                      'KWh/día',
                      style: TextStyle(
                          fontSize: 10,
                          color: _.showAvg
                              ? Colors.white.withOpacity(0.5)
                              : Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  LineChartData mainData(KtaoGraphController ctr) {
    Map<String, num> extremeYaxis = utilgetExtremeValues(this.tasasConsumo);
    final minYaxis = extremeYaxis["minValue"];
    final maxYaxis = extremeYaxis["maxValue"];
    final centerYaxis = (maxYaxis - minYaxis) / 2;

    ctr.setYTitlesExtremes(minYaxis, maxYaxis);

    return LineChartData(
      gridData: FlGridData(
        show: false, // !OJO para mostrar los grids
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          // value va a tener todos los valores del eje X a medida que se renderiza el grafico
          getTitles: ctr.bottomRenderTitles,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: ctr.leftRenderTitles,
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      //! OJO para variar el eje X,hacerlos depender de los maximos que tienen las lect
      maxX: this.tasasConsumo.length.toDouble(),
      minY: minYaxis,
      maxY: maxYaxis + (centerYaxis / 4),
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          showOnTopOfTheChartBoxArea: true,
          // fitInsideVertically: true,
          getTooltipItems: ctr.getTooltipItems,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots:
              ctr.getGraphSpots(this.tasasConsumo), //! LOS DATOS PARA GRAFICAR
          isCurved: true,
          curveSmoothness: 0.2,
          colors: ctr.gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: ctr.gradientColors
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    final graphCtr = Get.find<KtaoGraphController>();
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(
                    begin: graphCtr.gradientColors[0],
                    end: graphCtr.gradientColors[1])
                .lerp(0.2),
            ColorTween(
                    begin: graphCtr.gradientColors[0],
                    end: graphCtr.gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(
                    begin: graphCtr.gradientColors[0],
                    end: graphCtr.gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(
                    begin: graphCtr.gradientColors[0],
                    end: graphCtr.gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
