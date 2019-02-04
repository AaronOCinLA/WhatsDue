//
//  ViewControllerEntry.swift
//  BillPayAlert
//
//  Created by Aaron O'Connor on 12/31/17.
//  Copyright © 2017 Aaron O'Connor. All rights reserved.
//

import UIKit

class ViewControllerEntry: UIViewController {
    
    @IBOutlet weak var txtBillName: UITextField!
    @IBOutlet weak var txtStatementDate: UITextField!
    @IBOutlet weak var txtDueDate: UITextField!
    @IBOutlet weak var txtFrequency: UITextField!
    
    let month = Calendar.current.component(.month, from: today)
    let date = Calendar.current.component(.day, from: today)
    let year = Calendar.current.component(.year, from: today)
    
    var filePath: String {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return url!.appendingPathComponent("Data").path;
    }
    
    @IBAction func btnEnter(_ sender: Any) {
        // Code for creating and saving entry
        
        let strLine1 = txtBillName.text
        let intStatement = Int(txtStatementDate.text!)
        let intDue = Int(txtDueDate.text!)
        let intFreq = Int(txtFrequency.text!)
        
        var bump = 0
        if (intDue! < intStatement!) {
            // bump month up one for statement date
            bump = 1
        }
        
        fakeDate = self.createDate(m: 1, d: 1, y: 2001)
        
        let thisStatementDate = createDate(m: month, d: intStatement!, y: year)
        
        var thisDueDate = createDate(m: month, d: intDue!, y: year)
        thisDueDate = calendar.date(byAdding: .month, value: bump, to: thisDueDate)!
        
        let nextSDate = calendar.date(byAdding: .month, value: 1, to: thisStatementDate)!
        let arrDate = [thisStatementDate, thisDueDate, nextSDate]
        
        let thisEntry = BillReminder(billName: strLine1!, dueDate: txtDueDate.text!, statementDate: txtStatementDate.text!, status: "Unpaid", datePaid: fakeDate, billDates: arrDate, frequency: intFreq!)
        
        saveData(billReminder: thisEntry)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtStatementDate.placeholder = "dd"
        txtDueDate.placeholder = "dd"
        
    }
    
    // Returns a date with thre integers
    func createDate (m: Int, d: Int, y: Int) -> Date {
        var fakeDateComponent = DateComponents()
        fakeDateComponent.year = y
        fakeDateComponent.month = m
        fakeDateComponent.day = d
        let todaysDate = calendar.date(from: fakeDateComponent)!
        
        return todaysDate
    }
    
    func saveData(billReminder: BillReminder ) {
        
        data.append(billReminder);
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath)  // Saves array of data
    }
}


