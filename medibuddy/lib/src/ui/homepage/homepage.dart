import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medibuddy/src/global_bloc.dart';
import 'package:medibuddy/src/models/medicine.dart';
import 'package:medibuddy/src/ui/medicine_details/medicine_details.dart';
import 'package:medibuddy/src/ui/new_entry/new_entry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[100],
      body: Container(
        margin: EdgeInsets.only(top: 50),
        color: Color(0xF7D0CB),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 10,
              fit: FlexFit.loose,
              child: TopContainer(),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 10,
          ),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            //border:,
            //shape:BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.deepOrangeAccent, Colors.deepPurpleAccent],
            ),
          ),
          //backgroundColor: Color(0xFF3EB16F),
          child: Icon(
            Icons.add,
            color: Colors.yellowAccent,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        },
        tooltip: 'Add a new reminder',
        //heroTag: "heyy",
        //label: Text('Add a new reminder'),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
      padding: EdgeInsets.only(top: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.deepOrangeAccent, Colors.deepPurpleAccent]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(75.0),
          //topRight: Radius.elliptical(50, 27),
          topRight: Radius.circular(75.0),
          //bottomLeft: Radius.elliptical(50, 27),
          //bottomRight: Radius.elliptical(50, 27),
          bottomLeft: Radius.circular(75.0),
          bottomRight: Radius.circular(75.0),
        ),
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.deepPurpleAccent[400],
            offset: Offset(0, 1.0),
          )
        ],
        color: Colors.deepOrange,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 45,
            ),
            child: Text(
              "MediBuddy",
              style: TextStyle(
                //fontFamily: "Angel",
                fontSize: 64,
                color: Colors.yellow,
              ),
            ),
          ),
          //Divider(
          // color: Color(0xFFB0F3CB),
          //),
          Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Center(
              child: Text(
                "Number of Reminders",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style: TextStyle(
                      //fontFamily: "Neu",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      alignment: Alignment(0.0, 2),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Medicine>>(
      stream: _globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Color(0xFFF6F8FC),
            child: Center(
              child: Text(
                "Press + to add a Mediminder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFC9C9C9),
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.lightGreenAccent[100],
            child: GridView.builder(
              padding: EdgeInsets.only(top: 30, right: 100, left: 100),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MedicineCard(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard(this.medicine);

  Hero makeIcon(double size) {
    /*if (medicine.medicineType == "Bottle") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: Color(0xFF3EB16F),
          size: size,
        ),
      );
    }*/
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.local_hospital,
        color: Colors.deepOrangeAccent,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: MedicineDetails(medicine),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                makeIcon(50.0),
                Hero(
                  tag: medicine.medicineName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      medicine.medicineName,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  medicine.interval == 1
                      ? "Every " + medicine.interval.toString() + " hour"
                      : "Every " + medicine.interval.toString() + " hours",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink[300],
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MiddleContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
//     return StreamBuilder<Object>(
//         stream: globalBloc.selectedDay$,
//         builder: (context, snapshot) {
//           return Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Saturday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Sat",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Saturday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Sunday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Sun",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Sunday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Monday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Mon",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Monday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Tuesday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Tue",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Tuesday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Wednesday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Wed",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Wednesday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Thursday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Thu",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Thursday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     globalBloc.updateSelectedDay(Day.Friday);
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         "Fri",
//                         style: TextStyle(
//                           color: snapshot.data == (Day.Friday)
//                               ? Colors.black
//                               : Color(0xFFC9C9C9),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
