//
//  ViewController.swift
//  UserSetting
//
//  Created by yuki.pro on 2017. 7. 28..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    let topW = "word_03"
    let bottomW = "word_02"
    
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
                    
                    print(firstNewList)
                    print(secondNewList)
                    
                }
            }
            
            
        } catch {
            print(error)
        }
        
    }



}

