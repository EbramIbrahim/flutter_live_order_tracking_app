import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: "AIzaSyBtrc2ZHrEVvwYahtlzv6xxBsNvHLdvDpY",
      onPlacePicked: (LocationResult result) {
        debugPrint("Place picked: ${result.formattedAddress}");
        context.pop(result.latLng);
      },
      initialLocation: const LatLng(29.378586, 47.990341),
      searchInputConfig: const SearchInputConfig(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        autofocus: false,
        textDirection: TextDirection.ltr,
      ),
      searchInputDecorationConfig: const SearchInputDecorationConfig(
        hintText: "Search for a building, street or ...",
      ),
    );
  }
}
