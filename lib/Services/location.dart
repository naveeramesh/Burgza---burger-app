import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

String finalAddress = 'Searching Address';

class GenerateMaps extends ChangeNotifier {
  Position position;

  String countryName, mainAddress = 'Mock Address';
  Position get getPosition => position;
  String get getCountryName => countryName;
  String get getmainAddress => mainAddress;
  GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future getCurrentLocation() async {
    var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final cords =
        geoCo.Coordinates(positionData.latitude, positionData.latitude);
    var address =
        await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
    mainAddress = address.first.addressLine;
    print(mainAddress);
    finalAddress = mainAddress;
    notifyListeners();
  }

  getMarkers(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: 'MY TITLE', snippet: 'Country name'),
    );
    markers[markerId] = marker;
  }

  Widget fetchMaps() {
    return GoogleMap(
      mapType: MapType.hybrid,
      myLocationEnabled: true,
      mapToolbarEnabled: true,
      onTap: (loc) async {
        final cords = geoCo.Coordinates(loc.latitude, loc.longitude);
        var address =
            await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
        countryName = address.first.countryName;

        mainAddress = address.first.addressLine;
        notifyListeners();
        getMarkers(loc.latitude, loc.latitude);
        print(loc);
        print(countryName);
        print(mainAddress);
      },
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController mapController) {
        _googleMapController = mapController;
        notifyListeners();
      },
      initialCameraPosition:
          CameraPosition(target: LatLng(21.000, 21.000), zoom: 18.0),
    );
  }
}
