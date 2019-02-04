//
//  Tab.swift
//  BillPayAlert
//
//  Created by Aaron O'Connor on 2/1/18.
//  Copyright © 2018 Aaron O'Connor. All rights reserved.
//

import Foundation

class Tab: NSObject, NSCoding {
    
    struct Keys {
        static let amount = "amount"
        static let balance = "balance"
        static let date = "date"
        static let strDate = "strDate"
    }
    
    private var _amount = ""
    private var _balance = ""
    private var _date = Date()
    private var _strDate = ""
    
    override init() {}
    
    init(amount: String, balance: String, date: Date, strDate: String) {
        _amount = amount
        _balance = balance
        _date = date
        _strDate = strDate
    }
    
    required init(coder aDecoder: NSCoder) {
        if let amountObj = aDecoder.decodeObject(forKey: Keys.amount) as? String {
            _amount = amountObj
        }
        if let balanceObj = aDecoder.decodeObject(forKey: Keys.balance) as? String {
            _balance = balanceObj
        }
        if let dateObj = aDecoder.decodeObject(forKey: Keys.date) as? Date {
            _date = dateObj
        }
        if let strDateObj = aDecoder.decodeObject(forKey: Keys.strDate) as? String {
            _strDate = strDateObj
        }
    }
    
    func encode(with aCoder: NSCoder){
        aCoder .encode(_amount, forKey: Keys.amount)
        aCoder .encode(_balance, forKey: Keys.balance)
        aCoder .encode(_date, forKey: Keys.date)
        aCoder .encode(_strDate, forKey: Keys.strDate)
    }
    
    var amount: String {
        get {
            return _amount;
        }
        set {
            _amount = newValue;
        }
    }
    var balance: String {
        get {
            return _balance;
        }
        set {
            _balance = newValue;
        }
    }
    var date: Date {
        get {
            return _date;
        }
        set {
            _date = newValue;
        }
    }
    var strDate: String {
        get {
            return _strDate;
        }
        set {
            _strDate = newValue;
        }
    }
}
