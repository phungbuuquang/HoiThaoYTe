import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcademy/models/seminar/seminar_response.dart';
import 'package:xcademy/resources/app_textstyle.dart';
import 'package:xcademy/resources/assets_constant.dart';
import 'package:xcademy/resources/color_constant.dart';
import 'package:xcademy/routes/router_manager.dart';
import 'package:xcademy/screens/home/bloc/home_bloc.dart';
import 'package:xcademy/screens/profile/bloc/profile_bloc.dart';
import 'package:xcademy/services/data_pref/date_prefs.dart';
import 'package:xcademy/services/di/di.dart';
import 'package:xcademy/utils/common_utils.dart';
import 'package:xcademy/utils/date_utils.dart';
import 'package:xcademy/widgets/my_cache_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc get _bloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.getNameUser();
      _bloc.getListSeminar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildNavbarView(),
            Expanded(
              child: Container(
                color: ColorConstant.grayf5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      _buildMyTutorialView(),
                      _buildTutorialView('Khoá học Online'),
                      SizedBox(
                        height: 20,
                      ),
                      _buildTutorialView('Khoá học Offline'),
                      SizedBox(
                        height: 20,
                      ),
                      _buildTutorialView('Khoá học Phổ biến'),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyTutorialView() {
    final userId = injector.get<DataPrefs>().getUserId();
    return userId == ''
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khoá học của bạn',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (_, state) {
                    bool isLoading = false;
                    List<SeminarModel> listItems = [];
                    if (state is HomeLoadingState) {
                      isLoading = true;
                    } else if (state is HomeGetSeminarsDoneState) {
                      listItems = state.listSeminars;
                    }
                    return SizedBox(
                      height: 150,
                      child: _buildListTutorialView(
                        listItems,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
  }

  Widget _buildTutorialView(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            child: _buildListTutorialView(
              [],
            ),
          ),
        ],
      ),
    );
    // BlocBuilder<HomeBloc, HomeState>(
    //   buildWhen: (prev, curr) {
    //     return curr is HomeLoadingState || curr is HomeGetSeminarsDoneState;
    //   },
    //   builder: (_, state) {
    //     bool isLoading = false;
    //     List<SeminarModel> listItems = [];
    //     if (state is HomeLoadingState) {
    //       isLoading = true;
    //     } else if (state is HomeGetSeminarsDoneState) {
    //       listItems = state.listSeminars;
    //     }
    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(left: 15, right: 15),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 'Danh sách hội thảo',
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500,
    //                   color: Theme.of(context).primaryColor,
    //                 ),
    //               ),
    //               // Text(
    //               //   'Xem thêm',
    //               //   style: TextStyle(
    //               //     fontSize: 12,
    //               //     fontWeight: FontWeight.w500,
    //               //     color: Theme.of(context).primaryColor,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //         isLoading
    //             ? Center(
    //                 child: CircularProgressIndicator(
    //                   strokeWidth: 3,
    //                   color: Theme.of(context).primaryColor,
    //                 ),
    //               )
    //             : _buildListTutorialView(listItems)
    //       ],
    //     );
    //   },
    // );
  }

  ListView _buildListTutorialView(List<SeminarModel> listItems) {
    return ListView.builder(
      itemCount: 10, //listItems.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      // padding: const EdgeInsets.only(top: 15),
      itemBuilder: (_, index) {
        final item = SeminarModel(); //listItems[index];
        return _buildItemView(item);
      },
    );
  }

  InkWell _buildItemView(SeminarModel item) {
    return InkWell(
      onTap: () => CommonUtils.showConfirmDialog(context,
          msg: 'Vui lòng đăng nhập để xem được hội thảo',
          okAction: () => Navigator.of(context).pushNamed(RouterName.login)),
      // () => Navigator.of(context)
      //     .pushNamed(RouterName.detail_tutorial, arguments: item),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            // border: Border.all(
            //   color: ColorConstant.grayEAB.withOpacity(0.24),
            // ),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.grayEAB.withOpacity(0.2),
                blurRadius: 2,
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MyCacheImage(
                  'https://cybershow.vn/wp-content/uploads/2020/02/company-trip-prudential-80-640x480.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên khoá học',
                        style: AppTextStyle.medium16Black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '14/08/2023',
                        style: AppTextStyle.regular14Gray,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildNavbarView() {
    return Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (prev, curr) {
          return curr is ProfileLoadDoneState;
        },
        builder: (_, state) {
          String name = '';
          String? avatar;
          String? id;
          if (state is ProfileLoadDoneState) {
            name = state.user.HoTen ?? '';
            avatar = state.user.AnhCaNhan;
            id = state.user.idHoiVien;
          }
          return Row(
            children: [
              id == null
                  ? SizedBox.shrink()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: avatar != null && avatar != ''
                          ? Image.network(
                              avatar,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            )
                          : Image.asset(
                              ImageConstant.human,
                              width: 40,
                              height: 40,
                            ),
                    ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: id == null
                    ? InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed(RouterName.login),
                        child: Text(
                          'Đăng nhập / Đăng ký',
                          textAlign: TextAlign.end,
                          style: AppTextStyle.regular16White.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
