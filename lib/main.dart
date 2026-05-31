import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _display = '0';
  double? _acumulado; // el primer número guardado
  String? _operador; // la operación pendiente (+, -, ×, ÷)
  bool _reiniciarAlEscribir = false;

  // Cuando se presiona un botón, decidimos qué hacer según su texto.
  void _presionar(String t) {
    if (t == 'C') {
      _limpiar();
    } else if (t == '⌫') {
      _borrar();
    } else if (['+', '-', '×', '÷'].contains(t)) {
      _operadorPresionado(t);
    } else if (t == '=') {
      _igual();
    } else {
      _digito(t); // un número o el punto
    }
  }

  void _digito(String d) {
    setState(() {
      if (_reiniciarAlEscribir || _display == '0') {
        _display = (d == '.') ? '0.' : d;
        _reiniciarAlEscribir = false;
      } else {
        if (d == '.' && _display.contains('.')) return;
        _display += d;
      }
    });
  }

  void _operadorPresionado(String op) {
    setState(() {
      if (!_reiniciarAlEscribir) _calcular();
      _operador = op;
      _acumulado = double.tryParse(_display);
      _reiniciarAlEscribir = true;
    });
  }

  // Hace la operación pendiente con el número actual.
  void _calcular() {
    if (_operador == null || _acumulado == null) return;
    final actual = double.tryParse(_display) ?? 0;
    double r = _acumulado!;
    switch (_operador) {
      case '+':
        r += actual;
        break;
      case '-':
        r -= actual;
        break;
      case '×':
        r *= actual;
        break;
      case '÷':
        r = actual == 0 ? 0 : r / actual;
        break;
    }
    _display = _formatear(r);
    _acumulado = r;
  }

  void _igual() {
    setState(() {
      _calcular();
      _operador = null;
      _acumulado = null;
      _reiniciarAlEscribir = true;
    });
  }

  void _limpiar() {
    setState(() {
      _display = '0';
      _acumulado = null;
      _operador = null;
      _reiniciarAlEscribir = false;
    });
  }

  void _borrar() {
    setState(() {
      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  // Quita los decimales si el número es entero (ej. 4.0 → "4").
  String _formatear(double n) {
    if (n == n.roundToDouble()) return n.toInt().toString();
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    final filas = [
      ['C', '⌫', '÷', '×'],
      ['7', '8', '9', '-'],
      ['4', '5', '6', '+'],
      ['1', '2', '3', '.'],
    ];

    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SafeArea(
        child: Column(
          children: [
            // Pantalla (display)
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(28),
                child: Text(
                  _display,
                  style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w300),
                  maxLines: 1,
                ),
              ),
            ),
            // Botones
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  for (final fila in filas)
                    Row(children: fila.map((t) => _boton(t)).toList()),
                  Row(children: [
                    _boton('0', flex: 2),
                    _boton('=', color: Colors.indigo),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Un botón de la calculadora.
  Widget _boton(String texto, {Color? color, int flex = 1}) {
    final esOperador = ['+', '-', '×', '÷', '='].contains(texto);
    final fondo = color ??
        (texto == 'C' || texto == '⌫'
            ? Colors.indigo.shade400
            : esOperador
                ? Colors.indigo.shade600
                : Colors.indigo.shade800);

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: 72,
          child: FilledButton(
            onPressed: () => _presionar(texto),
            style: FilledButton.styleFrom(
              backgroundColor: fondo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(texto, style: const TextStyle(fontSize: 26)),
          ),
        ),
      ),
    );
  }
}
