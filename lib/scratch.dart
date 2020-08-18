import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String timeperiod = await task2();
  task3(timeperiod);
  task4();
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
   Duration timedelay = new Duration(seconds: 3);

   String result;

   await Future.delayed(timedelay,(){
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String timeperiod) {
  String result = 'task 3 data';
  print('Task 3 complete $timeperiod');
}
void task4() {
  String result = 'task 4 data';
  print('Task 4 complete');
}