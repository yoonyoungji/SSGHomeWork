//
//  ViewController.swift
//  SSGHomeWork
//
//  Created by YoungD on 2019. 8. 14..
//  Copyright © 2019년 YoungD. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    //데이터 리스트
    var itemList = Array<ListDataMainModel>()
    
    //셀 Identifier
    let cellId = "listCell"
    
    //데이터 통신할 URL
    let dataURL : String = "http://static.ssgcdn.com/ui/app/test/assignment_ios.json"
    
    //MARK:- ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initView()
        self.initializeObject()
        self.getItemList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Initialize
    func initializeObject(){
        // Cell register
        self.listTableView.register(UINib(nibName: "mainTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        //tableview Delegate/datasource
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }
    
    func initView(){
        self.title = "물품 목록"
    }
    
    //MARK:- Get Data
    func getItemList(){
        DispatchQueue.global().async {
            Alamofire.request(URL(string: self.dataURL)!).responseJSON{ response in
                if let responseJson = response.result.value as? [String: Any] {
                    let data = responseJson["data"] as! [String: Any]
                    for dataKey in data.keys{
                        let detailitems = data[dataKey] as! Array<Dictionary<String, Any>>
                        var detailItemList = Array<ListDataModel>()
                        
                        //상세데이터 넣어주기
                        for items in detailitems{
                            let detailData = ListDataModel().dicToListDataModel(dataDic: items as! Dictionary<String, String>)
                            detailItemList.append(detailData)
                        }
                        
                        //메인데이터 - 타이틀 + 상세데이터리스트
                        let mainData = ListDataMainModel(listItem: detailItemList, itemTitle: dataKey)
                        self.itemList.append(mainData)

                    }
                    
                    //item 1/ item2 이렇게 Display해주기 위해 추가한 코드
                    if Int(String((self.itemList.first?.itemTitle.last)!))! > Int(String((self.itemList.last?.itemTitle.last)!))!{
                        var tempitemList = Array<ListDataMainModel>()
                        tempitemList.append(self.itemList.last!)
                        tempitemList.append(self.itemList.first!)
                        self.itemList.removeAll()
                        self.itemList = tempitemList
                    }
                    
                    DispatchQueue.main.async {
                        self.listTableView.reloadData()
                    }
                }
            }
        }
    }
}
//MARK:- Tableview Delegate/DataSource
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    //테이블 뷰 리스트 아이템 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    //테이블 뷰 셀 꾸며주기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! mainTableViewCell
        cell.configureCell(titleData: self.itemList[indexPath.row].itemTitle)
        return cell
    }
    
    //테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    //셀 선택 했을 때 액션
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        detailVC.detailData = self.itemList[indexPath.row].listItem
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}

