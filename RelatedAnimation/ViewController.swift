//
//  ViewController.swift
//  RelatedAnimation
//
//  Created by Андрей Фроленков on 7.05.23.
//

import UIKit

class ViewController: UIViewController {
  
  lazy var squareView: UIView = {
    let squareView = UIView()
    squareView.layer.backgroundColor = UIColor.systemBlue.cgColor
    squareView.layer.cornerRadius = 10
    return squareView
  }()
  
  lazy var sliderMove: UISlider = {
    let sliderMove = UISlider()
    sliderMove.minimumValue = 0
    sliderMove.maximumValue = 1.0
    sliderMove.isContinuous = true
    return sliderMove
  }()
  
  let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut)
  
  
  let angle: CGFloat = (90.0 * 3.14/180.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animator.addAnimations {
      self.squareView.transform = CGAffineTransform(rotationAngle: self.angle).scaledBy(x: 1.5, y: 1.5)

      self.squareView.center.x += self.view.frame.width - self.squareView.bounds.width - self.view.layoutMargins.right * 3
    }
    
    
    setupConstraints()
    sliderMove.addTarget(self, action: #selector(moveSquareView), for: .valueChanged)
    sliderMove.addTarget(self, action: #selector(animateView), for: .touchUpInside)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @objc func animateView() {
    if animator.isRunning {
      sliderMove.value = Float(animator.fractionComplete)
    }
    
    sliderMove.setValue(sliderMove.maximumValue, animated: true)
    animator.startAnimation()
    animator.pausesOnCompletion = true
  }
  
  @objc func moveSquareView(sender: UISlider) {
    
    animator.fractionComplete = CGFloat(sender.value)
    
  }
  
  private func setupConstraints() {
    
    squareView.translatesAutoresizingMaskIntoConstraints = false
    sliderMove.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(squareView)
    view.addSubview(sliderMove)
    
    NSLayoutConstraint.activate([
      squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
      squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      squareView.heightAnchor.constraint(equalToConstant: 70),
      squareView.widthAnchor.constraint(equalToConstant: 70),
      
      sliderMove.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 40),
      sliderMove.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      sliderMove.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      
    ])
    
  }
  
  
  
  
}

