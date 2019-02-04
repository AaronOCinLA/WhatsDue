//
//  ViewController.swift
//  BillPayAlert
//
//  Created by Aaron O'Connor on 12/26/17.
//  Copyright © 2017 Aaron O'Connor. All rights reserved.


import UIKit

var data = [BillReminder]()
let today = Date()
var myIndex = 0
let calendar = Calendar.current
var fakeDate = Date()
var paidToday = Date()

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myUIView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    
    let month = Calendar.current.component(.month, from: today)
    let date = Calendar.current.component(.day, from: today)
    let year = Calendar.current.component(.year, from: today)
    
    
    var filePath: String {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return url!.appendingPathComponent("Data").path;
    }
    
    
    // MARK: - Functions
    
    func saveData(billReminder: BillReminder ) {
        data.append(billReminder);
        
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath)  // Saves array of data
    }
    
    func sortData() {
        // data.sorted(by: {$0.billName < $1.billName})
        let tempData = data.sorted (by: {$0.billName < $1.billName})
        data = tempData
        
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath)  // Saves array of data
    }
    
    // Checks the status of each bill to see what's due
    func checkStatus() {
        /* Check each entery for these 3 states
         1. New billing cycle
         2. Unpaid
         3. Past due
         */
        // If it's time for a new cycle, mark as unpaid and update the 3 date arrays
        // Else, check if it's past due
        var changed = false
        var allPaid = true
        
        // print("Checking Status \(fakeDate)")
        
        if data.count > 0 {
            for i in 0 ... (data.count - 1) {
                
                if (data[i].billDates[2].timeIntervalSinceReferenceDate < today.timeIntervalSinceReferenceDate) {
                    // If the timeInterval of the next Statement date is less than today, reset the entry
                    
                    data[i].billDates[0] = data[i].billDates[2]
                    data[i].billDates[1] = calendar.date(byAdding: .month, value: 1, to: data[i].billDates[1])!
                    data[i].billDates[2] = calendar.date(byAdding: .month, value: 1, to: data[i].billDates[2])!
                    data[i].datePaid = fakeDate
                    data[i].status = "Unpaid"
                    changed = true
                    
                }
                else{
                    // Check if it's past due
                    
                    if (data[i].billDates[1].timeIntervalSinceReferenceDate < today.timeIntervalSinceReferenceDate && data[i].status != "Paid" ) {
                        
                        // If duedate time interval is less than today, Mark it as pastDue
                        data[i].status = "Past Due!"
                        changed = true
                    }
                }
                
                if (data[i].status != "Paid"){
                    allPaid = false
                }
            }
        }
        
        if (allPaid == true){
            // Set background to green
            // hex green 2F9501
            myUIView.backgroundColor = UIColor(red: 47/255, green: 149/255, blue: 1/255, alpha: 1)
            self.myTableView.reloadData()
        }
        else {
            myUIView.backgroundColor = UIColor.white
        }
        
        if (changed) {
            NSKeyedArchiver.archiveRootObject(data, toFile: self.filePath)
            self.myTableView.reloadData()
        }
        
    }
    
    func markAllUnpaid() {
        for i in 0 ... data.count - 1 {
            data[i].status = "Unpaid"
        }
        
        
    }
    
    func deleteAll() {
        data.removeAll()
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath)
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
    
    func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [BillReminder] {
            data = ourData;
        }
        self.myTableView.reloadData();
    }
    
    // MARK: - ViewControll Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        self.sortData()
        checkStatus()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        if (data.count == 0) {
            //self.performSegue(withIdentifier: "segue1", sender: self)
            self.performSegue(withIdentifier: "segue1", sender: self)
        }
    }
    
    
    
    
    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CustomTableViewCell
        
        var strPaidOn = ""
        if (data[indexPath.row].status == "Paid"){
            strPaidOn = " \(data[indexPath.row].datePaid.formatted)"
        }
        
        cell.lblBillName?.text = data[indexPath.row].billName
        cell.lblStatus?.text = "\(data[indexPath.row].status)\(strPaidOn)"
        cell.lblDue?.text = "Due: \(data[indexPath.row].billDates[1].formatted)"
        cell.lblStament?.text = "Statement: \(data[indexPath.row].billDates[0].formatted)"
        
        if (data[indexPath.row].status == "Paid"){
            //cell.accessoryType = UITableViewCellAccessoryType.checkmark
            cell.imageCell2.image = (#imageLiteral(resourceName: "check"))
            // cell.lblStatus.textColor = UIColor.green
        } else {
            //cell.accessoryType = UITableViewCellAccessoryType.none
            cell.imageCell2.image = nil
            // cell.lblStatus.textColor = UIColor.red
        }
        
        
        return cell
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        // self.performSegue(withIdentifier: "showView", sender: self)
        myIndex = indexPath.row
        print("Index: \(myIndex)")
        
        let alert = UIAlertController(title: "Mark \(data[myIndex].billName) as Paid?", message: "Press Ok to confirm bill is paid for this month.", preferredStyle: .alert)
        let markPaid = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            
            //            self.myTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            data[myIndex].status = "Paid"
            let tDate = self.createDate(m: self.month, d: self.date, y: self.year)
            data[myIndex].datePaid = tDate
            
            NSKeyedArchiver.archiveRootObject(data, toFile: self.filePath)
            
            self.checkStatus()
            self.myTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Unpaid", style: .default) { (alert: UIAlertAction!) -> Void in
            //print("You pressed Cancel")
            self.myTableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            data[myIndex].status = "Unpaid"
            let tDate = self.createDate(m: 1, d: 1, y: 2001)
            data[myIndex].datePaid = tDate
            
            NSKeyedArchiver.archiveRootObject(data, toFile: self.filePath)
            self.checkStatus()
            self.myTableView.reloadData()
        }
        
        alert.addAction(markPaid)
        alert.addAction(cancelAction)
        
        myTableView.deselectRow(at: indexPath, animated: true)
        present(alert, animated: true, completion:nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            NSKeyedArchiver.archiveRootObject(data, toFile: filePath)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
 
    
    // MARK: - Navigate
    
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "enterNewSegue" {
            
        }
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
       //  let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}




