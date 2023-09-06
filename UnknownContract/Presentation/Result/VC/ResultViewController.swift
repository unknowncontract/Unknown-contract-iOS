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
    
    lazy var emptyView = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue100
    }

    
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
    
    lazy var flowLayout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
    }

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout:flowLayout).then{
        
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
        $0.register(ResultCollectionHeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: ResultCollectionHeaderView.identifier)
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)

        $0.register(AnswerCollectionViewCell.self,forCellWithReuseIdentifier: AnswerCollectionViewCell.identifier)

        $0.delegate = self
        $0.dataSource = self

    }
    
    lazy var headerView = ResultCollectionHeaderView(score: viewModel.model.score)
    
    

    

    

    
    
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
        self.view.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
//        circleDashBoard.loadProgress(self.viewModel.model.score)


    }
    
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
        
    }
    
    

}

extension ResultViewController {
    private func addSubViews(){
        self.view.addSubview(emptyView)
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
        
        navigationTitleLabel.attributedText = setBody1Style(viewModel.model.type.resultNavigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
        
        self.view.addSubview(collectionView)
        

    }
    
    private func configureUI(){
        
        emptyView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBarView.snp.makeConstraints{
            $0.top.equalTo(emptyView.snp.bottom)
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
        

        
        collectionView.snp.makeConstraints{
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(navigationBarView.snp.bottom)
        }
        

        

        
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
//UICollectionViewDelegateFlowLayout: 이 프로토콜의 메서드는 셀의 크기와 셀 간의 사이 간격을 정의합니다. 이 프로토콜의 메서드는 전부 선택사항입니다.
extension ResultViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // 섹션안에 Item 끼리 간격
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        viewModel.model.warings[indexPath.section].isOpen = !viewModel.model.warings[indexPath.section].isOpen
        
        UIView.performWithoutAnimation { // 깜빡 거림 없앰
            collectionView.reloadSections([indexPath.section])
            
            if viewModel.model.warings[indexPath.section].isOpen{
                collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
            
            
        }
    }
    
    //섹션간에 간격
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: .zero, bottom: 10, right: .zero)
    }
    
    
    
    //  UICollectionViewDelegateFlowLayout의 메서드 헤더 사이즈 설정
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        if section == 0 {
            return CGSize(width: APP_WIDTH(), height: 468)
        }
        else {
            return .zero
        }
    }
    
    

    

    
}



extension ResultViewController:UICollectionViewDataSource {
    
    
    // 헤더를 사용하는 dataSource 메서드
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
        if indexPath.section == 0 {
            guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ResultCollectionHeaderView.identifier,
                    for: indexPath
                  ) as? ResultCollectionHeaderView else {return UICollectionReusableView()}
            
            
            header.update(score: viewModel.model.score) //TODO: 구구님께 로딩 조언 듣기  , 오버 스크롤링 막기
            
            
            return header
        }
         
        return UICollectionReusableView()
        
        
        
    }
    
    
    
    //컬렉션뷰의 섹션의 개수를 묻는 메서드. 이 메서드를 구현하지 않으면 섹션 개수 기본 값은 1.
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.model.warings.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: APP_WIDTH(), height: 60)
    }

    
    //지정된 섹션에 표시할 항목의 개수를 묻는 메서드.
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = viewModel.model.warings[section]
        var count:Int = 0

           if data.isOpen {
               count = 2
           }else{
               count = 1
           }
           return count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let answerCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCollectionViewCell.identifier, for: indexPath) as? AnswerCollectionViewCell else {
            return UICollectionViewCell()
        }


        let sectionData = viewModel.model.warings[indexPath.section]
        categoryCell.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
        answerCell.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200


        categoryCell.update(model: sectionData)
        answerCell.update(model:sectionData)

        if indexPath.row == 0 {
            return categoryCell
        }else {
            return answerCell
        }


    }

}




