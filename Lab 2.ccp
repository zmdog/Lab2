#include <iostream>
#include <thread>
#include <math.h>

using namespace std;
using namespace chrono;
int arr[10], reserve, deep=0, state = false;
void arrShow(){
  cout<<endl;
  for(int i = 0; i <= sizeof(arr)/sizeof(arr[0])-1; i++){
    cout<<arr[i]<<" ";
  }
  cout<<"\n"<<endl;
}
void filler(){
  // Заполнение массива
  cout<<"\nВаш массив";
  for(int i = 0; i <= sizeof(arr)/sizeof(arr[0])-1; i++){
    if(1 + rand() % 2 == 2){
    arr[i] = -1 * (rand() % 100);
    }else arr[i] = rand() % 100;
  }
  arrShow();
}
// false - неотсортированный true-остортированный
void minMaxSearch(bool state){
  float minimum = 100, maximum = -100, average;
  // Начало поиска минимумов и максимумов в массиве
  auto start = high_resolution_clock::now();
  for(int i = 0; i <= sizeof(arr)/sizeof(arr[0])-1; i++){
    if(arr[i]>maximum){
      maximum = arr[i];
    }
    if(arr[i]<minimum){
      minimum = arr[i];
    }
  }
  // Конец поиска минимумов и максимумов в массиве
  auto end = high_resolution_clock::now();
  if(state){
    // Вывод времени поиска минимумов и максимумов в массиве
    cout<<"Поиск максимумов и минимумов в отсортированном массиве шел: "<< duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"
    <<"минимум: "<<minimum<<"\n"
    <<"максимум: "<<maximum<<"\n"<<endl;
  } else {
    // Вывод времени поиска минимумов и максимумов в неотсортированном массиве
    cout<<"Поиск максимумов и минимумов в неотсортированном массиве шел: "<< duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"
    <<"минимум: "<<minimum<<"\n"
    <<"максимум: "<<maximum<<"\n"<<endl;
  }

   // Вывод среднего значения минимума и максимума
  average = round((minimum+maximum)/2);
  cout<<"Среднее значение: "<<average<<"\n"<<endl;
}
void quanityA(){
  int count, a;
  cout<<"\nВведте первое число"<<"\n"<<endl;
  cin>>a;
  // Вывод количества элементов равных инициализированному числу a
  cout<<"\nиндексы элементов, больше инициализированного числа "<<a<<": ";
  for(int i = 0; i <= sizeof(arr)/sizeof(arr[0])-1; i++){
    if(arr[i]>a){
      cout<<i<<" индекс ";
      count++;
    }
  }
  cout<<"\n\nколичество элементов в массиве, равных инициализированному числу "<<a<<": "<<count<<"\n"<<endl;
}
void quanityB(){
  int count, b;
  cout<<"Введте второе число"<<"\n"<<endl;
  cin>>b;
  // Вывод количества элементов равных инициализированному числу b
  cout<<"индексы элементов, меньше инициализированного числа "<<b<<" ";
  for(int i = 0; i <= sizeof(arr)/sizeof(arr[0])-1; i++){
    if(arr[i]<b){
      cout<<i<<" индекс ";
      count++;
    }
  }
  cout<<"\n\nколичество элементов в массиве, равных инициализированному числу "<<b<<": "<<count<<"\n"<<endl;
}
int binarySearch(){
  int reserve;
  cout<<"Введите число для поиска\n";
  cin>>reserve;
  int size = sizeof(arr)/sizeof(arr[0]);
  int low = 0, hight = size-1;
  while(low<=hight){
    int mid = (low+hight) / 2;

    if(reserve == arr[mid]){
      cout<<"идекс нужно числа "<<mid<<endl;
      return 0;
    }else if(reserve>arr[mid]){
      low=mid+1;
    }else hight= mid-1;
  }
  return 0;
}
int defaultSearch(){
  int reserve;
  cout<<"Введите число для поиска\n";
  cin>>reserve;
  for(int i=0; i<=sizeof(arr)/sizeof(arr[0])-1;i++){
    if(arr[i]==reserve){
      cout<<"идекс нужно числа "<<i<<endl;
      return 0;
    }
  }
  
  return 0;
}
void numbReplace(int indexF, int indexS){
  int space;
  space = arr[indexF];
  arr[indexF] = arr[indexS];
  arr[indexS] = space;
}
// Сортировки
void bubbleSort(){
  for(int i = 0; i < sizeof(arr) / sizeof(arr[0]) - 1; i++){
    for(int j = 0; j < sizeof(arr) / sizeof(arr[0]) - i - 1; j++){
      if(arr[j]>arr[j+1]){
        reserve = arr[j+1];
        arr[j+1] = arr[j];
        arr[j] = reserve;
      }
    }
  }
}
void shakerSort(){
  int count = 2; 
  for(int i = 0; i < sizeof(arr) / sizeof(arr[0]) - count + 1; i++){
    for(int j = count - 2; j < sizeof(arr) / sizeof(arr[0]) - i - 1; j++){
      if(arr[j]>arr[j+1]){
        reserve = arr[j+1];
        arr[j+1] = arr[j];
        arr[j] = reserve;
      }
    }
    for(int j = sizeof(arr) / sizeof(arr[0]) - i - 2; j >= i + 1 ; j--){
      if(arr[j]<arr[j-1]){
        reserve = arr[j-1];
        arr[j-1] = arr[j];
        arr[j] = reserve;
      }
    }
    count++;
  }
}
void insertSort(){
  for(int i = 1; i < sizeof(arr) / sizeof(arr[0]); i++){
    for(int j = i; j > 0; j--){
      if(arr[j]<arr[j-1]){
        reserve = arr[j-1];
        arr[j-1] = arr[j];
        arr[j] = reserve;
      }
    }
  }
}
void quickSort(int *arr, int size){
    //Указатели в начало и в конец массива
    int i = 0;
    int j = size - 1;

    //Центральный элемент массива
    int mid = arr[size / 2];

    //Делим массив
    do {
        //Пробегаем элементы, ищем те, которые нужно перекинуть в другую часть
        //В левой части массива пропускаем(оставляем на месте) элементы, которые меньше центрального
        while(arr[i] < mid) {
            i++;
        }
        //В правой части пропускаем элементы, которые больше центрального
        while(arr[j] > mid) {
            j--;
        }

        //Меняем элементы местами
        if (i <= j) {
            int reserve = arr[i];
            arr[i] = arr[j];
            arr[j] = reserve;

            i++;
            j--;
        }
    } while (i <= j);


    //Рекурсивные вызовы, если осталось, что сортировать
    if(j > 0) {
        //"Левый кусок"
        quickSort(arr, j + 1);
    }
    if (i < size) {
        //"Првый кусок"
        quickSort(&arr[i], size - i);
    }
    state = true;
}
void combSort(){
  int step=sizeof(arr) / sizeof(arr[0])-1, count=0, reserve;
  while(step>=2||(step>1 || count>0)){
    count = 0;
    for(int i = 0; i+step<sizeof(arr) / sizeof(arr[0]);i++){
      if(arr[i]>arr[step+i]){
      reserve=arr[i];
      arr[i]=arr[step+i];
      arr[step+i]=reserve;
      count++;
      }
    }
    if (step>1) step = ceil(step-1.247);
  }
}
int selectOption(int option){
  auto coutSort = "1. Пересоздать массив\n2. Отсортировать пузырьком\n3. Отсортировать шейкером\n4. Отсортировать вставками\n5. Отсортировать расческой\n6. Отсоритровать быстро\n";
  auto coutBasic = "1. Пересоздать массив\n2. Отсортировать\n3. Найти минимум и максимум\n4. Найти кол-во элементов больше инициальзируемого\n5. Найти кол-во элементов меньше инициальзируемого\n6. Найти число перебором\n7. Найти число посредством бинарного поиска\n8. Поменять местами элементы массива\n";
  switch(option){
    case 1: {
      filler();
      deep = 1;
      cout<<coutBasic;
      break;
    }
    case 2: {
      if(deep == 2){
        auto start = high_resolution_clock::now();
        bubbleSort();
        auto end = high_resolution_clock::now();
        arrShow();
        cout<<"\nСортировка пузырьком производилась: "<< duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"<<endl;
        state = true;
        deep = 0;
        cout<<coutBasic;
      }else{
        deep = 2;
        cout<<coutSort;
      }
      break;
    }
    case 3: {
      if(deep == 2){
        auto start = high_resolution_clock::now();
        shakerSort();
        auto end = high_resolution_clock::now();
        arrShow();
        state = true;
        cout<<"\nСортировка шейкером производилась: "<< duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"<<endl;
        deep = 0;
        cout<<coutBasic;
      }else {minMaxSearch(state); deep = 0;cout<<coutBasic;}
      break;
    }
    case 4: {
      if(deep == 2){
        auto start = high_resolution_clock::now();
        insertSort();
        cout<<coutBasic;
        auto end = high_resolution_clock::now();
        arrShow();
        state = true;
        cout<<"\nСортировка вставками производилась: "<< duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"<<endl;
        deep = 0;
        cout<<coutBasic;
      }else {quanityA(); cout<<coutBasic;}
      break;
    }
    case 5: {
      if(deep == 2){
        auto start = high_resolution_clock::now();
        combSort();
        auto end = high_resolution_clock::now();
        arrShow();
        state = true;
        cout<<"\nСортировка расческой производилась: "<<duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"<<endl;
        deep = 0;
        cout<<coutBasic;
      }else {quanityB();cout<<coutBasic;}
      break;
    }
    case 6: {
      if(deep == 2){
        auto start = high_resolution_clock::now();
        quickSort(arr, sizeof(arr) / sizeof(arr[0]));
        auto end = high_resolution_clock::now();
        arrShow();
        state = true;
        cout<<"\nБыстрая сортировка производилась: "<<duration_cast<nanoseconds>(end-start).count()<<" наносекунд"<<"\n"<<endl;
        deep = 0;
        cout<<coutBasic;
      }else {
        auto start = high_resolution_clock::now();
      defaultSearch();
      auto end = high_resolution_clock::now();
      cout<<"поиск производился "<<duration_cast<nanoseconds>(end-start).count()<<" наносекунд\n\n";
      cout<<coutBasic;
      break;
        }
      break;
    }
    case 7: {
      auto start = high_resolution_clock::now();
      binarySearch();
      auto end = high_resolution_clock::now();
      cout<<"поиск производился "<<duration_cast<nanoseconds>(end-start).count()<<" наносекунд\n\n";
      cout<<coutBasic;
      break;
    }
    case 8: {
      int indexF, indexS;
      cout<<"\nВведите перый индекс\n";
      cin>>indexF;
      cout<<"\nВведите второй индекс\n";
      cin>>indexS;

      auto start = high_resolution_clock::now();
      numbReplace(indexF, indexS);
      auto end = high_resolution_clock::now();
      arrShow();
      cout<<"\nЗамена заняла "<<duration_cast<nanoseconds>(end-start).count()<<" наносекунд\n\n";
      cout<<coutBasic;
      break;
    }
  }
  return 0;
}
int main() {
  srand( time( 0 ) );
  cout<<"\n1. Заполнить массив\n"<<endl;
  do{
    int option;
    cout<<"\nВыберите действие\n"<<endl;
    cin>>option;
    selectOption(option);
  }while(true);
  return 0;
}
