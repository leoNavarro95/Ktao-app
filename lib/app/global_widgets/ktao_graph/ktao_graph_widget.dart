import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_controller.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/utils/math_util.dart';

import '../widgets.dart';

/// Dibuja un grafico de tasas de consumo.
/// Dejar lectXmes vacio {} para que sea un grafico minimalista sin info en los ejes
class KTaoGraph extends StatelessWidget {
  final Map<String, List<double>> lectXmes;
  final List<double> tasasConsumo;
  final Color bkgColor;
  final bool hasBorder,
      hasLabelOnYaxis,
      hasLabelOnXaxis,
      hasLineTouch,
      hasNegativeData;
  final double aspectRatio, lineWidth;
  KTaoGraph({
    this.lectXmes = const {},
    this.hasBorder = true,
    this.hasLabelOnYaxis = true,
    this.hasNegativeData = false,
    this.hasLabelOnXaxis = true,
    this.hasLineTouch = true,
    this.bkgColor,
    this.aspectRatio = 2,
    this.lineWidth = 4,
    this.tasasConsumo,
  }); //  : lectXmes = lectXmes ?? const {};

  final KtaoGraphController graphCtr = Get.find<KtaoGraphController>();

  @override
  Widget build(BuildContext context) {
    graphCtr.lectXmes = this.lectXmes;
    Widget _buttonOnYaxis = Container();
    Widget _labelOnXaxis = Container();

    Widget _chartWidget = Container();

    if (this.hasNegativeData) {
      _chartWidget = errorGraphWidget(
          message: 'Error en sus datos',
          color: Colors.red,
          icon: Icons.error_outline_rounded);
    } else if (this.tasasConsumo.length < 2) {
      if (this.aspectRatio > 3)
        return myroundedContainer(
          bkgColor: Colors.blue.withAlpha(20),
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.blue,
          text: Text('Faltan datos', style: TemaTexto().infoTarjeta),
        );

      _chartWidget = errorGraphWidget(
          message: 'Debe tener al menos 2 lecturas',
          color: Colors.blueAccent,
          icon: Icons.bar_chart);
    } else {
      if (this.hasLabelOnXaxis) {
        _labelOnXaxis = Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            child: Text(
              'meses',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: graphCtr.showAvg
                      ? Colors.white.withOpacity(0.5)
                      : Color(0xff67727d)),
            ),
          ),
        );
      }

      if (this.hasLabelOnYaxis) {
        _buttonOnYaxis = Positioned(
          top: 10,
          left: 5,
          child: Text(
            'KWh/día',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: graphCtr.showAvg
                    ? Colors.white.withOpacity(0.5)
                    : Color(0xff67727d)),
          ),
        );
      }

      _chartWidget = LineChart(
        graphCtr.showAvg ? avgData(graphCtr) : mainData(graphCtr),
      );
    }
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: this.aspectRatio,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: bkgColor,
            ),
            child: _chartPadding(_chartWidget),
          ),
        ),
        _buttonOnYaxis,
        _labelOnXaxis,
      ],
    );
  }

  Padding _chartPadding(Widget _chartWidget) {
    return Padding(
      padding: EdgeInsets.only(
        right: (this.aspectRatio < 3) ? 18 : 5,
        left: (this.aspectRatio < 3) ? 12 : 5,
        top: (this.aspectRatio < 3) ? 24 : 5,
        bottom: (this.aspectRatio < 3) ? 15 : 5,
      ),
      child: _chartWidget,
    );
  }

  // Local Widgets
  Widget errorGraphWidget(
      {IconData icon = Icons.error_outline,
      String message = 'Error',
      Color color = Colors.red}) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: (this.aspectRatio < 3) ? 100 : 45,
            ),
            Text(
              message,
              style: TextStyle(
                  fontSize: (this.aspectRatio < 3) ? 20 : 10, color: color),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData(KtaoGraphController ctr) {
    bool showAxis = this.lectXmes.isNotEmpty;
    if (showAxis) ctr.setXaxisData(this.lectXmes);

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
        show: showAxis, //si no hay datos en lectXmes no se muestran
        bottomTitles: SideTitles(
          showTitles: showAxis,
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
          showTitles: showAxis,
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
          show: this.hasBorder,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      //! OJO para variar el eje X,hacerlos depender de los maximos que tienen las lect
      maxX: this.tasasConsumo.length.toDouble(),
      minY: minYaxis,
      maxY: maxYaxis + (centerYaxis / 4),
      lineTouchData: LineTouchData(
        enabled: this.hasLineTouch,
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
          barWidth: this.lineWidth,
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

  LineChartData avgData(KtaoGraphController graphCtr) {
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
