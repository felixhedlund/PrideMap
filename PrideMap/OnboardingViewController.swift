//
//  OnboardingViewController.swift
//  PrideMap
//
//  Created by Felix Hedlund on 2017-07-13.
//  Copyright © 2017 Felix Hedlund. All rights reserved.
//

import UIKit
import Cheers
import RazzleDazzle
import IBAnimatable
import MapKit
class OnboardingViewController: AnimatedPagingScrollViewController {
    fileprivate var pageControl: UIPageControl!
    fileprivate var welcomeLabel: UILabel!
    fileprivate var diaryView: UIView!
    
    var continueButton: UIButton!
    var textField: UITextField!
    var textFieldBorder: UIView!
    
    var shouldEnableContinueAtStart = true
    
    var cheerView: CheerView?
    var circleView: CircleView?
    
    var circleMap: CircleMap?
    var locationManager: CLLocationManager!
    var locationButton: UIButton!
    var pushButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        self.addBackgroundShape()
        self.addPageControl()
        self.addFirstViewContent()
        self.addSecondPageContent()
        self.addThirdPageContent()
        self.addFourthPageContent()
        self.animateCurrentFrame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfPages() -> Int {
        // Tell the scroll view how many pages it has
        return 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        pageControl.currentPage = Int(pageOffset + 0.5)
        trySetNewBackgroundColor(pageNumber: pageControl.currentPage)
    }
    
    private var currentSetPageNumber = 0
    private func trySetNewBackgroundColor(pageNumber: Int){
        if pageNumber != currentSetPageNumber{
            switch pageNumber {
            case 0:
                break
//                circleView?.animateWithColor(color: UIColor.gray.withAlphaComponent(0.1))
            case 1:
                break
//                circleView?.animateWithColor(color: UIColor.gray.withAlphaComponent(0.05))
            case 2:
                break
//                circleView?.animateWithColor(color: UIColor.gray.withAlphaComponent(0.025))
            case 3:
                break
//                circleView?.animateWithColor(color: UIColor.clear)
            default:
                return
            }
        }
        currentSetPageNumber = pageNumber
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func addPageControl(){
        self.pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
        pageControl.numberOfPages = self.numberOfPages()
        pageControl.currentPage = 0
        self.contentView.addSubview(pageControl)
        let bottom = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: -24)
        bottom.isActive = true
        keepView(pageControl, onPages: [0,1,2])
        
        let animation = ConstraintConstantAnimation(superview: pageControl, constraint: bottom)
        animation[0] = -24
        animation[1] = -24//-self.view.frame.height/2
        animation[2] = -24
        animator.addAnimation(animation)
    }
    
}

extension OnboardingViewController: CLLocationManagerDelegate{
    func addFirstViewContent(){
        addWelcomeLabel()
        addCheers()
        addCircleMap()
        addLocationButton()
    }
    
    private func addWelcomeLabel(){
        let label = UILabel()
        label.text = NSLocalizedString("welcome_label", comment: "Welcome Label")
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        self.welcomeLabel = label
        self.contentView.addSubview(label)
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 28).isActive = true
        NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: -48).isActive = true
        keepView(label, onPages: [0])
        
        let animate = AlphaAnimation(view: label)
        animate[-0.5] = 0
        animate[0] = 1
        animate[0.5] = 0
        self.animator.addAnimation(animate)
    }
    
    private func addCircleMap(){
        let backgroundView = AnimatableImageView(image: UIImage(named: "prideCircle"))
        backgroundView.maskType = .circle
        backgroundView.alpha = 0.5
        self.contentView.addSubview(backgroundView)
        let centerY1 = NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0)
        centerY1.isActive = true
        let widthC1 = NSLayoutConstraint(item: backgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 256)
        widthC1.isActive = true
        NSLayoutConstraint(item: backgroundView, attribute: .width, relatedBy: .equal, toItem: backgroundView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        keepView(backgroundView, onPages: [-0.5,0,0.5])
        let animate = AlphaAnimation(view: backgroundView)
        animate[-0.5] = 0
        animate[0] = 0.5
        animate[0.5] = 0
        self.animator.addAnimation(animate)
        
        
        
        
        if let circleMap = UINib.init(nibName: "CircleMap", bundle: nil).instantiate(withOwner: self)[0] as? CircleMap {
            self.circleMap = circleMap
            self.contentView.addSubview(circleMap)
            let centerC = NSLayoutConstraint(item: circleMap, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0)
            centerC.isActive = true
            let widthC = NSLayoutConstraint(item: circleMap, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 188)
            widthC.isActive = true
            NSLayoutConstraint(item: circleMap, attribute: .width, relatedBy: .equal, toItem: circleMap, attribute: .height, multiplier: 1, constant: 0).isActive = true
            keepView(circleMap, onPages: [-0.5,0,0.5])
            let animate = AlphaAnimation(view: circleMap)
            animate[-0.5] = 0
            animate[0] = 1
            animate[0.5] = 0
            self.animator.addAnimation(animate)
        }
        
        
        
        
    }
    
    private func addLocationButton(){
        let button = UIButton()
        self.locationButton = button
        button.backgroundColor = #colorLiteral(red: 0, green: 0.3019607843, blue: 1, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitle(NSLocalizedString("location_permission", comment: "Access location string"), for: .normal)
        button.addTarget(self, action: #selector(self.permitLocationAccess(sender:)), for: .touchUpInside)
        self.contentView.addSubview(button)
        let bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: -80)
        bottom.isActive = true
        let widthC = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 220)
        widthC.isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        keepView(button, onPages: [-0.5,0,0.5])
        let animate = ConstraintConstantAnimation(superview: button, constraint: bottom)
        animate[-0.5] = self.view.frame.height/2
        animate[0] = -80
        animate[0.5] = self.view.frame.height/2
        self.animator.addAnimation(animate)
        
    }
    
    func permitLocationAccess(sender: UIButton){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.circleMap?.mapView.showsUserLocation = true
        if let coordinate = locations.last?.coordinate{
            self.circleMap?.mapView.centerCoordinate = coordinate
        }
        self.locationManager.stopUpdatingLocation()
        self.locationButton.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.1490196078, alpha: 1)
        self.locationButton.setTitle(NSLocalizedString("swipe_label", comment: "Swipe label"), for: .normal)
        
    }
    
    
    
    private func addCheers(){
        if let circleView = UINib.init(nibName: "CircleView", bundle: nil).instantiate(withOwner: self)[0] as? CircleView {
            self.circleView = circleView
            circleView.clipsToBounds = true
            circleView.backgroundColor = UIColor.clear
            self.contentView.addSubview(circleView)
            NSLayoutConstraint(item: circleView, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
            let widthC = NSLayoutConstraint(item: circleView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 0.25, constant: 0)
            widthC.isActive = true
            NSLayoutConstraint(item: circleView, attribute: .width, relatedBy: .equal, toItem: circleView, attribute: .height, multiplier: 1, constant: 0).isActive = true
            keepView(circleView, onPages: [2])
            
            let animate = ConstraintMultiplierAnimation(superview: scrollView, constraint: widthC, attribute: .width, referenceView: circleView)
            animate[1.9] = 0.9
            animate[2] = 1
            animate[2.1] = 0.9
            animator.addAnimation(animate)
            
            
            
            
            let animate2 = AlphaAnimation(view: circleView)
            animate2[0] = 0.25
            animate2[1] = 0
            animate2[1.9] = 0.5
            animate2[2] = 1
            animate2[2.5] = 0.5
            animator.addAnimation(animate2)
            
            
            let cheerView = CheerView()
            circleView.cheerContainer.addSubview(cheerView)
            let heart = NSAttributedString(string: "❤️", attributes: [
                NSFontAttributeName: UIFont.systemFont(ofSize: 15)
                ])
            let heart2 = NSAttributedString(string: "💛", attributes: [
                NSFontAttributeName: UIFont.systemFont(ofSize: 15)
                ])
            let heart3 = NSAttributedString(string: "💚", attributes: [
                NSFontAttributeName: UIFont.systemFont(ofSize: 15)
                ])
            let heart4 = NSAttributedString(string: "💙", attributes: [
                NSFontAttributeName: UIFont.systemFont(ofSize: 15)
                ])
            let heart5 = NSAttributedString(string: "💜", attributes: [
                NSFontAttributeName: UIFont.systemFont(ofSize: 15)
                ])
            cheerView.config.particle = .text(CGSize(width: 100, height: 100), [heart, heart2, heart3, heart4, heart5])
            cheerView.config.colors = [#colorLiteral(red: 0.8941176471, green: 0.01176470588, blue: 0.01176470588, alpha: 1),#colorLiteral(red: 1, green: 0.5490196078, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.9294117647, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.5019607843, blue: 0.1490196078, alpha: 1),#colorLiteral(red: 0, green: 0.3019607843, blue: 1, alpha: 1),#colorLiteral(red: 0.4588235294, green: 0.02745098039, blue: 0.5294117647, alpha: 1)]
            cheerView.start()
            self.cheerView = cheerView
        }

    }
    
}

extension OnboardingViewController{
    func addSecondPageContent(){
        addNotificationView()
        addNotificationButton()
    }
    
    private func addNotificationView(){
        if let notificationView = UINib.init(nibName: "NotificationView", bundle: nil).instantiate(withOwner: self)[0] as? NotificationView {
            notificationView.messageLabel.text = NSLocalizedString("parade_notification", comment: "Onboarding parade notification")
            self.contentView.addSubview(notificationView)
            let widthC1 = NSLayoutConstraint(item: notificationView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)
            widthC1.isActive = true
            let topC = NSLayoutConstraint(item: notificationView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
            topC.isActive = true
            keepView(notificationView, onPages: [0.5,1,1.5])
            
            let animate = ConstraintConstantAnimation(superview: contentView, constraint: topC)
            animate[0.5] = -self.view.frame.height/2
            animate[1] = 0
            animate[1.5] = -self.view.frame.height/2
            animator.addAnimation(animate)
            
            
        }
    }
    
    private func addNotificationButton(){
        let button = UIButton()
        self.pushButton = button
        button.backgroundColor = #colorLiteral(red: 0, green: 0.3019607843, blue: 1, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitle(NSLocalizedString("permit_push", comment: "Access push string"), for: .normal)
        button.addTarget(self, action: #selector(self.permitPushAccess(sender:)), for: .touchUpInside)
        self.contentView.addSubview(button)
        let bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: -80)
        bottom.isActive = true
        let widthC = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 244)
        widthC.isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        keepView(button, onPages: [0.5,1,1.5])
        let animate = ConstraintConstantAnimation(superview: button, constraint: bottom)
        animate[0.5] = self.view.frame.height/2
        animate[1] = -80
        animate[1.5] = self.view.frame.height/2
        self.animator.addAnimation(animate)
        
    }
    
    func permitPushAccess(sender: UIButton){
        PushHelper.sharedInstance.registerForPushNotifications(success: {
            self.pushButton.setTitle(NSLocalizedString("swipe_label", comment: "Swipe label"), for: .normal)
            self.pushButton.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.1490196078, alpha: 1)
        }) {
            self.pushButton.setTitle(NSLocalizedString("swipe_label", comment: "Swipe label"), for: .normal)
            self.pushButton.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        }
    }
    
}

extension OnboardingViewController{
    func addThirdPageContent(){
        addContinueButton()
    }
    
    private func addContinueButton(){
        continueButton = UIButton()
        continueButton.backgroundColor = UIColor.white
        continueButton.showsTouchWhenHighlighted = true
        continueButton.layer.borderColor = UIColor.black.cgColor
        continueButton.layer.cornerRadius = 8
        continueButton.layer.borderWidth = 2
        continueButton.tintColor = UIColor.black
        continueButton.setTitle(NSLocalizedString("Continue", comment: "Continue string"), for: .normal)
        if shouldEnableContinueAtStart{
            continueButton.isEnabled = true
            continueButton.setTitleColor(UIColor.black, for: .normal)
        }else{
            continueButton.isEnabled = false
            continueButton.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
        }
        
        continueButton.showsTouchWhenHighlighted = true
        
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        continueButton.addTarget(self, action: #selector(self.didPressContinue(sender:)), for: .touchUpInside)
        contentView.addSubview(continueButton)
        
        NSLayoutConstraint(item: continueButton, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: continueButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 160).isActive = true
        NSLayoutConstraint(item: continueButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        keepView(continueButton, onPages: [2])
        let animate = AlphaAnimation(view: continueButton)
        animate[1.5] = 0
        animate[2] = 1
        animate[2.5] = 0
        self.animator.addAnimation(animate)
        
        
        
    }
    
    func didPressContinue(sender: UIButton){
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: TargetConstants.HasShownOnboarding)
        
        self.performSegue(withIdentifier: "Map", sender: self)
    }
}

extension OnboardingViewController: UITextFieldDelegate{
    func addFourthPageContent(){
        
    }
    
    

}

