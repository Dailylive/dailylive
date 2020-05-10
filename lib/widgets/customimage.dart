import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget cachedNetworkImage(String mediaUrl) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CachedNetworkImage(
      fit: BoxFit.fill,
      colorBlendMode: BlendMode.darken,
      imageUrl: mediaUrl,
      placeholder: (context, url) => circularProgress(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
  );
}


CarouselSlider  showImages(List<String> medialUrls){

  return CarouselSlider(
        options:CarouselOptions(
          height: 200,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 200),
          autoPlayCurve: Curves.elasticInOut,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ) ,
    items: medialUrls.map((item){
      return cachedNetworkImage(item);

    }).toList(),
  );

}


