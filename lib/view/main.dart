import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/categories_bloc.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/networking/api_response.dart';
import 'package:untitled/view/loading.dart';
import 'package:untitled/view/error.dart';

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
        primarySwatch: Colors.deepPurple,
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    PageHome(),
    Text(
      'Index 1: История',
    ),
    Text(
      'Index 2: Профиль',
    ),
    Text(
      'Index 2: Корзина',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Alfresco"),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Главная",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "История",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Корзина",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = ProductsBloc();
  }

  @override
  void dispose() {
    _productsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<ApiResponse<List<CategoryModel>>>(
          stream: _productsBloc.listStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data!.message);
                case Status.COMPLETED:
                  return CategoryList(categoryList: snapshot.data!.data);
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () => _productsBloc.fetchCategoryList(),
                  );
              }
            }
            return Container();
          },
        ),
        StreamBuilder<ApiResponse<List<ProductModel>>>(
          stream: _productsBloc.productListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data!.message);
                case Status.COMPLETED:
                  return ProductList(productList: snapshot.data!.data);
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () => _productsBloc.fetchProductList(563),
                  );
              }
            }
            return Container();
          },
        ),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categoryList;

  const CategoryList({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Container(
                constraints: BoxConstraints(minWidth: 100),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  onTap: () {
                    // _productsBloc.fetchProductList(563);
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Text(categoryList[index].title),
                    ),
                  ),
                ));
          }),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<ProductModel> productList;

  const ProductList({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Container(
                child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(productList[index].title!),
                ),
              ),
            ));
          }),
    );
  }
}
