//
//  ViewController.swift
//  RxExample2
//
//  Created by Admin on 1/16/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    let CreditDescriptionTitle = ["Card Name", "Product Type", "Brand Name", "Category Tags", "Marketing", "Credit Rating", "Active From", "Benifits", "Fraud Coverage", "Late Payment Fee", "Cash Advance", "Minimum Deposit"]
    
    let dataSource =  RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
        configureCell: { (_, tv, indexPath, element) in
            
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element
//            cell.textLabel?.text?.append(indexPath.row)
            return cell
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
    }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VDL")
        
        setupTableRx()
    }
    
    
    func setupTableRx(){
        let dataSource = self.dataSource
        
        let items = Observable.just([
            SectionModel(model: CreditDescriptionTitle[0], items: [
                "Capital One QUicksilver Cash",
                "nothing",
                "You qualify"
                ]),
            SectionModel(model: CreditDescriptionTitle[1], items: [
                "Consumer Card",
                "in reverse0",
                "Something arb"
                ]),
            SectionModel(model: CreditDescriptionTitle[2], items: [
                "anything",
                "can",
                "happen"
                ])
            ])
        
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        //for selection (we have no use for it)
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { tuple in
                print("pair indexPath:\(tuple.0) data:\(tuple.1)")
            })
            .disposed(by: disposeBag)
        
    }

}


