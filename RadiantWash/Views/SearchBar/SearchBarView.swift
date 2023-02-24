//
//  SearchBarView.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit

class SearchBarView: UIView {
  
  @IBOutlet var containerView: UIView!
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var cancelButtonHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var trailingButtonConstraint: NSLayoutConstraint!
  @IBOutlet weak var leadingButtonConstraint: NSLayoutConstraint!
  @IBOutlet weak var cancelButtonWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var searchBarLeadingConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var searchBarBottomConstraint: NSLayoutConstraint!
  
  private var helperExtraView = UIView()
  
  public var searchBarIsActive: Bool = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.configure()
    self.setupSearchBar()
    self.updateColors()
    self.setupCancelButton()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.commonInit()
  }
  
  private func commonInit() {
    
    U.mainBundle.loadNibNamed(C.identifiers.views.searchBar, owner: self, options: nil)
  }
  
  private func configure() {
    
    cancelButtonHeightConstraint.constant = AppDimensions.ContactsController.SearchBar.searchBarHeight
    searchBarBottomConstraint.constant = AppDimensions.ContactsController.SearchBar.searchBarBottomInset
    
    self.addSubview(containerView)
    containerView.frame = self.bounds
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    /// setup extra view for shadow
    helperExtraView.frame = self.bounds
    
    self.insertSubview(helperExtraView, at: 0)
    
    baseView.bringSubviewToFront(searchBar)
    setShowCancelButton(false, animated: false)
    
    if let searchBar = self.searchBar.value(forKey: "searchField") as? UITextField, let clearButton = searchBar.value(forKey: "_clearButton") as? UIButton {
      clearButton.addTarget(self, action: #selector(didTapClearSearchTextFieldActionButton), for: .touchUpInside)
    }
  }
  
  @objc func didTapClearSearchTextFieldActionButton() {
    U.notificationCenter.post(name: .searchBarClearButtonClicked, object: nil)
  }
  
  private func setupCancelButton() {
    
    cancelButton.setTitle(LocalizationService.Buttons.getButtonTitle(of: .cancel), for: .normal)
    cancelButton.setTitleColor(theme.contactsTintColor, for: .normal)
    cancelButton.titleLabel?.font = FontManager.contactsFont(of: .cancelButtonTitle)
    cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    cancelButtonWidthConstraint.constant = AppDimensions.ContactsController.SearchBar.cancelButtonWidth
  }
  
  @objc func didTapCancelButton() {
    searchBar.text = nil
    searchBar.endEditing(true)
    setShowCancelButton(false, animated: true)
    U.notificationCenter.post(name: .searchBarDidCancel, object: nil)
  }
  
  public func setShowCancelButton(_ showCancelButton: Bool, animated: Bool) {
    
    searchBarLeadingConstraint.constant = 20
    cancelButton.isEnabled = false
    U.delay(0.5) {
      self.cancelButton.isEnabled = showCancelButton
    }
    
    cancelButton.alpha = showCancelButton ? 1.0 : 0
    leadingButtonConstraint.constant = showCancelButton ? 0 : 20
    trailingButtonConstraint.constant = showCancelButton ? 5 : -AppDimensions.ContactsController.SearchBar.cancelButtonWidth
    
    if animated {
      U.animate(0.3) {
        self.cancelButton.layoutIfNeeded()
        self.baseView.layoutIfNeeded()
        self.containerView.layoutIfNeeded()
      }
    } else {
      self.cancelButton.layoutIfNeeded()
      self.baseView.layoutIfNeeded()
      self.containerView.layoutIfNeeded()
    }
  }
  
  private func setupSearchBar() {
    
    searchBar.placeholder = Localization.Main.Subtitles.searchHere
    searchBar.barTintColor = theme.innerBackgroundColor
    searchBar.showsCancelButton = false
    
    searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    searchBar.backgroundColor = .white
    searchBar.setCorner(14)
    
    if let textField = searchBar.value(forKey: "searchField") as? UITextField {
      
      textField.backgroundColor = .clear
      textField.textColor = theme.titleTextColor.withAlphaComponent(0.7)
      textField.font = FontManager.contactsFont(of: .searchBarFont)
      
      if let leftView = textField.leftView as? UIImageView {
        
        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
        leftView.tintColor = theme.titleTextColor.withAlphaComponent(0.7)
      }
    }
  }
  
  private func updateColors() {
    
    self.backgroundColor = theme.navigationBarBackgroundColor
    helperExtraView.backgroundColor = theme.navigationBarBackgroundColor
  }
}
