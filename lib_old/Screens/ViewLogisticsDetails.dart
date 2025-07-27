import 'package:nada_dco/Screens/LogisticsSubCategory.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class ViewLogisticsDetails extends StatefulWidget {
  static String routeName = '/ViewLogisticsDetails';
  const ViewLogisticsDetails({Key? key}) : super(key: key);

  @override
  State<ViewLogisticsDetails> createState() =>
      __ViewLogisticsDetailsStateState();
}

class __ViewLogisticsDetailsStateState extends State<ViewLogisticsDetails> {
  List<logisticsaList> list = [
    logisticsaList(
        name: AppLanguage.basketballText[language],
    ),
    logisticsaList(
        name: AppLanguage.VolleyballText[language],
    ),
    logisticsaList(
        name: AppLanguage.BadmintonText[language],
    ),
    logisticsaList(
        name: AppLanguage.BoxingText[language],
       ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        systemOverlayStyle:Constant.systemUiOverlayStyle,
        leading: InkWell(
            onTap: () {},
            child: IconButton(
              icon: Image.asset(
                AppImage.backicon,
                height: 25,
                width: 25,
              ),
              onPressed: () {
               Navigator.pushNamed(context, LogisticsSubCategory.routeName);
              },
            )),
        title: Text(
          AppLanguage.ViewLogisticsDetailsText[language],
          style: Constant.appBarCenterTitleStyle),
        ),
      
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 6),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    // margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.5),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xffE3f5AB), Colors.white],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 89 / 100,
                          alignment: Alignment.centerLeft,
                          child: Text(
                           list[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          width: MediaQuery.of(context).size.width * 95 / 100,
                          height:
                              MediaQuery.of(context).size.height * 0.3 / 100,
                          color: Color(0xffcdd9ab),
                        ),

                        _ViewLogisticsDetailsStateRow(
                          title1:AppLanguage.ItemNameText[language],
                          title2:  AppLanguage.AvailableUnitsText[language],
                          title3: AppLanguage.RequestedUnitsText[language],
                        ),
                        _ViewLogisticsDetailsStateRow(
                          title1: AppLanguage.BottiesText[language],
                          title2: "12",
                          title3: '16',
                        ),
                        _ViewLogisticsDetailsStateRow(
                          title1: AppLanguage.BookText[language],
                          title2: "9",
                          title3: '12',
                        ),
                        _ViewLogisticsDetailsStateRow(
                          title1:AppLanguage.NetsText[language],
                          title2: "8",
                          title3: '10',
                        ),
                        _ViewLogisticsDetailsStateRow(
                          title1: AppLanguage.SticksText[language],
                          title2: "4",
                          title3: '9',
                        ),

                
                      ],
                    ),
                  ),
                ),
              );
              
            }),
      ),
    );
  }
}

class _ViewLogisticsDetailsStateRow extends StatelessWidget {
  _ViewLogisticsDetailsStateRow({
    Key? key,
    required this.title1,
    required this.title2,
    required this.title3,
  }) : super(key: key);
  final String title1;
  final String title2;
  final String title3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // alignment: Alignment.center,
            
            width: MediaQuery.of(context).size.width * 27 / 100,
            child: Text(
              title1.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            
            margin: EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 30/ 100,
            child: Text(
              title2.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 31 / 100,
            child: Text(
              title3.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class logisticsaList {
  String name ;
  logisticsaList({
    required this.name,
   
  });
}
