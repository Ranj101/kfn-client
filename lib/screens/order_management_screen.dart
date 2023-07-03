import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/models/order_list_response.dart';
import 'package:kurdistan_food_network/models/paginated_response.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/drop_down_button.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';
import 'package:kurdistan_food_network/widgets/order_card.dart';
import 'package:kurdistan_food_network/widgets/product_card.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key, required this.id});

  final String id;

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  bool loading = true;
  int orderTotalPages = 0;
  int orderCurrentPage = 1;

  List<OrderListResponse> orders = [];

  final List<String> SortProductBy = [
    'DateCreated',
    'TotalPrice',
  ];

  final List<String> SortDirection = [
    'Descending',
    'Ascending',
  ];

  String? orderSortBySelectedValue;
  String? orderSortDirectionValue;

  Future<bool> getOrders() async {
    if (orderTotalPages != 0 && orderCurrentPage > orderTotalPages) {
      return false;
    }

    var query =
        'PageIndex=$orderCurrentPage&PageSize=8&SortBy=${orderSortBySelectedValue ?? 'DateCreated'}&SortDirection=${orderSortDirectionValue ?? 'Descending'}&FilterByProducerId=${widget.id}';

    final response = await HttpClient.get('/v1/orders?$query');

    if (response.isSuccessful) {
      var paginatedResponse = PaginatedResponse.fromJson(response.body);

      orders = OrderListResponse.fromJsonList(paginatedResponse.data);

      loading = false;
      orderTotalPages = paginatedResponse.totalPages;

      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(currentScreen: 'order-management'),
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
            const NavBar(currentScreen: 'order-management'),
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
                    'Page $orderCurrentPage/$orderTotalPages',
                    style: const TextStyle(
                      fontSize: kPrimaryBodyTextFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: kPrimaryTextColor,
                    ),
                  ),
                  SizedBox(width: 20),
                  DropDownButton(
                    items: SortProductBy,
                    hint: 'Sort By',
                    GetSelectedValue: () => orderSortBySelectedValue,
                    SetSelectedValue: (selectedValue) {
                      orderSortBySelectedValue = selectedValue;
                      getOrders();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropDownButton(
                      items: SortDirection,
                      hint: 'Sort Direction',
                      iconData: Icons.sort,
                      GetSelectedValue: () => orderSortDirectionValue,
                      SetSelectedValue: (selectedValue) {
                        orderSortDirectionValue = selectedValue;
                        getOrders();
                      },
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (orderCurrentPage > 1) {
                          orderCurrentPage--;
                          await getOrders();
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
                        if (orderCurrentPage < orderTotalPages) {
                          orderCurrentPage++;
                          await getOrders();
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
                crossAxisCount: 1,
                childAspectRatio: 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final order = orders[index];

                return OrderCard(
                  id: order.id,
                  location: order.location,
                  state: order.state,
                  totalPrice: order.totalPrice,
                  producerId: widget.id,
                );
              },
              itemCount: orders.length,
              shrinkWrap: true,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
