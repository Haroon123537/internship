import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenecesHelper {

  //To set string value in shared preferences

   void setStringInPreferences() async{
        SharedPreferences _prefs= await SharedPreferences.getInstance();

        await _prefs.setString('String', 'This is a string value').then(
       (value) =>print(value)
        );
   }

   void setIntInPreferences() async{
        SharedPreferences _prefs= await SharedPreferences.getInstance();

        await _prefs.setInt('Int', 1).then(
       (value) =>print(value)
        );
   }

   void setDoubleInPreferences() async{
        SharedPreferences _prefs= await SharedPreferences.getInstance();

        await _prefs.setDouble('Double', 1.5).then(
       (value) =>print(value)
        );
   }

    void setBoolInPreferences() async{
          SharedPreferences _prefs= await SharedPreferences.getInstance();
  
          await _prefs.setBool('Bool', true).then(
        (value) =>print(value)
          );
    }

    void setListInPreferences() async{
          SharedPreferences _prefs= await SharedPreferences.getInstance();
  
          await _prefs.setStringList('List', <String>['Flutter', 'Dart', 'Shared Preferences']).then(
        (value) =>print(value)
          );
    }

    //now we will get the values from shared preferences

    void getStringFromPreferences() async{
        SharedPreferences _prefs= await SharedPreferences.getInstance();

        String? Value= _prefs.getString('String');
        print(Value);

    }

    void getIntFromPreferences() async{
        SharedPreferences _prefs= await SharedPreferences.getInstance();

        int? IntValue= _prefs.getInt('Int');
        print(IntValue);
    }

    void getDoubleFromPreferences() async{
        SharedPreferences _prefs= await SharedPreferences.getInstance();

        double? DoubleValue= _prefs.getDouble('Double');
        print(DoubleValue);
    }

     void getBoolFromPreferences() async{
          SharedPreferences _prefs= await SharedPreferences.getInstance();
  
          bool? BoolValue= _prefs.getBool('Bool');
          print(BoolValue);
    }

     void getListFromPreferences() async{
          SharedPreferences _prefs= await SharedPreferences.getInstance();
  
          List<String>? ListValue= _prefs.getStringList('List');
          print(ListValue);
    }

    //To remove a value from shared perferences

    void removeData(String key) async{
      SharedPreferences _prefs= await SharedPreferences.getInstance();

      await _prefs.remove(key);
    }

}