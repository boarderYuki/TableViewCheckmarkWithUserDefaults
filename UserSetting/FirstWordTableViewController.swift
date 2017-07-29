//
//  FirstWordTableViewController.swift
//  UserSetting
//
//  Created by yuki.pro on 2017. 7. 28..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class FirstWordTableViewController: UITableViewController {

    var category = [String]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "words", ofType: "json") else { return }
        //print(path ?? "Not a real path")
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let dictionary = json as? [String: Any] {
                
                if let nestedDictionary = dictionary["data"] as? [String: [String]] {
                    
                    category = nestedDictionary["category"]!
                }
            }
            
            
        } catch {
            print(error)
        }
        
        let keyNumber = userDefaults.integer(forKey: "SetFirstKeyword")
        let f = category[keyNumber]
        
        print("ffff", f)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let keyNumber = userDefaults.integer(forKey: "SetFirstKeyword")
        let f = category[keyNumber]
        
        cell.textLabel?.text = category[indexPath.row]
        
        if cell.textLabel?.text == f {
            cell.accessoryType = .checkmark
            cell.textLabel?.text = category[keyNumber]
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            //cell.textLabel?.text = category[indexPath.row]
        }
        return cell
    }
    
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data1 = userDefaults.object(forKey: "indexKey") as? NSData
        let indexP1 = NSKeyedUnarchiver.unarchiveObject(with: data1! as Data) as? IndexPath
        print(" indexP1 You selected cell #\(indexP1)!")
        print(" indexPath You selected cell #\(indexPath.row)!")

        if indexP1 != nil {
            selectedIndexPath = indexP1!
            
        }
        
        if indexPath == selectedIndexPath as IndexPath{
            print("인덱스와 셀렉트가 같음")
            
            return
        } else {
            print("인덱스와 셀렉트가 다름")
            tableView.cellForRow(at: indexP1!)?.accessoryType = .none
            tableView.cellForRow(at: selectedIndexPath as IndexPath)?.accessoryType = .none
            

            
            

        }
        let d = indexPath.row
        userDefaults.set(d, forKey: "SetFirstKeyword")
        
        // 인덱스키 저장
        let data = NSKeyedArchiver.archivedData(withRootObject: indexPath)
        print("data", data)
        userDefaults.set(data, forKey: "indexKey")
        
        
        
        userDefaults.synchronize()
        tableView.reloadData()
        selectedIndexPath = indexPath as IndexPath  // save the selected index path
        print(" selectedIndexPath You selected cell #\(selectedIndexPath.row)!")
        
    }
    
}
