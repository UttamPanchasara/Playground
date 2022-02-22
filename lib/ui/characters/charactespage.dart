import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:playground/base/view_state.dart';
import 'package:playground/common/constants.dart';
import 'package:playground/data/repo/entities/character_data.dart';
import 'package:playground/data/viewmodels/character_viewmodel.dart';
import 'package:playground/network/model/base_reponse.dart';
import 'package:playground/ui/characters/characterdetailspage.dart';
import 'package:provider/provider.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  CharacterViewModel? viewModel;
  static const int _pageSize = 20;

  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      viewModel?.getCharacters(pageNo: pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CharacterViewModel>(context);
    observeState();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Characters',
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Flexible(
                  child: PagedListView.separated(
                shrinkWrap: true,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Character>(
                  itemBuilder: (context, character, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CharacterDetailsPage(character: character),
                          ),
                        );
                      },
                      child: Container(
                        color: const Color(0xFFf3f6f9),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 70.h,
                                width: 70.h,
                                child: Image.network(character.image ?? ''),
                              ),
                              SizedBox(width: 16.w),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      character.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      character.gender ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, position) {
                  return SizedBox(height: 8.h);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void observeState() {
    if (viewModel != null) {
      Status? status = viewModel?.state.status;

      if (status == Status.completed) {
        // Append new data to list and notify
        try {
          BaseResponse? baseResponse = viewModel?.state.data;
          CharacterData? data = baseResponse?.data;

          List<Character> characterList = data?.characters?.results ?? [];
          final isLastPage = characterList.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(characterList);
          } else {
            _pagingController.appendPage(
                characterList, data?.characters?.info?.next);
          }
        } catch (error) {
          _pagingController.error = error;
        }
      } else if (status == Status.error) {
        _pagingController.error = PagingState(
            error: viewModel?.state.message ?? kSomethingWentWrongMessage,
            itemList: List.empty(),
            nextPageKey: 1);
      }
    }
  }

  @override
  void dispose() {
    viewModel?.dispose();
    super.dispose();
  }
}
