// ignore_for_file: prefer_final_fields, file_names
import 'Provider/Menu.dart';

// class DummyData {
final List<Menu> listOfMeal = [
  Menu(
    id: 'm1',
    title: 'Spaghetti with Tomato Sauce',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    price: 20,
    description: 'Meal is Good',
    categories: [
      'A',
      'P',
    ],
  ),
  Menu(
    id: 'm2',
    title: 'Toast Hawaii',
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    price: 10,
    description: 'Something is very good',
    categories: [
      'c2',
    ],
  ),
  Menu(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    title: 'Classic Hamburger',
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    price: 45,
    description: 'Something is favrite',
  ),
];

// }