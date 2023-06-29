import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/models/user_self_response.dart';
import 'package:kurdistan_food_network/utils/constants.dart';
import 'package:kurdistan_food_network/utils/http/http_client.dart';
import 'package:kurdistan_food_network/widgets/load_indicator.dart';
import 'package:kurdistan_food_network/widgets/nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserSelfResponse? selfResponse;

  @override
  void initState() {
    super.initState();
    getSelf();
  }

  Future<void> getSelf() async {
    final response = await HttpClient.get('/v1/self');

    if (response.isSuccessful) {
      selfResponse = UserSelfResponse.fromJson(response.body);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selfResponse == null) {
      return const Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [NavBar(currentScreen: 'Profile'), LoadIndicator()],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(currentScreen: 'Profile'),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  child: AspectRatio(
                    aspectRatio: 5.5,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(kPrimaryBorderRadiusValue),
                      child: Image.network(
                        selfResponse!.coverPicture ??
                            'https://storage.googleapis.com/kurdistan_food_network_user_images/a0d5d399-6b3f-46f4-83df-df6d8ab8504e',
                        alignment: FractionalOffset.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 150,
                      right: MediaQuery.of(context).size.width / 1.28,
                      top: 120),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(kPrimaryBorderRadiusValue),
                      child: Image.network(
                        selfResponse!.profilePicture ??
                            'https://storage.googleapis.com/kurdistan_food_network_user_images/c89ad2f2-b511-4a9c-9f50-7227d94132ca',
                        alignment: FractionalOffset.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5),
              child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${selfResponse!.firstName} ${selfResponse!.lastName}',
                      style: const TextStyle(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getRoles(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 80, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Identifier:',
                                style: TextStyle(
                                  color: kPrimaryTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: kPrimaryTextFontSize,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Email Address:',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: kPrimaryTextFontSize,
                                  ),
                                ),
                              ),
                              Text(
                                'Date Created:',
                                style: TextStyle(
                                  color: kPrimaryTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: kPrimaryTextFontSize,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Date Updated:',
                                  style: TextStyle(
                                    color: kPrimaryTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: kPrimaryTextFontSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selfResponse!.id,
                              style: const TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: kPrimaryTextFontSize,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                selfResponse!.email,
                                style: const TextStyle(
                                  color: kPrimaryTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: kPrimaryTextFontSize,
                                ),
                              ),
                            ),
                            Text(
                              selfResponse!.createdAt.toLocal().toString(),
                              style: const TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.normal,
                                fontSize: kPrimaryTextFontSize,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                selfResponse?.updatedAt?.toLocal().toString() ??
                                    'not updated yet',
                                style: const TextStyle(
                                  color: kPrimaryTextColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: kPrimaryTextFontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getRoles() {
    List<Widget> roles = List.empty(growable: true);

    for (var role in selfResponse!.roles) {
      role = role.replaceAll('_', ' ').toUpperCase();

      roles.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Chip(
          backgroundColor: kBackgroundColor,
          avatar: const Icon(
            Icons.account_box_outlined,
            color: kPrimaryColor,
          ),
          label: Text(
            role,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ));
    }

    return roles;
  }
}
