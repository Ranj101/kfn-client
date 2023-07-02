import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kurdistan_food_network/models/product_response.dart';
import 'package:kurdistan_food_network/utils/bag_items.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool loading = true;
  late ProductResponse product;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
  String _priceSelected = '';
  String addToBagError = '';

  Future<bool> getProductById() async {
    final response = await HttpClient.get('/v1/products/${widget.id}');

    if (response.isSuccessful) {
      product = ProductResponse.fromJson(response.body);

      loading = false;
      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getProductById();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(currentScreen: 'Product'),
              LoadIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Product'),
            Padding(
              padding: EdgeInsets.only(
                left: (MediaQuery.of(context).size.width / 6) + 10,
                bottom: 30,
                top: 80,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: kPrimaryTitleTextFontSize,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Text(
                                  'Producer: ',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  'Created: ',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              if (product.state == 'Available')
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'State: ',
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'State: ',
                                        style: TextStyle(
                                          color: kPrimaryTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Text(
                                  product.producerName,
                                  style: const TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  DateFormat.yMEd().format(product.createdAt),
                                  style: const TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              if (product.state == 'Available')
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.lock_open,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: product.state,
                                        style: const TextStyle(
                                          color: kPrimaryTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: product.state,
                                        style: const TextStyle(
                                          color: kPrimaryTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: kPrimaryBodyTextFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            addToBagError = '';

                            if (_priceSelected.isEmpty) {
                              setState(() {
                                addToBagError = 'selectPrice';
                              });
                            } else if (addProductToBag(
                                _priceSelected, product)) {
                              context.pop();
                            } else {
                              setState(() {
                                addToBagError = 'multipleProducer';
                              });
                            }
                          },
                          style: elevatedButtonStyle.copyWith(
                            minimumSize:
                                MaterialStateProperty.all(const Size(240, 80)),
                          ),
                          child: const Text(
                            'Add to bag',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: kPrimaryNavBarFontSize,
                            ),
                          ),
                        ),
                      ),
                      if (addToBagError == 'selectPrice')
                        Text(
                          'Please select a price',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(Colors.red.shade800.value),
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryBodyTextFontSize,
                          ),
                        ),
                      if (addToBagError == 'multipleProducer')
                        Text(
                          'Cannot add items from multiple producers',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(Colors.red.shade800.value),
                            fontWeight: FontWeight.normal,
                            fontSize: kPrimaryBodyTextFontSize,
                          ),
                        ),
                      SizedBox(
                        height: 460,
                        width: 450,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var priceByWeight = product.pricesByWeight[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => kPrimaryTextColor),
                                    value: priceByWeight.id,
                                    groupValue: _priceSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        _priceSelected = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${numberFormat.format(priceByWeight.value)} dinar',
                                    style: const TextStyle(
                                      color: kPrimaryTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    '${numberFormat.format(priceByWeight.weight)} kg',
                                    style: const TextStyle(
                                      color: kPrimaryTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: product.pricesByWeight.length,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: SizedBox(
                      width: 700,
                      child: AspectRatio(
                        aspectRatio: 1.4,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(kPrimaryBorderRadiusValue),
                          child: Image.network(
                            product.picture,
                            alignment: FractionalOffset.center,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
