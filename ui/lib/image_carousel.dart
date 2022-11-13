import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> with SingleTickerProviderStateMixin {
  int photoIndex = 0;
  late Animation carouselAnimation;
  late AnimationController animationController;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 18));

    carouselAnimation = IntTween(begin: 0, end: photos.length - 1).animate(animationController)..addListener(() {
      setState(() {
        photoIndex = carouselAnimation.value;
      });
    });

    animationController.repeat();
  }


  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  List<String> photos = [
    'assets/burger1.jpg',
    'assets/burger2.jpg',
    'assets/burger3.jpg',
    'assets/burger4.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Image Carousel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                      image: AssetImage(photos[photoIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 400.0,
                  width: 400.0,
                ),
                Positioned(
                  top: 375.0,
                  left: 25.0,
                  right: 25.0,
                  child: CarouselPoints(
                    numberOfDots: photos.length,
                    photoIndex: photoIndex,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselPoints extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  const CarouselPoints(
      {super.key, required this.photoIndex, required this.numberOfDots});

  Widget _inactivePoint() {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _activePoint() {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0),
            ]),
      ),
    );
  }

  List<Widget>  _buildDots() {
    List<Widget> dots = [];
    for(int i = 0; i < numberOfDots; ++i) {
      dots.add(
        i == photoIndex ? _activePoint() : _inactivePoint()
      );
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
