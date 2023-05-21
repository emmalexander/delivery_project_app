import 'dart:async';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/models/user_model.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/services/location_services.dart';
import 'package:delivery_project_app/widgets/location_page_widgets/circle_back_button.dart';
import 'package:delivery_project_app/widgets/dragging_bar.dart';
import 'package:delivery_project_app/widgets/location_page_widgets/search_location_widget.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:delivery_project_app/widgets/location_page_widgets/use_location_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as google_places;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);
  static const id = 'location_page';
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  //String locationMessage = 'Current Location of the User';
  late TextEditingController _locationController;
  List<google_places.AutocompletePrediction> predictions = [];
  late google_places.FlutterGooglePlacesSdk googlePlaces;
  Timer? _debounce;
  google_places.FetchPlaceResponse? position;
  Placemark? place;

  //BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;

  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration(size: Size(100, 100)), 'assets/pin_source.png')
  //       .then((icon) {
  //     sourceIcon = icon;
  //   });
  // }

  final _scrollController = DraggableScrollableController();

  late LatLng sourceLocation;
  //late CameraPosition _initialPosition;
  late double lat = 7;
  //6.65459849624;
  late double long = 4;
  //3.37177410722;

  @override
  void initState() {
    _locationController = TextEditingController();
    //setCustomMarkerIcon();
    String apiKey = dotenv.env['API_KEY'] ?? 'API_KEY not found';
    googlePlaces = google_places.FlutterGooglePlacesSdk(apiKey);
    LocationServices.liveLocation(lat, long);
    sourceLocation = LatLng(lat, long);
    //destination = LatLng(lat + .002, long + .005);

    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlaces.findAutocompletePredictions(value);

    if (mounted) {
      // print('Place: ${result.predictions.first.fullText}');
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              //centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              //title: const Text('Address'),
              leading: CircleBackButton(onTap: () {
                Navigator.pop(context);
              }),
              actions: [
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => WillPopScope(
                              onWillPop: () async => false,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ));

                    if (position != null) {
                      //this is for the google places suggestions onClick
                      //print('Google Places: '
                      // '${state.userToken} ${position!.place!.latLng!.lat} ${position!.place!.latLng!.lng}, ${position!.place!.name.toString()}');
                      await context
                          .read<ApiServices>()
                          .updateLocation(
                              state.userToken,
                              position!.place!.latLng!.lat,
                              position!.place!.latLng!.lng,
                              position!.place!.name.toString())
                          .then((value) {
                        if (value is UserModel) {
                          context.read<UserBloc>().add(AddLocationEvent(
                              latitude: value.lat!,
                              longitude: value.long!,
                              address: value.address!));
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => CustomErrorDialog(
                                  title: 'Error',
                                  description: value.toString(),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }));
                        }
                      });
                    } else {
                      //this is for the google maps onClick selection
                      //send address and latitude and longitude to server
                      final address =
                          '${place!.street}, ${place!.subAdministrativeArea}, ${place!.locality}';
                      /* print('Maps Done Button: '
                          '${state.userToken} ${sourceLocation.latitude} ${sourceLocation.longitude}, $address');*/
                      ApiServices()
                          .updateLocation(
                              state.userToken,
                              sourceLocation.latitude,
                              sourceLocation.longitude,
                              address)
                          .then((value) {
                        if (value is UserModel) {
                          context.read<UserBloc>().add(AddLocationEvent(
                              latitude: value.lat!,
                              longitude: value.long!,
                              address: value.address!));
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => CustomErrorDialog(
                                  title: 'Error',
                                  description: value.toString(),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }));
                        }
                      }); // This sends the location info to the server
                    }

                    // sourceLocation = LatLng(
                    //     position!.place!.latLng!.lat, value.place!.latLng!.lng);
                    //
                    // print(
                    //     'Name: ${value.place!.name!.toString()}');
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(10.w),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.done),
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight / 1.235,
                    child: GoogleMap(
                      onTap: (positionTapped) async {
                        FocusScope.of(context).unfocus();
                        _scrollController.animateTo(
                          .2, // The position you want to scroll to
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        setState(() {
                          sourceLocation = LatLng(positionTapped.latitude,
                              positionTapped.longitude);
                          mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(sourceLocation, 16));
                        });
                        await placemarkFromCoordinates(positionTapped.latitude,
                                positionTapped.longitude)
                            .then((List<Placemark> placemarks) {
                          place = placemarks[0];

                          // print(
                          //     '${place!.street}, ${place!.subAdministrativeArea}, ${place!.locality}');
                        }).catchError((e) {
                          debugPrint(e);
                        });
                      },
                      indoorViewEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition:
                          CameraPosition(target: sourceLocation, zoom: 16),
                      markers: {
                        Marker(
                          markerId: const MarkerId('source'),
                          //icon: sourceIcon,
                          position: sourceLocation,
                        ),
                      },
                    ),
                  );
                }),
                DraggableScrollableSheet(
                  initialChildSize: 0.2,
                  minChildSize: 0.2,
                  maxChildSize: 0.85,
                  snapSizes: const [0.2, 0.85],
                  snap: true,
                  controller: _scrollController,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              topLeft: Radius.circular(10.r)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              DraggingBar(onTap: () {
                                _scrollController.animateTo(
                                  .85, // The position you want to scroll to
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }),
                              SizedBox(height: 10.h),
                              SearchLocationWidget(
                                onTap: () {
                                  _scrollController.animateTo(
                                    .85, // The position you want to scroll to
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                locationController: _locationController,
                                suffixIcon: _locationController.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            predictions.clear();
                                            _locationController.clear();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.clear_outlined,
                                          color: Colors.grey,
                                        ))
                                    : null,
                                onChanged: (val) {
                                  if (_debounce?.isActive ?? false) {
                                    _debounce!.cancel();
                                  }
                                  _debounce = Timer(
                                      const Duration(milliseconds: 1000), () {
                                    if (val.isNotEmpty) {
                                      //call places api
                                      autoCompleteSearch(val);
                                    } else {
                                      //clear out search result
                                      setState(() {
                                        predictions.clear();
                                        position = null;
                                      });
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: 20.h),
                              UseLocationButton(onTap: () async {
                                FocusScope.of(context).unfocus();
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => WillPopScope(
                                          onWillPop: () async => false,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ));
                                Position userLocation =
                                    await LocationServices.getCurrentLocation(
                                            context)
                                        .then((value) {
                                  setState(() {
                                    lat = value.latitude;
                                    long = value.longitude;
                                    sourceLocation = LatLng(lat, long);
                                    mapController.animateCamera(
                                        CameraUpdate.newLatLngZoom(
                                            LatLng(value.latitude,
                                                value.longitude),
                                            16));

                                    //Navigator.pop(context);
                                  });
                                  return value;
                                });

                                await placemarkFromCoordinates(
                                        userLocation.latitude,
                                        userLocation.longitude)
                                    .then((List<Placemark> placemarks) {
                                  place = placemarks[0];

                                  // print(
                                  //     '${place!.street}, ${place!.subAdministrativeArea}, ${place!.locality}');
                                }).catchError((e) {
                                  debugPrint(e);
                                });
                                //send address and latitude and longitude to server
                                final address =
                                    '${place!.street}, ${place!.subAdministrativeArea}, ${place!.locality}';
                                ApiServices()
                                    .updateLocation(
                                        state.userToken, lat, long, address)
                                    .then((value) {
                                  if (value is UserModel) {
                                    context.read<UserBloc>().add(
                                        AddLocationEvent(
                                            latitude: value.lat!,
                                            longitude: value.long!,
                                            address: value.address!));
                                    Navigator.pushReplacementNamed(
                                        context, HomePage.id);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => CustomErrorDialog(
                                            title: 'Error',
                                            description: value.toString(),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }));
                                  }
                                });
                              }),
                              SizedBox(height: 10.h),
                              ListView.builder(
                                  shrinkWrap: true,
                                  //physics: const ClampingScrollPhysics(),
                                  //controller: scrollController,
                                  itemCount: predictions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        final placeId =
                                            predictions[index].placeId;
                                        await googlePlaces
                                            .fetchPlace(placeId, fields: [
                                          google_places.PlaceField.Location,
                                          google_places.PlaceField.Name,
                                        ]).then((value) {
                                          if (value.place != null && mounted) {
                                            setState(() {
                                              position =
                                                  value; // This position object holds the address and latLng
                                              _locationController.clear();
                                              /*print(
                                                  'Name: ${value.place!.name!.toString()}');*/
                                              _scrollController.animateTo(
                                                .2, // The position you want to scroll to
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                              sourceLocation = LatLng(
                                                  value.place!.latLng!.lat,
                                                  value.place!.latLng!.lng);
                                              mapController.animateCamera(
                                                  CameraUpdate.newLatLngZoom(
                                                      LatLng(
                                                          value.place!.latLng!
                                                              .lat,
                                                          value.place!.latLng!
                                                              .lng),
                                                      16));
                                              //send address and latitude and longitude to server

                                              predictions.clear();
                                            });
                                          }
                                          /*if (position != null) {

                                      }*/
                                        });
                                      },
                                      leading: const Icon(Icons.location_on),
                                      title: Text(predictions[index]
                                          .primaryText
                                          .toString()),
                                      subtitle: Text(
                                        predictions[index].fullText.toString(),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
