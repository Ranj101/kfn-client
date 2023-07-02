import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/models/paginated_response.dart';
import 'package:kurdistan_food_network/models/producer_page_list_response.dart';
import 'package:kurdistan_food_network/models/product_list_response.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/drop_down_button.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';
import 'package:kurdistan_food_network/widgets/producer_card.dart';
import 'package:kurdistan_food_network/widgets/product_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _controllerProductName = TextEditingController();

  bool loading = true;

  int producerTotalPages = 0;
  int producerCurrentPage = 1;

  int productTotalPages = 0;
  int productCurrentPage = 1;

  List<ProducerPageListResponse> producerPages = [];
  List<ProductListResponse> products = [];

  final List<String> SortProducerBy = [
    'DateCreated',
    'OpeningTime',
    'ClosingTime',
  ];

  final List<String> SortProductBy = [
    'DateCreated',
  ];

  final List<String> SortDirection = [
    'Descending',
    'Ascending',
  ];

  String? producerSortBySelectedValue;
  String? producerSortDirectionValue;

  String? productSortBySelectedValue;
  String? productSortDirectionValue;

  Future<bool> getProducerPages() async {
    if (producerTotalPages != 0 && producerCurrentPage > producerTotalPages) {
      return false;
    }

    final response = await HttpClient.get(
        '/v1/producers/pages?PageIndex=$producerCurrentPage&PageSize=9&SortBy=${producerSortBySelectedValue ?? 'DateCreated'}&SortDirection=${producerSortDirectionValue ?? 'Descending'}');

    if (response.isSuccessful) {
      var paginatedResponse = PaginatedResponse.fromJson(response.body);

      producerPages =
          ProducerPageListResponse.fromJsonList(paginatedResponse.data);

      loading = false;
      producerTotalPages = paginatedResponse.totalPages;

      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  Future<bool> getProducts() async {
    if (productTotalPages != 0 && productCurrentPage > productTotalPages) {
      return false;
    }

    var query =
        'PageIndex=$productCurrentPage&PageSize=8&SortBy=${productSortBySelectedValue ?? 'DateCreated'}&SortDirection=${productSortDirectionValue ?? 'Descending'}';

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
    getProducerPages();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(currentScreen: 'Shop'), LoadIndicator()],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Shop'),
            const SizedBox(height: 50),
            const Text(
              'Our local producers',
              style: TextStyle(
                fontSize: kPrimaryTitleTextFontSize,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: kPrimaryTextColor,
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
                    'Page $producerCurrentPage/$producerTotalPages',
                    style: const TextStyle(
                      fontSize: kPrimaryBodyTextFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: kPrimaryTextColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  DropDownButton(
                    items: SortProducerBy,
                    hint: 'Sort By',
                    GetSelectedValue: () => producerSortBySelectedValue,
                    SetSelectedValue: (selectedValue) {
                      producerSortBySelectedValue = selectedValue;
                      getProducerPages();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropDownButton(
                      items: SortDirection,
                      hint: 'Sort Direction',
                      iconData: Icons.sort,
                      GetSelectedValue: () => producerSortDirectionValue,
                      SetSelectedValue: (selectedValue) {
                        producerSortDirectionValue = selectedValue;
                        getProducerPages();
                      },
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (producerCurrentPage > 1) {
                          producerCurrentPage--;
                          await getProducerPages();
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
                        if (producerCurrentPage < producerTotalPages) {
                          producerCurrentPage++;
                          await getProducerPages();
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
                crossAxisCount: 3,
                childAspectRatio: 2.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final producerPage = producerPages[index];

                return ProducerCard(
                  id: producerPage.id,
                  name: producerPage.name,
                  locations: producerPage.locations,
                  openingTime: producerPage.openingTime,
                  closingTime: producerPage.closingTime,
                );
              },
              itemCount: producerPages.length,
              shrinkWrap: true,
            ),
            const SizedBox(height: 135),
            // Producets Section ===================================================================
            const Text(
              'All products',
              style: TextStyle(
                fontSize: kPrimaryTitleTextFontSize,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: kPrimaryTextColor,
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
                          getProducts();
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
                      getProducts();
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
                        getProducts();
                      },
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (productCurrentPage > 1) {
                          productCurrentPage--;
                          await getProducts();
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
                          await getProducts();
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
