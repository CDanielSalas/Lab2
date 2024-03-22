import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sismos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sismos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicator: const FullWidthTabIndicator(
            indicatorHeight: 4,
            color: Colors.orange,
          ),
          tabs: const [
            Tab(
              child: Text(
                'Mapa',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            Tab(
              child: Text(
                'Lista',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/maps.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.transparent,
                ),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(10),
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                          color: Colors.orange, // Fondo naranja fijo para "24 horas"
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('24 horas', style: TextStyle(color: Colors.white)),
                            Icon(Icons.access_time, color: Colors.white), // Icono de reloj
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          color: Colors.black.withOpacity(0.7), // Ajustar la opacidad del color negro para "15 días"
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('15 días', style: TextStyle(color: Colors.white)),
                            Icon(Icons.calendar_today, color: Colors.white), // Icono de calendario
                          ],
                        ),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                  color: Colors.black,
                  selectedColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Sismos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: '¿Lo sentiste?',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Más',
          ),
        ],
        currentIndex: _tabController.index,
        selectedItemColor: Colors.orange,
        onTap: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class FullWidthTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color color;

  const FullWidthTabIndicator({
    required this.indicatorHeight,
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FullWidthPainter(this);
  }
}

class _FullWidthPainter extends BoxPainter {
  final FullWidthTabIndicator decoration;

  _FullWidthPainter(this.decoration);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Offset(offset.dx, (configuration.size!.height - decoration.indicatorHeight));
    final paint = Paint()..color = decoration.color;
    canvas.drawRect(rect & Size(configuration.size!.width, decoration.indicatorHeight), paint);
  }
}
