class ReciepeModel{
  late String applabel;
  late String appimageurl;
  late double appcalories;
  late String appurl;

  ReciepeModel({this.applabel = "LABEL",this.appcalories = 0.000 ,this.appimageurl = "IMAGE",this.appurl = "URL"});
  factory ReciepeModel.fromMap(Map reciepe){
    return ReciepeModel(
        applabel: reciepe["label"],
        appcalories: reciepe["calories"],
        appimageurl: reciepe["image"],
        appurl: reciepe["url"]
    );
  }
}