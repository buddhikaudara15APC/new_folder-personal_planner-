import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'personal planner',
      theme: ThemeData(
       primarySwatch: Colors.purple,
       accentColor: Colors.amber,
       fontFamily: 'Quicksand',
       //buttonColor: Colors.white,
       textTheme: ThemeData.light().textTheme.copyWith(
           headline4: TextStyle(
             fontFamily: 'OpenSans',
             fontWeight: FontWeight.bold,
             fontSize: 20,
           ),
       ),
       appBarTheme: AppBarTheme(
         textTheme: ThemeData.light().textTheme.copyWith(
           headline6: TextStyle(
             fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
             fontSize: 30,
           ),
         ),
       ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [

];
List<Transaction>get _recentTransactions{
return _userTransactions.where((tx){
  return tx.dateTime.isAfter(
    DateTime.now().subtract(
      Duration(days:7)
    ),
  );
}).toList();
}
void _addNewTransaction(String txTitle,double txAmount,DateTime choosenDate){
final newTx = Transaction(
  
  
  id: DateTime.now().toString(),
  title:txTitle,
  amount: txAmount,
  dateTime: choosenDate, 
);
setState(() {
  _userTransactions.add(newTx);
});
}
void _startAddNewTransaction(BuildContext ctx){
  showModalBottomSheet(context: ctx,
   builder: (_){
   return GestureDetector(
     onTap: (){},
     behavior: HitTestBehavior.opaque,
     child: NewTransaction(_addNewTransaction)
     );
   }
   );
}

void _deleteTransaction(String id){
  setState(() {
   _userTransactions.removeWhere((tx) => tx.id==id); 
  });
  
}

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
         title: Text(
           'personal planner',
           style: Theme.of(context).appBarTheme.titleTextStyle,
           ),
        actions: [
          IconButton(
            onPressed: ()=>_startAddNewTransaction(context),
            icon: Icon(Icons.add),
            ),
        ],
      ),
      body:SingleChildScrollView(
              child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Chart(_recentTransactions),
          TransactionList(_userTransactions,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       onPressed:()=>_startAddNewTransaction(context),
     ),
    );
  }
}


/// chart bar ake update aka hari
/// ath podi pasnayk thiyenava----date aka update venne na
/// date picker aken thorala dipu date aka update venne na
