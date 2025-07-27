import 'package:nada_dco/Screens/TravelSubCategory.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class TravelDetails extends StatefulWidget {
  static String routeName = './TravelDetails';
  const TravelDetails({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _TravelDetailsState createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  alertBox() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 100 / 100,
          width: MediaQuery.of(context).size.width * 100 / 100,
           color: Colors.black,
           
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               SizedBox(height: MediaQuery.of(context).size.height *  5/ 100,),
                   GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                     child: Container(
                     alignment: Alignment.topRight,
                        
                       
                           
                                child: Image.asset("assets/icon/ic__crossicon.png",
                                  width: MediaQuery.of(context).size.width *8/ 100,
                          height: MediaQuery.of(context).size.width *  8/ 100,
                          color: Colors.white,),
                               
                          ),
                   ),
                    SizedBox(height: MediaQuery.of(context).size.width *  54/ 100,),
               Container(
                        width: MediaQuery.of(context).size.width * 96/ 100,
                        height: MediaQuery.of(context).size.width *  50/ 100,
                        decoration: BoxDecoration(
                          //  border: Border.all(width: 5, color: Color(0xffe0e0e0)),
                       
                          // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage(AppImage.ticketImage),
                              fit: BoxFit.fill),
                        ),
                      ),
              
            
            
            ],
          ),
        );
      },
    );
  }
  List<TicketDetails> Tiketlist = [
    TicketDetails(
        name: "Single Trip Ticket",
        image: "assets/icon/ic_ticket.jpg",
        details: '',
        date: '',
        time: '',
        fare: '',
        returnDetails: '',
        from: '',
        text: '',
        locationTo: '',
        locationfrom: '',
        byRoad: '',
        transport: ''),
    TicketDetails(
        name: "Single Trip Ticket",
        image: "assets/icon/ic_returnticket.png",
        details: 'INR 2300',
        date: '23 Nov,2022',
        time: 'Departure Date',
        fare: 'Fare',
        returnDetails: 'Return Details',
        from: 'From',
        text: 'To',
        locationTo: 'Pune',
        locationfrom: 'Mumbai',
        byRoad: 'Airlines',
        transport: 'Mode of Transport'),
    TicketDetails(
        name: "Round Trip",
        image: "assets/icon/ic_returnticket.png",
        details: 'INR 2300',
        date: '23 Nov,2022',
        time: 'Departure Date',
        fare: 'Fare',
        returnDetails: 'Return Details',
        from: 'From',
        text: 'To',
        locationTo: 'Pune',
        locationfrom: 'Mumbai',
        byRoad: 'Road',
        transport: 'Mode of Transport'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {},
            child: IconButton(
              icon: Image.asset(
                AppImage.backicon,
                height: 25,
                width: 25,
              ),
              onPressed: () {
                Navigator.pushNamed(context, TravelSubCategory.routeName);
              },
            )),
        title: Text(AppLanguage.ViewTicketDetailsText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 100 / 100,
          color: Colors.white,
          child: ListView.builder(
              itemCount: Tiketlist.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE3f5AB), Color(0xfff8ffe8)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: Text(
                          Tiketlist[index].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 95 / 100,
                        height: MediaQuery.of(context).size.height * 0.2 / 100,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: const Text(
                          "Olympic Game",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Text(
                                "Departure Date",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: const Text(
                                "23 Nov,2022",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Text(
                                "From",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: const Text(
                                "Mumbai",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Text(
                                "To",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: const Text(
                                "Pune",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Text(
                                "Fare",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: const Text(
                                "INR 2300",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 92 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Text(
                                "Mode of Transport",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: const Text(
                                "Road",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      GestureDetector(
                        onTap: (() {
                          alertBox();
                        }),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 92 / 100,
                          height: MediaQuery.of(context).size.width * 43 / 100,
                          decoration: BoxDecoration(
                            //  border: Border.all(width: 5, color: Color(0xffe0e0e0)),
                            borderRadius:
                                BorderRadius.circular(25), //<-- SEE HERE
                            // color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage(Tiketlist[index].image),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Container(
                        child: index != 0
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 7),
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    child: Text(
                                      Tiketlist[index].returnDetails,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 7),
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            Tiketlist[index].time,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            Tiketlist[index].date,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 7),
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            Tiketlist[index].from,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            Tiketlist[index].locationfrom,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 7),
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            Tiketlist[index].text,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            Tiketlist[index].locationTo,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 7),
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            Tiketlist[index].fare,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            Tiketlist[index].details,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 7),
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            Tiketlist[index].transport,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            Tiketlist[index].byRoad,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        100,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        92 /
                                        100,
                                    height: MediaQuery.of(context).size.width *
                                        43 /
                                        100,
                                    decoration: BoxDecoration(
                                      //  border: Border.all(width: 5, color: Color(0xffe0e0e0)),
                                      borderRadius: BorderRadius.circular(
                                          25), //<-- SEE HERE
                                      // color: Colors.red,
                                      image: DecorationImage(
                                        image:
                                            AssetImage(Tiketlist[index].image),
                                            fit:BoxFit.fill
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(''),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class TicketDetails {
  String name,
      image,
      details,
      date,
      time,
      returnDetails,
      from,
      text,
      fare,
      locationfrom,
      locationTo,
      transport,
      byRoad;
  TicketDetails({
    required this.name,
    required this.image,
    required this.details,
    required this.date,
    required this.time,
    required this.returnDetails,
    required this.from,
    required this.text,
    required this.fare,
    required this.locationfrom,
    required this.locationTo,
    required this.transport,
    required this.byRoad,
  });
}
