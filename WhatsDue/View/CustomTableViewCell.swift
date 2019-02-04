//
//  CustomTableViewCell.swift
//  BillPayAlert
//
//  Created by Aaron O'Connor on 12/26/17.
//  Copyright © 2017 Aaron O'Connor. All rights reserved.
//

import UIKit
protocol CustomTableViewCellDelegate {
    func didTapSwitch(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblBillName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDue: UILabel!
    @IBOutlet weak var lblStament: UILabel!

    @IBOutlet weak var imageCell2: UIImageView!
}
