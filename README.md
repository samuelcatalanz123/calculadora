# Calculadora — App de Flutter 🧮

Una calculadora hecha con **Flutter** (Dart): suma, resta, multiplica y divide,
con una cuadrícula de botones y pantalla.

> Hecha por Samuel 💜

## Qué hace

- ➕➖✖️➗ Operaciones básicas.
- Encadena operaciones (ej. `2 + 3 + 4 = 9`).
- Botones **C** (borrar todo) y **⌫** (borrar el último).
- Muestra los enteros sin decimales (4.0 → "4").

## Conceptos que demuestra

- Crear una **cuadrícula de botones** con bucles (sin escribir cada uno a mano).
- La **lógica** de una calculadora (guardar número + operador, calcular en `=`).
- Estado con `setState`, formateo de números, y diseño con `Row` / `Expanded`.

## Cómo ejecutar

```bash
flutter pub get
flutter run            # emulador o dispositivo
# o en el navegador:
flutter run -d chrome
```

El código está en `lib/main.dart`.

## Stack

Flutter · Dart.
