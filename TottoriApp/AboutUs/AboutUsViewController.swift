//
//  AboutUsViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class AboutUsViewController: UIViewController,ViewControllerWithViewWithStack {
    private lazy var aboutUsView = AboutUsView(delegate: self)
    internal lazy var viewWithStack: ViewWithStack? = aboutUsView as ViewWithStack
    internal var selectedTextField: UITextField?
    private lazy var isToggled = false
    private var arrayOfDesignItems : [ElemBlock] = []
    
    override func loadView() {
        super.loadView()
        self.view = aboutUsView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGestureForDismissKeyBoard()
        setScrollViewDelegate()
        setBackGround()
        controlButtonStateAlgo()
        setDelegateForCollectionView()
        getDesignData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1){[weak self] in
            
            
            self?.aboutUsView.layoutIfNeeded()
            
            
        }
    }
    private func setScrollViewDelegate(){
        self.aboutUsView.scrollView.delegate = self
        
    }
    private func getDesignData(){
        let designListViewModel = DesignListViewModel()
        aboutUsView.activityIndicator.startAnimating()
        designListViewModel.getDesignList { result in
            DispatchQueue.main.async {
                switch result{
                    
                case .success(let array):
                    self.arrayOfDesignItems = array
                    self.aboutUsView.horCollectionView.reloadData()
                case .failure(let error):
                    self.present(UIAlertController.createAllert(text: error.localizedDescription), animated: true)
                    
                }
                self.aboutUsView.activityIndicator.stopAnimating()
            }
            
            
            
        }
        
    }
    private func setDelegateForCollectionView(){
        aboutUsView.horCollectionView.delegate = self
        aboutUsView.horCollectionView.dataSource = self
    }
    
    func controlButtonStateAlgo(){
        let nameField = (aboutUsView.vStackName.subviews[1] as? CustomTextFieldWithInsets)
        let phoneField = (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        
        
        if let name = nameField?.text,let phone = phoneField?.text,let time = timeField?.text{
            if (!name.isEmpty && !phone.isEmpty && !time.isEmpty){
                let removeOccPhone = phone.replacingOccurrences(of:"[^0-9]", with: "",options: .regularExpression)
                
                if (removeOccPhone.phoneIsValid()){
                    
                    
                    aboutUsView.makeAnOrderButton.isEnabled = true
                    
                    
                    
                    
                    
                }
                else{
                    aboutUsView.makeAnOrderButton.isEnabled = false
                    aboutUsView.makeAnOrderButton.setTitle(NSLocalizedString("valide_phone", comment: ""), for: .disabled)
                }
            }
            else{
                aboutUsView.makeAnOrderButton.setTitle(NSLocalizedString("fulfill_all_fields", comment: ""), for: .disabled)
                aboutUsView.makeAnOrderButton.isEnabled = false
            }
            
            
            
        }
        
    }
    
}

//Calls this function when the tap is recognized.



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


extension AboutUsViewController :  TextFieldControlColorProtocol,AboutUsDelegate{
    func dismissToolBar(sender: UIToolbar) {
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        
        timeField?.text = getFormatter().string(from: aboutUsView.timePicker.date)
        aboutUsView.endEditing(true)
        
    }
    
    func changeDatePicker(sender: UIDatePicker) {
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        
        timeField?.text = getFormatter().string(from: sender.date)
    }
    
    
    
    func postRequest(sender: UIButton) {
        self.showCustomAlert(text: NSLocalizedString("thx_for_dev", comment: ""))
        let nameField = (aboutUsView.vStackName.subviews[1] as? CustomTextFieldWithInsets)
        let phoneField = (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets)
        let timeField = (aboutUsView.vStackTime.subviews[1] as? CustomTextFieldWithInsets)
        nameField?.text = ""
        phoneField?.text = ""
        timeField?.text = ""
        aboutUsView.vipView.clearCircle()
        controlButtonStateAlgo()
        
    }
    
    
    
    func switchTogle(sender: UIButton) {
        
        if isToggled{
            aboutUsView.vipView.clearCircle()
        }
        else{
            aboutUsView.vipView.drawCircle()
        }
        isToggled.toggle()
    }
    func switchTextField(sender: UITextField) {
        controlAlgoColor(currentField: sender)
    }
    func phoneTextFieldTapped(sender : UITextField){
        if sender.text == ""{
            sender.text = "+7"
        }
        
    }
    func textEditing(sender: UITextField) {
        if sender === (aboutUsView.vStackPhone.subviews[1] as? CustomTextFieldWithInsets){
            aboutUsView.controlPhoneFieldAlgo()
            
        }
        controlButtonStateAlgo()
    }
    private func getFormatter() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    
}
extension AboutUsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfDesignItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FurnitureCollectionViewCell.id, for: indexPath) as! FurnitureCollectionViewCell
        cell.configureCell(item: arrayOfDesignItems[indexPath.row])
        return cell
    }
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ){
        
        
        
        if scrollView == aboutUsView.horCollectionView{
            
            setPage(targetContentOffset: targetContentOffset, array: arrayOfDesignItems)
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == aboutUsView.scrollView{
            if aboutUsView.vStackConstraint.constant < 0 && scrollView.contentOffset.y + 350 > aboutUsView.vStackFields.frame.origin.y{
                UIView.animate(withDuration: 1.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, animations: {
                    [weak self] in
                    self?.aboutUsView.vStackConstraint.constant = 20
                    
                    
                    self?.aboutUsView.layoutIfNeeded()
                    
                })
                
                
            }
            
        }
        
    }
    
    
}
