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
    
    
    var data:[TestCellModel] = [TestCellModel(category: "진단기준", answer: "아무개 아무개 아무개"),TestCellModel(category: "보증금 및 차임", answer: "보증금 및 차임(월세)이 임대인과 합의한대로 적혀있는지 다시 한 번 확인하세요.")]
    
    lazy var navigationBarView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var backButton = UIButton().then{
        
        $0.setImage(DesignSystemAsset.Icon.arrowLeft, for: .normal)
    }
    
    lazy var navigationTitleLabel = UILabel()
    
    lazy var baseLine = UILabel().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }

    lazy var scrollView = UIScrollView().then{
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
    }
    
    lazy var topLabelContainerView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setTitle2Style("나에게 부족한 보장", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000,alignment: .center)
    }
    
    lazy var remindLabel = UILabel().then{
        $0.attributedText = setBody2Style("꼼꼼하게 점검해보세요", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700,alignment: .center)
    }
    
    lazy var dashBoardContainerView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var circleDashBoard = CircleDashBoardView()
    
    lazy var emptyView = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }
    
    lazy var tableContainerView = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }
    
    lazy var tableHeaderView = PrepareTableHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: 30))
    
    lazy var tableView = UITableView().then{
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.tableHeaderView = tableHeaderView
        $0.dataSource = self
        $0.delegate = self
        $0.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        $0.register(AnswerTableViewCell.self, forCellReuseIdentifier:AnswerTableViewCell.identifier)
        
        
    }
    

    
    
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
        
        circleDashBoard.loadProgress(self.viewModel.model.score)


    }
    
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
        
    }
    
    
    
    
    
    


}

extension ResultViewController {
    private func addSubViews(){
        self.view.addSubview(navigationBarView)
        self.view.addSubview(scrollView)
        
        
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
        
        navigationTitleLabel.attributedText = setBody1Style(viewModel.model.type.resultNavigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
        
        
        self.scrollView.addSubview(stackView)
        self.stackView.addArrangedSubview(topLabelContainerView)
        self.stackView.addArrangedSubview(dashBoardContainerView)
        self.stackView.addArrangedSubview(emptyView)
        self.stackView.addArrangedSubview(tableContainerView)
        
        self.topLabelContainerView.addSubview(titleLabel)
        self.topLabelContainerView.addSubview(remindLabel)
        
        
        self.dashBoardContainerView.addSubview(circleDashBoard)
        tableContainerView.addSubview(tableView)
        
        
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
        
        scrollView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(navigationBarView.snp.bottom)
        }
        
        stackView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(20)

        }
        
        remindLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview().inset(20)
            
        }
        
        dashBoardContainerView.snp.makeConstraints{
            $0.height.equalTo(244)
        }
        
        emptyView.snp.makeConstraints{
            $0.height.equalTo(32)
        }
        
        circleDashBoard.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.height.equalTo(244)
            $0.centerX.equalToSuperview()
            
        }
        
        tableView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(800)
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

extension ResultViewController:UITableViewDataSource{
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  section == 0 ? -1 : 5
    }

       // Make the background color show through
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
        return nil
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // row 개수가 굉장히 중요함
        
        let data = data[section]
        var count:Int = 0
            
           if data.isOpen {
               count = 2
           }else{
               count = 1
           }
           return count
    }
    
    
}

extension ResultViewController:UITableViewDelegate{
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else{
                   return UITableViewCell()
        }
        
        guard let answerCell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier,for: indexPath) as? AnswerTableViewCell else {
            return UITableViewCell()
        }
        

        
        let sectionData = data[indexPath.section]
        
        categoryCell.layer.cornerRadius = 10
        answerCell.layer.cornerRadius = 10
        
        
        if sectionData.isOpen{ // 부분 cornerRadius
            categoryCell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            answerCell.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        }
        
        
        categoryCell.backgroundColor = .white
        categoryCell.clipsToBounds = true
        
        
        answerCell.backgroundColor = .white
        categoryCell.clipsToBounds = true
        
        categoryCell.selectionStyle = .none
        answerCell.selectionStyle = .none
       
        
        
        categoryCell.update(model: data[indexPath.section])
        answerCell.update(model:data[indexPath.section])
        
        if indexPath.row == 0 {
            return categoryCell
        }else {
            return answerCell
        }
        
        


   
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        data[indexPath.section].isOpen = !data[indexPath.section].isOpen
        
        
        tableView.reloadSections([indexPath.section], with: .none)
        
        let next = IndexPath(row: 1, section: indexPath.section ) //row 1이 답변 쪽
        
        if data[indexPath.section].isOpen 
        {
            self.scrollToBottom(indexPath: next)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func scrollToBottom(indexPath:IndexPath){
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
}
