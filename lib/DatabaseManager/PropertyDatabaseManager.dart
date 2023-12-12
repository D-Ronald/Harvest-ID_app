import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyDatabaseManager {
  final CollectionReference<Map<String, dynamic>> propertyList =
      FirebaseFirestore.instance.collection('properties');
      
        String? get uid => null;
      

  Future<void> createPropertyData(
    String _propertyName,
    String _propertySize,
    String _address,
    String _selectedCountry,
    String _selectedState,
    String _selectedCity,
    bool isChecked,
  ) async {
    try {
      
      await propertyList.doc(uid).set({
        'Property name': _propertyName,
        'Property Size': _propertySize,
        'Address': _address,
        'Country': _selectedCountry,
        'State': _selectedState,
        'City': _selectedCity,
        'Tomato': isChecked,
        
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}

void main() async {
  String propertyName = 'Nome da Propriedade';
  String propertySize = 'Tamanho';
  String address = 'Endereço';
  String selectedCountry = 'País';
  String selectedState = 'Estado';
  String selectedCity = 'Cidade';
  bool isChecked = true;

  PropertyDatabaseManager manager = PropertyDatabaseManager();

  await manager.createPropertyData(
    propertyName,
    propertySize,
    address,
    selectedCountry,
    selectedState,
    selectedCity,
    isChecked,
    
  );
}

