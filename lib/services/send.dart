import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';

class SendImage {
  final File? file;
  const SendImage({this.file});

  treatArchive(File? file){
    if (file!= null) {
      String archiveString = "$file";
      String aux= "";
      print(archiveString);
      for(int i = 0; i < archiveString.length - 1; i++) {
        if(i>6){
          String a = archiveString[i];
          aux += ""+a;
          
        }
        
      }
      archiveString =aux;
      return archiveString;
    }

  }
  
  Future<void> sendImage() async {
    print("neymar");
    var f = file;
    var url = Uri.parse('https://0941-34-124-167-162.ngrok-free.app/predict');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', treatArchive(file)));
    var token;
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${token}'
    });
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
  }

}