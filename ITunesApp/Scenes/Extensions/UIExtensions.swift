//
//  UIExtensions.swift
//  ITunesApp
//
//  Created by Вячеслав Макаров on 20.11.2021.
//

import UIKit

//  MARK:  Animations
extension UIView {
    
    func moveIn() {
        transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        alpha = 0.0
        isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.alpha = 1.0
        }
    }
    
    func moveInFromZero() {
        transform = CGAffineTransform(scaleX: 0, y: 0)
        alpha = 0.0
        isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.alpha = 1.0
        }
    }
    
    func moveOut(completionHandler: @escaping ()->() = {}) {
        
        transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        alpha = 1.0
        
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.alpha = 0.0
        } completion: { isFinished in
            self.isHidden = isFinished
            if isFinished {
                completionHandler()
            }
        }
    }
    
    func fadeIn() {
        alpha = 0.0
        isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
    }
    
    func fadeIn(completionHandler: @escaping ()->() = {}) {
        alpha = 0.0
        isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        } completion: { isFinished in
            if isFinished {
                completionHandler()
            }
        }
    }
    
    func fadeOut(completionHandler: @escaping ()->() = {}) {
        alpha = 1.0
    
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        } completion: { isFinished in
            self.isHidden = isFinished
            if isFinished {
                completionHandler()
            }
        }
    }
    
    func fadeInFromLeftSide(completionAnimation: @escaping ()->() = {}) {
        let targetCenter = center
        center = CGPoint(x: 0, y: targetCenter.y)
        alpha = 0.0
        isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.center = CGPoint(x: targetCenter.x, y: targetCenter.y)
            self?.alpha = 1.0
        } completion: { isFinished in
            if isFinished {
                completionAnimation()
            }
        }
    }
    
    func fadeOutToLeftSide(completionAnimation: @escaping ()->() = {}) {
        let targetCenter = center
        center = CGPoint(x: targetCenter.x, y: targetCenter.y)
        alpha = 1.0
        isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.center = CGPoint(x: 0, y: targetCenter.y)
            self?.alpha = 0.0
        } completion: { [weak self] isFinished in
            if isFinished {
                self?.isHidden = true
                self?.center = targetCenter
                completionAnimation()
            }
        }
    }
    
    func fadeInFromRightSide(completionAnimation: @escaping ()->() = {}) {
        let targetCenter = center
        center = CGPoint(x: frame.maxX, y: targetCenter.y)
        alpha = 0.0
        isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.center = CGPoint(x: targetCenter.x, y: targetCenter.y)
            self?.alpha = 1.0
        } completion: { isFinished in
            if isFinished {
                completionAnimation()
            }
        }
    }
    
    func fadeOutToRightSide(completionAnimation: @escaping ()->() = {}) {
        let targetCenter = center
        center = CGPoint(x: 0, y: targetCenter.y)
        alpha = 1.0
        isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let target = self else { return }
            self?.center = CGPoint(x: target.frame.maxX, y: targetCenter.y)
            self?.alpha = 0.0
        } completion: { isFinished in
            if isFinished {
                completionAnimation()
            }
        }
    }
}
