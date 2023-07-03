import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurdistan_food_network/models/paginated_response.dart';
import 'package:kurdistan_food_network/models/producer_page_response.dart';
import 'package:kurdistan_food_network/models/product_list_response.dart';
import 'package:kurdistan_food_network/models/user_self_response.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/drop_down_button.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';
import 'package:kurdistan_food_network/widgets/product_card.dart';

class ProducerScreen extends StatefulWidget {
  const ProducerScreen({super.key});

  @override
  State<ProducerScreen> createState() => _ProducerScreenState();
}

class _ProducerScreenState extends State<ProducerScreen> {
  final TextEditingController _controllerProductName = TextEditingController();
  final CarouselController _controller = CarouselController();

  int _currentImage = 0;
  bool loading = true;
  List<String> imgList = [];

  int productTotalPages = 0;
  int productCurrentPage = 1;

  List<ProductListResponse> products = [];
  late ProducerPageResponse producerPage;
  late String? producerId;

  final List<String> SortProductBy = [
    'DateCreated',
  ];

  final List<String> SortDirection = [
    'Descending',
    'Ascending',
  ];

  String? productSortBySelectedValue;
  String? productSortDirectionValue;

  Future<bool> getSelfProducerPage() async {
    final slefResponse = await HttpClient.get('/v1/self');

    if (slefResponse.isSuccessful) {
      var selfResponse = UserSelfResponse.fromJson(slefResponse.body);

      producerId = selfResponse.producerId;

      await getProducts(selfResponse.producerId!);

      final response = await HttpClient.get(
          '/v1/producers/pages/${selfResponse.producerId}');

      if (response.isSuccessful) {
        producerPage = ProducerPageResponse.fromJson(response.body);

        imgList = producerPage.gallery;

        loading = false;
        setState(() {});

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> getProducts(String id) async {
    if (productTotalPages != 0 && productCurrentPage > productTotalPages) {
      return false;
    }

    var query =
        'PageIndex=$productCurrentPage&PageSize=8&SortBy=${productSortBySelectedValue ?? 'DateCreated'}&SortDirection=${productSortDirectionValue ?? 'Descending'}&FilterByProducer=$id';

    var productName = _controllerProductName.text;

    if (productName.isNotEmpty) {
      query = '$query&FilterByName=$productName';
    }

    final response = await HttpClient.get('/v1/products?$query');

    if (response.isSuccessful) {
      var paginatedResponse = PaginatedResponse.fromJson(response.body);

      products = ProductListResponse.fromJsonList(paginatedResponse.data);

      productTotalPages = paginatedResponse.totalPages;

      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getSelfProducerPage();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(currentScreen: 'Producer'), LoadIndicator()],
          ),
        ),
      );
    }

    final List<Widget> imageSliders = imgList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: kPrimaryBorderRadius,
                child: Image.network(
                  item,
                  alignment: FractionalOffset.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Producer'),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width / 6) + 10,
                  right: MediaQuery.of(context).size.width / 6,
                  bottom: 30,
                  top: 80,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          producerPage.name,
                          style: const TextStyle(
                            color: kPrimaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: kPrimaryTitleTextFontSize,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Locations',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPrimaryLargeBodyTextFontSize,
                                  ),
                                ),
                                SizedBox(
                                  width: 280,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                                  child: Icon(
                                                      Icons.place_outlined),
                                                ),
                                              ),
                                              TextSpan(
                                                text: producerPage
                                                    .locations[index],
                                                style: const TextStyle(
                                                  color: kPrimaryTextColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: producerPage.locations.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8),
                                const Text(
                                  'Opening Time',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPrimaryBodyTextFontSize,
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Divider(
                                    height: 0,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Icon(Icons.access_time),
                                        ),
                                      ),
                                      TextSpan(
                                        text: producerPage.openingTime
                                            .format(context),
                                        style: const TextStyle(
                                          color: kPrimaryTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () {
                                    context.goNamed(RouteConstants.manageOrders,
                                        pathParameters: {'id': '$producerId'});
                                  },
                                  style: elevatedButtonStyle.copyWith(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(120, 60)),
                                  ),
                                  child: const Text(
                                    'Manage Orders',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: kPrimaryNavBarFontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8),
                                const Text(
                                  'Closing Time',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: kPrimaryBodyTextFontSize,
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Divider(
                                    height: 0,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Icon(Icons.access_time),
                                        ),
                                      ),
                                      TextSpan(
                                        text: producerPage.closingTime
                                            .format(context),
                                        style: const TextStyle(
                                          color: kPrimaryTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: elevatedButtonStyle.copyWith(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(120, 60)),
                                  ),
                                  child: const Text(
                                    'Add Product',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: kPrimaryNavBarFontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: CarouselSlider(
                              carouselController: _controller,
                              options: CarouselOptions(
                                height: 400,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 4),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentImage = index;
                                  });
                                },
                              ),
                              items: imageSliders,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(
                                                _currentImage == entry.key
                                                    ? 0.9
                                                    : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(
                left: (MediaQuery.of(context).size.width / 6) + 10,
                right: MediaQuery.of(context).size.width / 6,
                bottom: 30,
              ),
              child: Row(
                children: [
                  Text(
                    'Page $productCurrentPage/$productTotalPages',
                    style: const TextStyle(
                      fontSize: kPrimaryBodyTextFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: kPrimaryTextColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 16,
                          color: kPrimaryTextColor,
                        ),
                        onChanged: (value) {
                          getProducts(producerId!);
                        },
                        controller: _controllerProductName,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  DropDownButton(
                    items: SortProductBy,
                    hint: 'Sort By',
                    GetSelectedValue: () => productSortBySelectedValue,
                    SetSelectedValue: (selectedValue) {
                      productSortBySelectedValue = selectedValue;
                      getProducts(producerId!);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropDownButton(
                      items: SortDirection,
                      hint: 'Sort Direction',
                      iconData: Icons.sort,
                      GetSelectedValue: () => productSortDirectionValue,
                      SetSelectedValue: (selectedValue) {
                        productSortDirectionValue = selectedValue;
                        getProducts(producerId!);
                      },
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (productCurrentPage > 1) {
                          productCurrentPage--;
                          await getProducts(producerId!);
                        }
                      },
                      style: arrowButtonStyle,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: kPrimaryTextColor,
                        size: 20,
                      ),
                      label: const Text(
                        'Pervious',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (productCurrentPage < productTotalPages) {
                          productCurrentPage++;
                          await getProducts(producerId!);
                        }
                      },
                      style: arrowButtonStyle,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: kPrimaryTextColor,
                        size: 20,
                      ),
                      label: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  id: product.id,
                  name: product.name,
                  state: product.state,
                  picture: product.picture,
                  producerName: product.producerName,
                  pricesByWeight: product.pricesByWeight,
                );
              },
              itemCount: products.length,
              shrinkWrap: true,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
