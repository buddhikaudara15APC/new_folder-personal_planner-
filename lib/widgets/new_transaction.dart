import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

final Function addTx;

NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
final _amountController = TextEditingController();
final _titleController = TextEditingController();
DateTime? _selectedDate; //= DateTime.now() ;
void _submitData(){
  final enteredTitle = _titleController.text;
  final enteredAmount = double.parse(_amountController.text);
  if (_amountController.text.isEmpty) {
    return;
  }
  if (enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null) {
    return;
  }
widget.addTx(
enteredTitle,
enteredAmount,
_selectedDate,
);
Navigator.of(context).pop();
}

void _presentDatePicker(){
  showDatePicker(
    context: context,
    initialDate: DateTime.now(), 
    firstDate: DateTime(2021), 
    lastDate: DateTime.now(),
    ).then((pickedDate){
    if (pickedDate==null ) {
      return;
    }
    setState(() {
    _selectedDate = pickedDate; 
    });
   print(pickedDate);
    });
    print('...');
}

  @override

  Widget build(BuildContext context) {
    return Card(
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
             TextField(
               decoration: InputDecoration(
                 labelText: 'Title'
              ),
             controller: _titleController,
             onSubmitted: (_)=>_submitData,
             ),
              TextField(
               decoration: InputDecoration(
                 labelText: 'Amount'
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
               onSubmitted: (_)=>_submitData,
             ),
             Container(
               height: 50,
               child: Row(
                 children: [
                   Expanded(
                     child: Text(
                       _selectedDate == null?'No Date Choosen!':'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}'
                       ),
                   ),
                   TextButton(
                     onPressed:_presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                 ],
               ),
             ),
             ElevatedButton(
               onPressed: _submitData,
                 child: Text(
                  'Add Transaction',
                )
                  ), 
                
              ],
            ),
          ),
        );
  }
}