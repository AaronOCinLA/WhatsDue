//
//  BillReminder.swift
//  BillPayAlert
//
//  Created by Aaron O'Connor on 12/26/17.
//  Copyright © 2017 Aaron O'Connor. All rights reserved.
//

import Foundation

class BillReminder: NSObject, NSCoding {
    
    struct Keys {
        static let billName = "billName"
        static let dueDate = "dueDate"
        static let statementDate = "statementDate"
        static let status = "status"
        static let datePaid = "date paid"
        static let billDates = "billDates [start, due, nextStart]"
        static let frequency = "frequency"
    }
    
    private var _billName = ""
    private var _dueDate = ""
    private var _statementDate = ""
    private var _status = ""
    private var _datePaid = Date()
    private var _billDates = [Date]()
    
    override init() {}
    
    init(billName: String, dueDate: String, statementDate: String, status: String, datePaid: Date, billDates: [Date], frequency: Int) {
        _billName = billName
        _dueDate = dueDate
        _statementDate = statementDate
        _status = status
        _datePaid = datePaid
        _billDates = billDates
    }
    
    required init(coder aDecoder: NSCoder) {
        if let billNameObj = aDecoder.decodeObject(forKey: Keys.billName) as? String {
            _billName = billNameObj
        }
        if let dueDateObj = aDecoder.decodeObject(forKey: Keys.dueDate) as? String {
            _dueDate = dueDateObj
        }
        if let statementDateObj = aDecoder.decodeObject(forKey: Keys.statementDate) as? String {
            _statementDate = statementDateObj
        }
        if let statusObj = aDecoder.decodeObject(forKey: Keys.status) as? String {
            _status = statusObj
        }
        if let datePaidObj = aDecoder.decodeObject(forKey: Keys.datePaid) as? Date {
            _datePaid = datePaidObj
        }
        if let billDatesObj = aDecoder.decodeObject(forKey: Keys.billDates) as? [Date] {
            _billDates = billDatesObj
        }
    }
    
    func encode(with aCoder: NSCoder){
        aCoder .encode(_billName, forKey: Keys.billName)
        aCoder .encode(_dueDate, forKey: Keys.dueDate)
        aCoder .encode(_statementDate, forKey: Keys.statementDate)
        aCoder .encode(_status, forKey: Keys.status)
        aCoder .encode(_datePaid, forKey: Keys.datePaid)
        aCoder .encode(_billDates, forKey: Keys.billDates)
    }
    
    var billName: String {
        get {
            return _billName;
        }
        set {
            _billName = newValue;
        }
    }
    var dueDate: String {
        get {
            return _dueDate;
        }
        set {
            _dueDate = newValue;
        }
    }
    var statementDate: String {
        get {
            return _statementDate;
        }
        set {
            _statementDate = newValue;
        }
    }
    var status: String {
        get {
            return _status;
        }
        set {
            _status = newValue;
        }
    }
    var datePaid: Date {
        get {
            return _datePaid;
        }
        set {
            _datePaid = newValue;
        }
    }
    var billDates: [Date] {
        get {
            return _billDates;
        }
        set {
            _billDates = newValue;
        }
    }
}
