//
//  AboutUsViewController.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.07.22.
//

import UIKit

class AboutUsViewController: UIViewController {
    private lazy var aboutUsView = AboutUsView(delegate: self)
    internal var selectedTextField: UITextField?
    private lazy var isToggled = false
    private var arrayOfDesignItems : [ElemBlock] = []
    
    override func loadView() {
        super.loadView()
        self.view = aboutUsView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround()
        controlButtonStateAlgo()
        setDelegateForCollectionView()
        getDesignData()

        // Do any additional setup after loading the view.
    }
    private func getDesignData(){
        let designListViewModel = DesignListViewModel()
        designListViewModel.getDesignList { result in
            DispatchQueue.main.async {
                switch result{
                    
                case .success(let array):
                    self.arrayOfDesignItems = array
                    self.aboutUsView.horCollectionView.reloadData()
                case .failure(let error):
                    self.present(UIAlertController.createAllert(text: error.localizedDescription), animated: true)
                    
                }
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
                    aboutUsView.makeAnOrderButton.setTitle("Введите корректный телефон", for: .disabled)
                }
            }
            else{
                aboutUsView.makeAnOrderButton.setTitle("Заполните все поля", for: .disabled)
                aboutUsView.makeAnOrderButton.isEnabled = false
            }
            
            
            
        }
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
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
        self.showOkAlert()
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
extension AboutUsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
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
            let currentIndex = (targetContentOffset.pointee.x / (UIScreen.main.bounds.width - 20)).rounded(.toNearestOrAwayFromZero)
            
            
            
            if currentIndex == 0{
                aboutUsView.confirmStack(stack: aboutUsView.hStack, j: 2)
                aboutUsView.hStack.subviews[0].layer.borderColor = UIColor.red.cgColor
                aboutUsView.hStack.subviews[1].layer.borderColor = UIColor.clear.cgColor
                aboutUsView.hStack.subviews[2].layer.borderColor = UIColor.clear.cgColor
            }
            else if currentIndex == CGFloat((arrayOfDesignItems.count) - 1){
                aboutUsView.hStack.subviews[0].layer.borderColor = UIColor.clear.cgColor
                aboutUsView.hStack.subviews[1].layer.borderColor = UIColor.clear.cgColor
                aboutUsView.hStack.subviews[2].layer.borderColor = UIColor.red.cgColor
                
                aboutUsView.confirmStack(stack: aboutUsView.hStack, j: (arrayOfDesignItems.count) - 1)
                
            }
            else {
                aboutUsView.confirmStack(stack: aboutUsView.hStack, j: Int(currentIndex) + 1)
                aboutUsView.hStack.subviews[0].layer.borderColor = UIColor.clear.cgColor
                aboutUsView.hStack.subviews[1].layer.borderColor = UIColor.red.cgColor
                aboutUsView.hStack.subviews[2].layer.borderColor = UIColor.clear.cgColor
                
                
            }
        }
        
        

            

       

      
    }
    
    
}
