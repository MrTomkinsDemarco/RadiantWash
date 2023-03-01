//
//  DateSelectebleView.swift
//  RadiantWash
//
//  Created by Mac Mini on 21.02.2023.
//

import UIKit

protocol DateSelectebleViewDelegate {
  func didSelectStartingDate()
  func didSelectEndingDate()
}

class DateSelectebleView: UIView {
  
  @IBOutlet weak var dateSelectContainerView: UIView!
  @IBOutlet weak var contentStackView: UIStackView!
  @IBOutlet weak var startingDateTitileTextLabel: UILabel!
  @IBOutlet weak var endingDateTitleTextLabel: UILabel!
  @IBOutlet weak var startingDateTextLabel: UILabel!
  @IBOutlet weak var endingDateTextLabel: UILabel!
  
  private var margingsSize: CGFloat = 20
  private var topAcnhorMarging: CGFloat {
    switch Screen.size {
    case .small, .medium:
      return -5
    default:
      return 5
    }
  }
  
  private var containerHeight: CGFloat {
    switch Screen.size {
    case .small:
      return 50
    default:
      return 60
    }
  }
  
  var delegate: DateSelectebleViewDelegate?
  
  private var startingDate: String = ""
  private var endingDate: String = ""
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupUI()
    setupAppearance()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    commonInit()
  }
  
  @IBAction func didTapSelectStartDateActionButton(_ sender: Any) {
    
    delegate?.didSelectStartingDate()
  }
  
  @IBAction func didTapSelectEndDateActionButton(_ sender: Any) {
    
    delegate?.didSelectEndingDate()
  }
  
  private func commonInit() {
    
    U.mainBundle.loadNibNamed(C.identifiers.xibs.datePickerContainer, owner: self, options: nil)
    
    dateSelectContainerView.backgroundColor = Theme.light.cellBackGroundColor//theme.innerBackgroundColor
    dateSelectContainerView.clipsToBounds = true
    dateSelectContainerView.layer.cornerRadius = 14
    
    self.addSubview(self.dateSelectContainerView)
    self.dateSelectContainerView.translatesAutoresizingMaskIntoConstraints = false
    
    let margins = self.safeAreaLayoutGuide
    dateSelectContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: margingsSize).isActive = true
    dateSelectContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -margingsSize).isActive = true
    dateSelectContainerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: topAcnhorMarging).isActive = true
    dateSelectContainerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
    dateSelectContainerView.layer.masksToBounds = true
  }
  
  public func setupDisplaysDate(lowerDate: Date, upperdDate: Date) {
    
    startingDateTextLabel.text = String("\(lowerDate.stringMonth()) \(lowerDate.getYear())").uppercased()
    endingDateTextLabel.text = String("\(upperdDate.stringMonth()) \(upperdDate.getYear())").uppercased()
  }
  
  private func setupUI() {
    
    startingDateTitileTextLabel.text = Localization.Main.Subtitles.from
    endingDateTitleTextLabel.text = Localization.Main.Subtitles.to
    
    switch Screen.size {
    case .small:
      startingDateTextLabel.font = .systemFont(ofSize: 12, weight: .medium)
      endingDateTextLabel.font = .systemFont(ofSize: 12, weight: .medium)
      startingDateTitileTextLabel.font = .systemFont(ofSize: 11, weight: .bold)
      endingDateTitleTextLabel.font = .systemFont(ofSize: 11, weight: .bold)
    case .medium, .plus:
      startingDateTextLabel.font = .systemFont(ofSize: 15, weight: .medium)
      endingDateTextLabel.font = .systemFont(ofSize: 15, weight: .medium)
      startingDateTitileTextLabel.font = .systemFont(ofSize: 13, weight: .bold)
      endingDateTitleTextLabel.font = .systemFont(ofSize: 13, weight: .bold)
      
    case .large, .modern, .pro, .max, .madMax, .proMax:
      startingDateTextLabel.font = .systemFont(ofSize: 16, weight: .medium)
      endingDateTextLabel.font = .systemFont(ofSize: 16, weight: .medium)
      startingDateTitileTextLabel.font = .systemFont(ofSize: 14, weight: .bold)
      endingDateTitleTextLabel.font = .systemFont(ofSize: 14, weight: .bold)
    }
  }
  
  private func setupAppearance() {
    
    startingDateTextLabel.textColor = theme.titleTextColor.withAlphaComponent(0.7)
    endingDateTextLabel.textColor = theme.titleTextColor.withAlphaComponent(0.7)
    
    startingDateTitileTextLabel.textColor = theme.titleTextColor.withAlphaComponent(0.5)
    endingDateTitleTextLabel.textColor = theme.titleTextColor.withAlphaComponent(0.5)
  }
}
