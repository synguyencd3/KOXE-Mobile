import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/post_model.dart';
import '../../services/post_service.dart';
import 'package:mobile/pages/loading.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  PostModel post = PostModel(text: 'abc');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      //print('postid' + postId);
      getDetailPost();
    });
  }
  Future<void> getDetailPost() async {
    String postId = ModalRoute.of(context)!.settings.arguments as String;
    PostModel postAPI = await PostService.getPostDetail(postId);
      post = postAPI;
    //print('cc${post.postId}' ?? '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Detail'),
        ),
        body: FutureBuilder(
          future: getDetailPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return Column(
              children: [
                post.image!.isNotEmpty ? CarouselSlider.builder(
                  itemCount: post.image?.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Image.network(post.image![index]);
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                ):Container(),
                Text(post.text ?? ''),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post.user?.avatar ?? ''),
                  ),
                  title: Text(post.user?.fullname ?? ''),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(post.createAt.toString()),
                ),
                ListTile(
                  leading: Icon(Icons.location_pin),
                  title: Text(post.address ?? ''),
                ),
              ],

            );
          }
        ),
        floatingActionButton: Row(
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context,  '/connection');
                },
                child: Text('Kết nối'),
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {},
                child: Text('Nhắn tin'),
              ),
            ),
          ],
        ));
  }
}
