import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/businesman_bloc/businessman_bloc.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/model/product_list_model.dart';
import 'package:geo_fresh/ui/businessman/businessman_qc_certificate_form.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/product_card_text.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController priceController = new TextEditingController();
  // ProductListModelNew productListModelNew =
  //     ProductListModelNew(data: [ProductListData(img: [])]);
  List<ProductListModel> productList = [];
  String userId = '';
  String bidPrice = '';

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<BusinessmanBloc>(context)
      ..add(FetchProductListBusinessman());
    getPref();
    super.initState();
  }

  getPref() async {
    userId = await AuthHelper().getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<BusinessmanBloc, BusinessmanState>(
        listener: (context, state) async {
          if (state is FetchProductListSuccess) {
            productList = state.productListModelNew;

            setState(() {});
          } else if (state is BidPlacedSuccess) {
            BlocProvider.of<BusinessmanBloc>(context)
                .add(FetchProductListBusinessman());
          } else if (state is BusinessmanFailureState) {
            showErrorToast(msg: state.error);
          }
        },
        child: BlocBuilder<BusinessmanBloc, BusinessmanState>(
            builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: Text(
                "List of agri products",
                style: TextStyle(fontSize: 13.5.sp),
              ),
              backgroundColor: greenColor,
            ),
            body: (state is BusinessmanInProgressState)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: (contextList, index) {
                          return productCard(
                              context, state, productList[index]);
                        }),
                  ),
          );
        }),
      ),
    );
  }

  Widget productCard(BuildContext context, BusinessmanState state,
      ProductListModel productListData) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCardText(
                        leftSideText: "Crop type",
                        rightSideText: productListData.title),
                    ProductCardText(
                        leftSideText: "Crop category",
                        rightSideText: productListData.crop_cat),
                    ProductCardText(
                        leftSideText: "Variety of crops",
                        rightSideText: productListData.crop_veriety),
                    ProductCardText(
                        leftSideText: "Price",
                        rightSideText: productListData.price),
                    ProductCardText(
                        leftSideText: "Unit",
                        rightSideText: productListData.price_type),
                    ProductCardText(
                        leftSideText: "Quantity",
                        rightSideText: productListData.quantity),
                    ProductCardText(
                        leftSideText: "From date",
                        rightSideText: productListData.fromdate),
                    ProductCardText(
                        leftSideText: "To date",
                        rightSideText: productListData.todate),
                  ],
                ),
                Column(
                  children: [
                    Row(
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
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QcCertificate(),
                          ),
                        );
                      },
                      child: Text(
                        "View Qc\n Certificate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            buildPriceFields(context, state, productListData),
          ],
        ),
      ),
    );
  }

  Widget buildPriceFields(BuildContext context, BusinessmanState state,
      ProductListModel productListData) {
    if (productListData.bid != null) {
      if (productListData.bidArr.userId.toString() == userId) {
        return Container(
          child: Text(
              showErrorToastBottom(msg: "You have already bid for this product")
              //style: TextStyle(color: greenColor, fontSize: 11.0.sp),
              ),
        );
      }
      // for (int i = 0; i < bidArray.length; i++) {
      //   if (bidArray[i].user_id.toString() == userId) {
      //     return Container(
      //       child: Text(
      //         "You have already bid for this product",
      //         style: TextStyle(color: greenColor, fontSize: 11.0.sp),
      //       ),
      //     );
      //   }
      // }
    }

    return Row(
      children: [
        if (productListData.bidArr == null)
          SizedBox(
            width: 50.5.w,
            child: SizedBox(
              child: TextFieldContainerWidget(
                color: textFieldColor,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    bidPrice = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Price*',
                    hintText: "0.00",
                    labelStyle: TextStyle(
                      color: lightBlackColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (productListData.bidArr.status == 0)
          SizedBox(
            width: 50.5.w,
            child: SizedBox(
              child: TextFieldContainerWidget(
                color: textFieldColor,
                child: TextFormField(
                  initialValue: productListData.bidArr.prices,
                  readOnly: true,
                ),
              ),
            ),
          ),
        SizedBox(width: 6.0.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (productListData.bidArr == null)
                SizedBox(
                  height: 50,
                  width: 25.0.w,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: GreenBorderButtonWidget(
                      text: "SUBMIT",
                      textSize: 12.0.sp,
                      onPressed: () {
                        if (bidPrice.isNotEmpty) {
                          BlocProvider.of<BusinessmanBloc>(context).add(
                            CreateBid(
                              bidPrice: bidPrice,
                              itemId: productListData.id.toString(),
                            ),
                          );
                        } else {
                          showErrorToast(msg: "Please enter price");
                        }
                      },
                    ),
                  ),
                )
              else if (productListData.bidArr.status == 0)
                SizedBox(
                  height: 50,
                  width: 25.0.w,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "In Progress",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
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
}
/* SizedBox(height: 8),
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
