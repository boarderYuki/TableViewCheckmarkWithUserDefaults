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
    
    // 이전에 체크된 카테고리명의 인덱스패스 저장
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // JSON 파일로 카테고리 리스트 생성
        guard let path = Bundle.main.path(forResource: "words", ofType: "json") else { return }
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
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // SetFirstKeyword 에 저장된 카테고리명 가져옴
        let keyNumber = userDefaults.integer(forKey: "SetFirstKeyword")
        let f = category[keyNumber]
        
        cell.textLabel?.text = category[indexPath.row]
        
        // 동일한 카테고리명이면 체크마크 표시
        if cell.textLabel?.text == f {
            cell.accessoryType = .checkmark
            cell.textLabel?.text = category[keyNumber]
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 최초 인덱스키가 있으면 selectedIndexPath 를 인덱스키로 교체
        if userDefaults.object(forKey: "indexKey") != nil {
            let data1 = userDefaults.object(forKey: "indexKey") as? Data
            let indexP1 = NSKeyedUnarchiver.unarchiveObject(with: data1!) as? IndexPath
            
            if indexP1 != nil {
                selectedIndexPath = indexP1!
            }
            //tableView.cellForRow(at: indexP1!)?.accessoryType = .none
        }

        // 현재 인덱스를 저장된 selectedIndexPath 와 비교
        if indexPath == selectedIndexPath as IndexPath{
            return
        } else {
            tableView.cellForRow(at: selectedIndexPath as IndexPath)?.accessoryType = .none
        }
        
        // 선택된 카테고리명 저장용
        userDefaults.set(indexPath.row, forKey: "SetFirstKeyword")
        
        // 카테고리명 리스트에 체크마크 표시용 인덱스키 저장
        let data = NSKeyedArchiver.archivedData(withRootObject: indexPath)
        userDefaults.set(data, forKey: "indexKey")
        userDefaults.synchronize()
        
        //현재 인덱스패스를 selectedIndexPath 에 저장
        selectedIndexPath = indexPath as IndexPath
        
        tableView.reloadData()
    }
    
}
