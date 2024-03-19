import 'dart:math';

String generateTeamCode() {
  final Random random = Random();
  String alphabets = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String teamCode = '';
  late String alphabetCode;
  late String numCode;
  for (var i = 0; i <= 4; i++) {
    alphabetCode = String.fromCharCodes(Iterable.generate(
        4, (_) => alphabets.codeUnitAt(random.nextInt(alphabets.length))));
  }
  for (var i = 0; i <= 4; i++) {
    numCode = String.fromCharCodes(Iterable.generate(
        4, (_) => numbers.codeUnitAt(random.nextInt(numbers.length))));
  }
  teamCode = alphabetCode + numCode;
  return teamCode;
}
