import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImageAssetPath("images/onboarding/book appointment.png");
  sliderModel.setTitle("Book Appointments");
  sliderModel.setDesc("Book appointment with Listeners, Counsellors and mentors in few clicks.");

  slides.add(sliderModel);
  sliderModel = new SliderModel();
//2
  sliderModel.setImageAssetPath("images/onboarding/news and feed.png");
  sliderModel.setTitle("News & Feed");
  sliderModel.setDesc("Always be up to date with the events conducted by vCare");
  slides.add(sliderModel);
  sliderModel = new SliderModel();
//3
  sliderModel.setImageAssetPath("images/onboarding/task and fun.png");
  sliderModel.setTitle("Task & Fun");
  sliderModel.setDesc("Participate in task given by vCare and get rewarded");
  slides.add(sliderModel);
  sliderModel = new SliderModel();
//4
  sliderModel.setImageAssetPath("images/onboarding/cryptovonboard.png");
  sliderModel.setTitle("CryptoV Coins");
  sliderModel.setDesc("Introducing CryptoV coins. Receive CryptoV coins after completing each task");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

//5
  sliderModel.setImageAssetPath("images/onboarding/rewards.png");
  sliderModel.setTitle("Rewards");
  sliderModel.setDesc("Complete the target of CryptoV and get many rewards each week");
  slides.add(sliderModel);
  sliderModel = new SliderModel();


  return slides;
}