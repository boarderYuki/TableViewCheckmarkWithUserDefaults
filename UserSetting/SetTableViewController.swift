//
//  SetTableViewController.swift
//  UserSetting
//
//  Created by yuki.pro on 2017. 7. 28..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class SetTableViewController: UITableViewController {

    @IBOutlet var settingListTable: UITableView!
    @IBOutlet weak var firstKeyword: UILabel!
    let topW = ""
    let bottomW = "word_02"
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
                    let topW = category[userDefaults.integer(forKey: "SetFirstKeyword")]
                    
                   
                    
                    guard let firstWordList = nestedDictionary[topW] else {return}
                    guard let secondWordList = nestedDictionary[bottomW] else {return}
                    
                    
                    
                    var firstOldList = firstWordList
                    var secondOldList = secondWordList
                    print(firstOldList)
                    print(secondOldList)
                    
                    
                    // firstNewList 새로운 리스트 만들기
                    var firstLength = firstOldList.count
                    var firstNewList : [String] = []
                    
                    for _ in 0..<firstLength {
                        let randomNumber = Int(arc4random_uniform(UInt32(firstLength)))
                        firstNewList.append(firstOldList[randomNumber])
                        firstOldList.remove(at: randomNumber)
                        firstLength -= 1
                    }
                    
                    // secondNewList 새로운 리스트 만들기
                    var secondLength = secondOldList.count
                    var secondNewList : [String] = []
                    
                    for _ in 0..<secondLength {
                        let randomNumber = Int(arc4random_uniform(UInt32(secondLength)))
                        secondNewList.append(secondOldList[randomNumber])
                        secondOldList.remove(at: randomNumber)
                        secondLength -= 1
                    }
                    
                    print("firstNewList", firstNewList)
                    print(secondNewList)
                    
                }
            }
            
            
        } catch {
            print(error)
        }
        
    }



    override func viewWillAppear(_ animated: Bool) {
        
        
        //if userDefaults.bool(forKey: "onBoardingComplete") {
        //initialVC = sb.instantiateViewController(withIdentifier: "LoginView")
        //}
        
    
//        if (userDefaults.string(forKey: "SetFirstKeyword") != nil) {
//            firstKeyword.text = userDefaults.string(forKey: "SetFirstKeyword")
//        }
        
        let keyNumber = userDefaults.integer(forKey: "SetFirstKeyword")
        firstKeyword.text = category[keyNumber]
        print("keyNumber",keyNumber)
        //settingListTable.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
