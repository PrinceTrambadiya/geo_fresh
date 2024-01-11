import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/model/farmer_notification_model.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/product_card_text.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class MyPurchases extends StatefulWidget {
  @override
  _MyPurchasesState createState() => _MyPurchasesState();
}

class _MyPurchasesState extends State<MyPurchases> {
  // FarmerNotificationModel farmerNotificationModel =
  //     FarmerNotificationModel(data: [FarmerNotificationData(img: [], bid: [])]);
  List<FarmerProductModel> farmerProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<FarmerBloc>(context)..add(FetchFarmerProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FarmerBloc, FarmerState>(
        listener: (context, state) {
          if (state is FetchFarmerProductsSuccess) {
            farmerProducts = state.farmerNotificationModel;
            setState(() {});
          } else if (state is FarmerFailureState) {
            showErrorToast(msg: state.error);
          }
        },
        child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: Text(
                "My Purchases",
                style: TextStyle(fontSize: 13.5.sp),
              ),
              backgroundColor: greenColor,
            ),
            body: (state is FarmerInProgressState)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: farmerProducts.isEmpty
                        ? buildEmptyNotification()
                        : ListView.builder(
                            itemCount: farmerProducts.length,
                            itemBuilder: (context, index) {
                              return productCard(
                                  context, state, farmerProducts[index]);
                            }),
                  ),
          );
        }),
      ),
    );
  }

  Widget productCard(BuildContext context, FarmerState state,
      FarmerProductModel productListData) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/businessman_address_screen',
            arguments: {"item": productListData});
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (productListData.img.isNotEmpty)
                    InkWell(
                      onTap: () {
                        showImages(productListData.img);
                      },
                      child: CachedNetworkImage(
                        imageUrl: productListData.img[0],
                        height: 75,
                        width: 75,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  /*SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: productListData.ratting != null
                        ? productListData.ratting.toDouble()
                        : 0.0,
                    minRating: 1,
                    itemSize: 15,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: null,
                  )*/
                ],
              ),
              SizedBox(width: 3.0.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCardText(
                      leftSideText: "Crop type",
                      rightSideText: productListData.title),
                  ProductCardText(
                      leftSideText: "Crop category",
                      rightSideText: productListData.cropCat),
                  ProductCardText(
                      leftSideText: "Variety of crops",
                      rightSideText: productListData.cropVariety),
                  ProductCardText(
                      leftSideText: "Price",
                      rightSideText: productListData.price),
                  ProductCardText(
                      leftSideText: "Unit",
                      rightSideText: productListData.priceType),
                  ProductCardText(
                      leftSideText: "Quantity",
                      rightSideText: productListData.quantity),
                  ProductCardText(
                      leftSideText: "From date",
                      rightSideText: productListData.fromDate),
                  ProductCardText(
                      leftSideText: "To date",
                      rightSideText: productListData.toDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showImages(List<String> images) {
    showDialog<void>(
      context: context,
      // barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Scaffold(
          backgroundColor: transparentColor,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: blackColor,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: images[index],
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                    itemCount: images.length,
                  )),
            ),
          ),
        );
      },
    );
  }

  Widget buildEmptyNotification() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/notification_bell_image.png",
            height: 146,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "No Products Found!!!",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
