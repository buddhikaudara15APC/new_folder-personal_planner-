import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty?
      Column(
        children: [
        Text(
          'No Transactions Added Yet!',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 10,),
        Container(
          height: 300,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
            //color: Colors.white,
            ),
        ),
        ],
      )
      :ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            elevation: 10.0,
               child: ListTile(
              leading: FittedBox(
                    child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child:  Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          // style: TextStyle(
                          //   color: Colors.black12,
                          // ),
                          )
                        ),
                    ),
                  // backgroundColor: Theme.of(context).primaryColor,
                  ),
              ),
              
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline4
                ),
              subtitle: Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                 color:Colors.grey,
                  fontSize: 15,
                ),
              ),
              trailing: IconButton(
                onPressed: ()=>deleteTx(transactions[index].id), 
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                  ),
                ),
            ),
          );
         },
               itemCount: transactions.length,
             ),
             );
  }
}