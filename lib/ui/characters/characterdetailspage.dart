import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playground/data/repo/entities/character_data.dart';

class CharacterDetailsPage extends StatefulWidget {
  final Character character;

  const CharacterDetailsPage({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  _CharacterDetailsPageState createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  Character? characterDetail;

  @override
  void initState() {
    super.initState();
    characterDetail = widget.character;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          characterDetail?.name ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18.sp),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black38,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  characterDetail?.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),
              info('Gender', characterDetail?.gender ?? ''),
              SizedBox(height: 8.h),
              info('Status', characterDetail?.status ?? ''),
              SizedBox(height: 8.h),
              info('Species', characterDetail?.species ?? ''),
              SizedBox(height: 8.h),
              info('Location', characterDetail?.location?.name ?? ''),
              SizedBox(height: 8.h),
              info('Origin', characterDetail?.origin?.name ?? ''),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget info(String label, String value) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
