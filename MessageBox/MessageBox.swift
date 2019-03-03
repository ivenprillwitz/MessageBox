//
//  MessageBox.swift
//  MessageBox
//
//  Created by Iven Prillwitz on 03.03.19.
//  Copyright © 2019 Iven Prillwitz. All rights reserved.
//

import UIKit

class MessageBox: UIView {
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let textView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textContainer.heightTracksTextView = true
        textview.isScrollEnabled = false
        textview.layer.cornerRadius = 15
        textview.layer.borderColor = UIColor.lightGray.cgColor
        textview.layer.borderWidth = 1
        textview.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textview
    }()
    fileprivate var leftButton: UIButton
    fileprivate var rightButton: UIButton
    fileprivate var textViewRightAnchor =  NSLayoutConstraint()
    
    init(_ leftButton: UIButton, _ rightButton: UIButton) {
        self.leftButton = leftButton
        self.rightButton = rightButton
        super.init(frame:.zero)
        
        // Set default Values & Constraints
        backgroundColor = .white
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.alpha = 0
        
        //ContainerView
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //RightButton
        containerView.addSubview(rightButton)
        rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        //TextView
        containerView.addSubview(textView)
        textView.delegate = self
        textView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 50).isActive = true
        textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 11).isActive = true
        textViewRightAnchor = textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12)
        textViewRightAnchor.isActive = true
        textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11).isActive = true
        
        //LeftButton
        containerView.addSubview(leftButton)
        leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        leftButton.rightAnchor.constraint(equalTo: textView.leftAnchor, constant: -8).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension MessageBox : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let timeinterval = TimeInterval(exactly: 0.3) ?? 0
        if textView.text.count > 0 {
            UIView.animate(withDuration: timeinterval, delay: 0, options: .curveEaseOut, animations: {
                self.textViewRightAnchor.constant = -50
                self.containerView.layoutIfNeeded()
            }, completion: { finished in
                UIView.animate(withDuration: timeinterval + 0.5, animations: {
                    self.rightButton.alpha = 1
                    self.containerView.layoutIfNeeded()
                })
            })
        } else {
            UIView.animate(withDuration: timeinterval, delay: 0, options: .curveEaseOut, animations: {
                self.rightButton.alpha = 0
                self.containerView.layoutIfNeeded()
            }, completion: { finished in
                UIView.animate(withDuration: timeinterval, delay: 0, options: .curveEaseOut, animations: {
                    self.textViewRightAnchor.constant = -12
                    self.containerView.layoutIfNeeded()
                }, completion: nil)
            })
        }
        
        let width = textView.frame.width
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let newSize = textView.sizeThatFits(size)
        textView.frame.size = CGSize(width: max(newSize.width, width), height: newSize.height)
    }
}
