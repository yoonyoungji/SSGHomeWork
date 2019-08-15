//
//  DetailViewController.swift
//  SSGHomeWork
//
//  Created by YoungD on 2019. 8. 14..
//  Copyright © 2019년 YoungD. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    //데이터 리스트
    var detailData = Array<ListDataModel>()
    
    //셀 Identifier
    let cellId = "detailCollectionCell"
    
    //현재 페이지 indexPath
    var currentIndexPath = IndexPath()
    
    //3초마다 셀 이동할때 사용할 타이머
    var timer: Timer?
    
    //MARK:- ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
        self.initializeObject()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //타이머 시작
        self.startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //타이머 중단
        timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Initailize
    func initView(){
        self.title = "상품"
    }
    
    func initializeObject(){
        self.detailCollectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
    }
    
    //타이머 시작
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true);
    }
    
    /// 다음페이지로 이동
    @objc func scrollToNextCell(){
        //3초에 한번씩 다음 페이지로 이동
        if self.currentIndexPath.row+1 < self.detailData.count{
            self.currentIndexPath = IndexPath(item: self.currentIndexPath.row + 1, section: 0)
            self.detailCollectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: true)
        }
        //마지막 페이지 지나고 나면 첫번째 페이지로이동
        else{
            self.currentIndexPath = IndexPath(item: 0, section: 0)
            self.detailCollectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: false)
        }
    }

}

//MARK:- UICollectionView Delegate/Datasource
extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    //리스트 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailData.count
    }
    
    //셀 꾸며주기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailCollectionViewCell
        cell.configureCell(detailData: self.detailData[indexPath.row])
        return cell
    }
    
    //셀 선택 했을 때 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailWebVC = DetailWebViewController.init(nibName: "DetailWebViewController", bundle: nil)
        detailWebVC.loadUrlString = self.detailData[indexPath.row].itemLnkd
        self.navigationController?.pushViewController(detailWebVC, animated: true)
    }
    
    //Page Update
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        currentIndexPath = indexPath
        pageCountLabel.text = "\(String(describing: self.currentIndexPath.row + 1))/\(self.detailData.count)"

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            //마지막 데이터 보다 이후로 스크롤 했을 때
            if (scrollView.contentOffset.x > (scrollView.contentSize.width - scrollView.frame.size.width)) {
    
                self.currentIndexPath = IndexPath(item: 0, section: 0)
                 self.detailCollectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: false)
            }
    
            //첫번째데이터 보다 이전으로 스크롤했을 때
            if (scrollView.contentOffset.x <= 0){
                self.currentIndexPath = IndexPath(item: self.detailData.count - 1, section: 0)
                self.detailCollectionView.scrollToItem(at: self.currentIndexPath, at: .centeredHorizontally, animated: false)
            }
    }
}
