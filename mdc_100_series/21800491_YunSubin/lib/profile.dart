import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'detail.dart';
import 'home.dart';
import 'model/product.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/knight063.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        artboard.addController(_controller = SimpleAnimation('idle'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  void _changeToNight(bool wipersOn) {
    if (!isSwitched) {
      _riveArtboard.addController(
        _controller = SimpleAnimation('night_day'),
      );
    } else {
      _riveArtboard.addController(
        _controller = SimpleAnimation('day_night'),
      );
    }
    setState(() => _controller.isActive);
  }

  bool isSwitched = false;
  final List<Product> saveHotelList = HomePage.savedHotels.toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
          title: Text('My Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    ClipOval(
                        child: Container(
                          width: 200,
                          height: 200,
                          child: _riveArtboard == null
                              ? const SizedBox()
                              : Rive(
                            artboard: _riveArtboard,
                          ),
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //Center Column contents vertically,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          !isSwitched
                              ? Icon(
                            (Icons.wb_sunny),
                            color: Colors.orange,
                          )
                              : Icon(
                            (Icons.wb_sunny),
                            color: Colors.grey,
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                _changeToNight(isSwitched);
                              });
                            },
                            inactiveThumbColor: Colors.yellow,
                            inactiveTrackColor: Colors.orange,
                            activeTrackColor: Colors.deepPurple,
                            activeColor: Colors.purple,
                          ),
                          !isSwitched
                              ? Icon((Icons.nightlight_round), color: Colors.grey,)
                              : Icon(
                            (Icons.nightlight_round),
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                    Text('Subin Yun'),
                    Text('21800491'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 140, 0),
                child: Text('My Favorite Hotel List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              for (final location in saveHotelList)
                LocationListItem(
                  product : location,
                  imageUrl: location.assetName,
                  name: location.name,
                  country: location.name,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExampleParallax extends StatelessWidget {
  const ExampleParallax({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
  List<Product> saveHotelList = HomePage.savedHotels.toList();
    return
      SingleChildScrollView(
      child: Column(
        children: [
          for (final location in saveHotelList)
            LocationListItem(
              product : location,
              imageUrl: location.assetName,
              name: location.name,
              country: location.name,
            ),
        ],
      ),
    );
  }
}

class LocationListItem extends StatelessWidget {
  LocationListItem({
    Key key,
    @required this.product,
    @required this.imageUrl,
    @required this.name,
    @required this.country,
  }) : super(key: key);

  final Product product;
  final String imageUrl;
  final String name;
  final String country;
  final GlobalKey _backgroundImageKey = GlobalKey();




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child:
        InkWell(
          onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(product: product),
                ),
              ),
          child: Container(
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  _buildParallaxBackground(context),
                  _buildTitleAndSubtitle(),
                ],
              ),
            ),),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(
          product.assetName,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            country,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    this.scrollable,
    this.listItemContext,
    this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
    (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
      Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  Parallax({
    Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child;
    final backgroundImageConstraints =
    BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
    localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
    (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}
