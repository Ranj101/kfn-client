import 'dart:convert';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kurdistan_food_network/models/producer_page_response.dart';
import 'package:kurdistan_food_network/models/requests/submit_bag_product.dart';
import 'package:kurdistan_food_network/models/requests/submit_order.dart';
import 'package:kurdistan_food_network/routes/route_constants.dart';
import 'package:kurdistan_food_network/utils/bag_items.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/utils/styles.dart';
import 'package:kurdistan_food_network/widgets/bag_product_card.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class ShoppingBagScreen extends StatefulWidget {
  const ShoppingBagScreen({super.key});

  @override
  State<ShoppingBagScreen> createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? selectedLocationValue;
  bool loading = true;
  ProducerPageResponse? producerPage;
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerTime = TextEditingController();

  late DateTime _dateUnformatted;
  late Time _timeUnformatted;

  final Time _time = Time(hour: 11, minute: 30, second: 20);

  String? _orderErrorResult;

  Future<bool> getProducerPageById() async {
    if (bagItems.isEmpty) {
      loading = false;
      return true;
    }

    final response = await HttpClient.get(
        '/v1/producers/pages/${bagItems.first.product.producerId}');

    if (response.isSuccessful) {
      producerPage = ProducerPageResponse.fromJson(response.body);

      loading = false;
      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  void removeFromBag(String id) {
    removeProductFromBag(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controllerDate.text = '';
    getProducerPageById();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(currentScreen: 'ShoppingBag'),
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
            const NavBar(currentScreen: 'ShoppingBag'),
            const SizedBox(height: 50),
            const Text(
              'Order Information',
              style: TextStyle(
                fontSize: kPrimaryTitleTextFontSize,
                fontWeight: FontWeight.w900,
                height: 1.2,
                color: kPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        barrierColor: kDropdownColor,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 18,
                              color: kPrimaryTextColor,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                'Select a location',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kPrimaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        items: producerPage != null
                            ? producerPage!.locations
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: kPrimaryTextColor,
                                        ),
                                      ),
                                    ))
                                .toList()
                            : [],
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a location.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          selectedLocationValue = value.toString();
                        },
                        onSaved: (value) {
                          selectedLocationValue = value.toString();
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 70,
                          width: 300,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: kDropdownColor),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: kBackgroundColor,
                          ),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: 220,
                        child: TextFormField(
                          readOnly: true,
                          controller: _controllerDate,
                          style: const TextStyle(height: 2.1),
                          decoration: InputDecoration(
                            labelText: 'Choose pickup date',
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              _dateUnformatted = pickedDate;
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                _controllerDate.text = formattedDate;
                              });
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please choose a date.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: TextFormField(
                        readOnly: true,
                        controller: _controllerTime,
                        style: const TextStyle(height: 2.1),
                        decoration: InputDecoration(
                          labelText: 'Choose pickup time',
                          prefixIcon: const Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () async {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: _time,
                              sunrise: const TimeOfDay(hour: 6, minute: 0),
                              sunset: const TimeOfDay(hour: 19, minute: 0),
                              duskSpanInMinutes: 120,
                              onChange: (newTime) {
                                _timeUnformatted = newTime;
                                setState(() {
                                  _controllerTime.text =
                                      newTime.format(context);
                                });
                              },
                            ),
                          );
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose a date.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 40),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _orderErrorResult = null;
                          });

                          if (bagItems.isEmpty || producerPage == null) {
                            setState(() {
                              _orderErrorResult =
                                  'Cannot place an order with no items chosen.';
                            });
                          }

                          final response = await HttpClient.post('/v1/orders',
                              body: jsonEncode(SubmitOrder(
                                      producerId: producerPage!.id,
                                      location: selectedLocationValue!,
                                      pickupTime: DateTime(
                                              _dateUnformatted.year,
                                              _dateUnformatted.month,
                                              _dateUnformatted.day,
                                              _timeUnformatted.hour,
                                              _timeUnformatted.minute)
                                          .toUtc(),
                                      products: bagItems
                                          .map(
                                            (e) => SubmitBagProduct(
                                                productId: e.product.id,
                                                priceByWeightId: e.priceId),
                                          )
                                          .toList())
                                  .toJson()));

                          if (!response.isSuccessful) {
                            setState(() {
                              _orderErrorResult =
                                  'A unknown error has occured.';
                            });
                          }

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              width: 300,
                              backgroundColor: kPrimaryTextColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: const Center(
                                  child: Text("Order placed successfully")),
                            ),
                          );
                          _formKey.currentState?.reset();
                          bagItems = [];
                          context.goNamed(RouteConstants.shop);
                        }
                      },
                      style: elevatedButtonStyle.copyWith(
                        minimumSize:
                            MaterialStateProperty.all(const Size(120, 80)),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: kPrimaryNavBarFontSize,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    if (_orderErrorResult != null)
                      SizedBox(
                        width: 120,
                        child: Text(
                          _orderErrorResult!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(Colors.red.shade800.value),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            if (bagItems.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'No items added to bag yet.',
                  style: TextStyle(
                    fontSize: kPrimaryLargeBodyTextFontSize,
                    fontWeight: FontWeight.normal,
                    height: 1.2,
                    color: kPrimaryTextColor,
                  ),
                ),
              )
            else
              GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 6),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.60,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final bagItem = bagItems[index];
                  final product = bagItem.product;

                  return BagProductCard(
                    id: product.id,
                    name: product.name,
                    state: product.state,
                    picture: product.picture,
                    producerName: product.producerName,
                    priceByWeight: product.pricesByWeight
                        .firstWhere((element) => element.id == bagItem.priceId),
                    removeFromBag: removeFromBag,
                  );
                },
                itemCount: bagItems.length,
                shrinkWrap: true,
              )
          ],
        ),
      ),
    );
  }
}
