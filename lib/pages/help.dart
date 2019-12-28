import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FAQ'),
        ),
        body: _buildHelpList());
  }
}

List<String> helpQuestionList = [
  'What is the minimum Age to book E Drives?',
  'What all documents required at the time of booking?',
  'Is there any Security Deposit?',
  'From where should i Pickup the vehicle?',
  'Where do I need to return the vehicle?',
  'What is the Rental Period?',
  'How to I charge the vehicle?',
  'Is there any Distance limit?',
  'What all the Penalty charges?',
  'IS the billing amount inclusive of GST?',
  'How do I Extend my Rental Period?',
  'Does E Drives Provide Helmet?',
  'What is the Threshold Time?',
  'How I can make a Replacement of the Vehicle/when I can make replacement of the vehicle?',
];

var helpAnswerList = [
  '•	The user must be above the age of 18 years. However, certain vehicles are provided at the minimum age of 18.',
  '1.	The user must have a valid driving license issued by the Government of India.\n2.	The user must scan his/her license and upload it on our app.\n3.	The user must carry his/her original DL & Alternate ID proof at the time he/she takes possession of the vehicle.\n4.	Documents issued by the government of India such as Voter ID, Driver’s license etc. will be considered as valid ID proof only.\n5.	PAN card will not be accepted as valid government Id Proof.\n6.	If a user is unable to verify his/her identity, the booking shall be considered void by E Drives.\n7.	If the user makes multiple bookings at the same time slot, an approved co-driver must be added to either of the bookings.',
  '•	E Drives does not charge any security deposit for bookings. ',
  '•	The user can take possession of his/her vehicle from E Drives pickup points. Please find a list of pickup Points on our app . If a user opts for home-pickup, a charge of Rs.150 will be levied. ',
  '•	The user must return possession of the vehicle at the pickup point from which it had been hired.',
  '1.	The Rental Period will be calculated from the time the user takes possession of the keys till they are returned to a E Drives representative at the pickup Point.\n2.	Minimum booking duration is 1 day.\n3.	Charges will apply on the time period for which the vehicle has been booked by the user .',
  'Vehicle charging need to be done by the user itself.\nBy plugging the charger to any 5A socket will work , It will take 4-5 hours to completely charge the vehicle.',
  'There is no Cap on Distance travelled.',
  "1 .If a customer is found drunk at the time of drop , Rs.1000/- fine will be levied along with the damage cost. Also, the customer will be liable for the complete damage repair cost.\n2. Customers are required to drop the vehicle at the drop location chosen at the time of booking. Failing to do so, he will be fined Rs.500/-. Additionally, overtime charges will be fined if another booking coincides with the booking.\n3. Smoking is strictly prohibited in and around the vehicle. Penalty of Rs.1000/- fine will be charged,if found guilty.\n4.A delay of 15 minutes over the rental period is permissible for the return of possession. In the case of further delay, for the first two hours: (Rs 200 + double the hourly charge) .The charges for the time period of delay will be calculated as per usual rates given on the app. We are doing this to protect next user's ride experience.\n5.E Drives shall bear no penalty imposed on the vehicle due to negligent driving on part of the user.\n6.Parking challans, if any will have to be borne by the user.\n7.In the event of any traffic rule violation or parking fine, the member must inform E Drives immediately. E Drives may ask for a copy of the challan in such an event.\n8.If the user damages or misplaces any attachment or accessory provided with the vehicle, E Drives reserves the right to charge the appropriate amount from the user.\n9.If the user has incurred any dues over and above that of the initial booking amount when dropping off the vehicle at the drop off site location and is unable to settle the dues at that time, then the user will have to sign a declaration provided by us promising to settle the dues and leave the original documents of license, government ID, etc. as surety. The documents can be collected by the user from the site location once dues have been settled.\n10.In the event of user having any penalties/dues outstanding with E Drives, E Drives reserves the right to charge reminder fees and default interest. E Drives  also reserves the right to utilize third parties for the recovery of dues from a user.\n11.E Drives reserves the right to prohibit a user from booking any rides until all dues associated with the user account have been paid to E Drives in full.\n13.The user would be charged with a penalty in case any accessory or documents, belonging to E Drives is found missing during the end ride.\n14.Damage charges apply in case of damage to the vehicle, it depends on the severity of the damage. However, the maximum liability that the user is liable to pay in case of a major damage is Rs. 9999 (subject to certain T&Cs).",
  "All charges as per contract are inclusive of GST charges. Toll tax and other charges will be borne by the user.",
  "If the user wishes to extend the rental period, he/she can contact E Drives.  Rides extension is not possible within 4 hours of selected end time. Please note extension of rides is possible only in the case when there is no subsequent booking. The user must make the payment before extension is approved. No discounts shall be offered on the extended period of time. Additional charges will be levied as follows:",
  " E Drives will provide one helmet per bike,. In case of damage or loss of helmet, a charge of Rs.800 will be   collected from user.",
  "A delay of 15 minutes over the rental period is permissible for the return of possession.In the case of further delay,for the first two hours: (Rs 500 + double the hourly charge).The charges for the time period of delay will be calculated as per usual rates given on the app. We are doing this to protect next user's ride experience.",
  "E Drives shall provide a replacement vehicle in the case of vehicle failure. This is subject to vehicle availability.",
];

Widget _buildHelpList() {
  return ListView.builder(
    itemCount: helpQuestionList.length,
    // shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        // color: Colors.cyan,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: ExpansionTile(
                    title:
                        // Text("Pieter's Pizza "),
                        Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Container(height: 100.0, color: Colors.blueAccent),
                          Text('${helpQuestionList[index]}',
                              style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                    // trailing: Icon(Icons.local_pizza),
                    // backgroundColor: Colors.yellow,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(helpAnswerList[index]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Container(height: 1.0, color: Colors.grey[300])
          ],
        ),
      );
    },
  );
}
