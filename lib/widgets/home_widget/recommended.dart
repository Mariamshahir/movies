import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/toprated_response.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/loddingapp.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.loadtopratedlist(),
        builder: (context,snapshat){
          if(snapshat.hasError){
            return AppError(error: "Something wrong please again later");
          }else if(snapshat.hasData){
            return Text("Done",style: TextStyle(color: Colors.white),);
          }else{
            return LoaddingApp();
          }
        });
  }
  Widget recommendedList(List<Result> results) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return recommended(context, results[index]);
        },
      ),
    );
  }

  Widget recommended(BuildContext context, Result result) {
    return Container(
      child: Column(
        children: [
          Text("Recomended",style: AppTheme.title,),
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${result.posterPath ?? ''}',
            height: MediaQuery.of(context).size.height * 0.25,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
            errorWidget: (_, __, ___) => const Icon(
              Icons.image_not_supported_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
