//
//  ResultViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import UIKit
import SnapKit
import Then
import RxSwift

public class ResultViewController: BaseViewController {

    
    let disposeBag = DisposeBag()
    
    private var viewModel:ResultViewModel!
    

    
    lazy var navigationBarView = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue100
    }
    
    lazy var backButton = UIButton().then{
        
        $0.setImage(DesignSystemAsset.Icon.arrowLeft, for: .normal)
    }
    
    lazy var navigationTitleLabel = UILabel()
    
    lazy var baseLine = UILabel().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
//    lazy var flowLayout = UICollectionViewFlowLayout().then{
//        $0.scrollDirection = .vertical
//    }
//
//    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout:flowLayout).then{
//
//        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
//
//        $0.register(AnswerCollectionViewCell.self,forCellWithReuseIdentifier: AnswerCollectionViewCell.identifier)
//
//        $0.delegate = self
//        $0.dataSource = self
//
//    }
    
    lazy var collectionViewHeaderView = ResultCollectionHeaderView(score: 80)

    

    

    
    
    init(viewModel:ResultViewModel){
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureUI()
        bind()
        
//        circleDashBoard.loadProgress(self.viewModel.model.score)


    }
    
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
        
    }
    
    
    
    
    
    


}

extension ResultViewController {
    private func addSubViews(){
        self.view.addSubview(navigationBarView)
        
        
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
        
        navigationTitleLabel.attributedText = setBody1Style(viewModel.model.type.resultNavigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
        
        self.view.addSubview(collectionViewHeaderView)
        
        //self.view.addSubview(collectionView)
        

    }
    
    private func configureUI(){
        navigationBarView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints{
            $0.width.height.equalTo(32)
            $0.left.equalToSuperview().inset(MARGIN())
            $0.centerY.equalToSuperview()
        }
        
        navigationTitleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        baseLine.snp.makeConstraints{
            
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionViewHeaderView.snp.makeConstraints{
            $0.top.equalTo(navigationBarView.snp.bottom)
            
            $0.left.right.bottom.equalToSuperview()
        }
        


        
//        collectionView.snp.makeConstraints{
//            $0.left.bottom.right.equalToSuperview()
//            $0.top.equalTo(navigationBarView.snp.bottom)
//        }
        

        

        
    }
    
    private func bind(){
        backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                owner.navigationController?.popViewController(animated: true)
                
            })
            .disposed(by: disposeBag)
    }
    
}

//extension ResultViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//
//
//}
//
//extension ResultViewController:UICollectionViewDataSource {
//
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return viewModel.model.warings.count
//
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        guard let answerCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCollectionViewCell.identifier, for: indexPath) as? AnswerCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//
//        let sectionData = viewModel.model.warings[indexPath.section]
//        categoryCell.backgroundColor = .clear
//        answerCell.backgroundColor = .clear
//
//
//        categoryCell.update(model: sectionData)
//        answerCell.update(model:sectionData)
//
//        if indexPath.row == 0 {
//            return categoryCell
//        }else {
//            return answerCell
//        }
//
//
//    }
//
//}

//extension ResultViewController:UITableViewDataSource{
//
//
//
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.model.warings.count
//    }
//
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // row 개수가 굉장히 중요함
//
//        let data = viewModel.model.warings[section]
//        var count:Int = 0
//
//           if data.isOpen {
//               count = 2
//           }else{
//               count = 1
//           }
//           return count
//    }
//
//
//}

//extension ResultViewController:UITableViewDelegate{
//
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else{
//                   return UITableViewCell()
//        }
//
//        guard let answerCell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier,for: indexPath) as? AnswerTableViewCell else {
//            return UITableViewCell()
//        }
//
//
//
//        let sectionData = viewModel.model.warings[indexPath.section]
//        categoryCell.backgroundColor = .clear
//        answerCell.backgroundColor = .clear
////        //categoryCell.layer.cornerRadius = 10
////        answerCell.layer.cornerRadius = 10
////
////
////        if sectionData.isOpen{ // 부분 cornerRadius
////            categoryCell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
////            answerCell.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
////        }
////
////
////        //categoryCell.backgroundColor = .white
////        //categoryCell.clipsToBounds = true
////
////
////        answerCell.backgroundColor = .white
////        answerCell.clipsToBounds = true
//
//        categoryCell.selectionStyle = .none
//        answerCell.selectionStyle = .none
//
//
//
//        categoryCell.update(model: sectionData)
//        answerCell.update(model:sectionData)
//
//        if indexPath.row == 0 {
//            return categoryCell
//        }else {
//            return answerCell
//        }
//
//
//
//
//
//    }
//
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//
//        viewModel.model.warings[indexPath.section].isOpen = !viewModel.model.warings[indexPath.section].isOpen
//
//
//        tableView.reloadSections([indexPath.section], with: .none)
//
//        let next = IndexPath(row: 1, section: indexPath.section ) //row 1이 답변 쪽
//
//        if viewModel.model.warings[indexPath.section].isOpen
//        {
//            self.scrollToBottom(indexPath: next)
//        }
//    }
//
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    private func scrollToBottom(indexPath:IndexPath){
//        DispatchQueue.main.async {
//            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
//        }
//    }
//}


