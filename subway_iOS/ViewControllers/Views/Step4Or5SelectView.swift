//
//  Step4CheeseSelectView.swift
//  subway_iOS
//
//  Created by khpark on 2018. 9. 23..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//  치즈 & 토스팅 선택
//

import UIKit
import Alamofire

struct IngredientInstance {
    var ingredient : Bread?
    var clicked = false
}

protocol Step4Or5CompleteDelegate {
    func step4Or5Completed(ingredient : Bread, nextStep: Int)
}

class Step4Or5SelectView: UITableView {

    let cellHeight : CGFloat = 270
    
    var list = [IngredientInstance]()
    var completeDelegate : Step4Or5CompleteDelegate?
    var step = 0
    
    func setupTableView(){
        separatorStyle = .none
        register(UINib(nibName: RecipeSingleOptionCell.cellId, bundle: nil), forCellReuseIdentifier: RecipeSingleOptionCell.cellId)
        delegate = self
        dataSource = self
        
        // MARK: - prevent jumpy scrolling when reload data
        rowHeight = cellHeight
        estimatedRowHeight = cellHeight
    }
    
    func fetchData(){
        
        guard list.isEmpty else {
            return
        }
        
        if step == 4 {
            GetCheeses(method: .get, parameters: [:]).requestAPI { [weak self] in
                self?.bindData(response: $0)
            }
        } else if step == 5 {
            GetToastings(method: .get, parameters: [:]).requestAPI { [weak self] in
                self?.bindData(response: $0)
            }
        }
    }
    
    func initializeSelection(){
        for i in 0..<list.count {
            if list[i].clicked {
                list[i].clicked = false
                let indexPath = IndexPath(row: i, section: 0)
                reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
    fileprivate func bindData(response: DataResponse<Ingredients>){
        guard let statusCode = response.response?.statusCode, statusCode == 200 else {
            print("ERROR GETTING CHEESE OR TOASTING")
            return
        }
        
        if let value = response.value {
            list.append(contentsOf: value.results.map({IngredientInstance(ingredient: $0, clicked: false)}))
            reloadData()
        }
    }
    
}

extension Step4Or5SelectView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeSingleOptionCell.cellId, for: indexPath) as! RecipeSingleOptionCell
        
        cell.data = list[indexPath.row]
        if step == 5 {
            cell.ivWidth.constant = 250
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if list[indexPath.row].clicked {
            return
        }
        
        for i in 0..<list.count {
            list[i].clicked = false
        }
        list[indexPath.item].clicked = true
        
        tableView.reloadData()
        
        if let data = list[indexPath.row].ingredient {
            completeDelegate?.step4Or5Completed(ingredient: data, nextStep: step + 1)
        }
    }
    
}
