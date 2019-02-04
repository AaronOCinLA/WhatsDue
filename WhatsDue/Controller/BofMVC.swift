    import UIKit
    
    var tabData = [Tab]()
    
    
    class BofMVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
        var tempBal = 0.0
        var tempAmount = 0.0
        var tempStrAmount = 0.0
        
        // var tab = [Tab]()
        
        @IBOutlet weak var VCBofM: UITableView!
        @IBOutlet weak var txtAmount: UITextField!
        
        var filePath: String {
            let manager = FileManager.default;
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
            return url!.appendingPathComponent("TabData").path;
        }
        
        @IBAction func btnClearAll(_ sender: Any) {
            tabData.removeAll()
            self.BofMTableView.reloadData();
        }
        
        @IBAction func btnBorrowed(_ sender: Any) {
            
        
            if txtAmount.text != "" {
                
                tempStrAmount = Double(txtAmount.text!)!
                if (tabData.count == 0) {
                    tempBal = Double(txtAmount.text!)!
                }
                else {
                    tempBal = Double(tabData[tabData.count - 1].balance)!
                    tempBal = tempBal + tempStrAmount
                }
                
                let tempTabEntry = Tab(amount: String(tempStrAmount), balance: String(tempBal), date: today, strDate: today.formatted)
                
                saveData(amount: tempTabEntry)
//                tabData.append(tempTabEntry)
                txtAmount.text = ""
                self.BofMTableView.reloadData()
            }
        }
        
        @IBAction func btnReceived(_ sender: Any) {
            
            if txtAmount.text != "" {
                
                tempStrAmount = (Double(txtAmount.text!)!*(-1))
                
                if (tabData.count == 0) {
                    tempBal = Double(txtAmount.text!)!
                }
                else {
                    tempBal = Double(tabData[tabData.count - 1].balance)!
                    tempBal = tempBal + tempStrAmount
                }
                
                let tempTabEntry = Tab(amount: String(tempStrAmount), balance: String(tempBal), date: today, strDate: today.formatted)
                
//                tabData.append(tempTabEntry)
                saveData(amount: tempTabEntry)
                txtAmount.text = ""
                self.BofMTableView.reloadData()
            }
            
        }
        
        @IBOutlet weak var BofMTableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.loadData()
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tabData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var strStatus = ""
            var tempAmount = Double(tabData[indexPath.row].amount)!
            
            // Fade image for gaspump
            let image1 = UIImage(named: "cellIOU")
            let transparentImage1 = image1?.image(alpha: 0.2)
            
            let image2 = UIImage(named: "cellPaid")
            let transparentImage2 = image2?.image(alpha: 0.2)
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellMom", for: indexPath) as! CustomTableViewCellBofM
            
            
            if (tabData[indexPath.row].amount.contains("-")) {
                cell.imageCellBackground.image = transparentImage2
                strStatus = "Paid"
                tempAmount = tempAmount * (-1.0)
            }
            else {
                cell.imageCellBackground.image = transparentImage1
                strStatus = "Lent"
            }
            //        cell.detailTextLabel?.text = tab[indexPath.row].lName
            
            cell.lblDate?.text = tabData[indexPath.row].strDate
            cell.lblAmount?.text = "\(strStatus): $\(String(format: "%.2f", tempAmount))"
            cell.lblBalance?.text = "Balance: $\(String(format: "%.2f", Double(tabData[indexPath.row].balance)!))"
            
            return cell
        }
        
        func saveData(amount: Tab ) {
            tabData.append(amount);
            NSKeyedArchiver.archiveRootObject(tabData, toFile: filePath)  // Saves array of data
            
        }
        
        func loadData() {
            if let ourTabData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Tab] {
                tabData = ourTabData;
            }
            self.BofMTableView.reloadData();
        }
    }
    
    
    extension UIImage {
        func image(alpha: CGFloat) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(at: .zero, blendMode: .normal, alpha: alpha)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
    }
    
    
