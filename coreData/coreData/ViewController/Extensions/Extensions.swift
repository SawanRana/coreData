//
//  Extensions.swift
//  coreData
//
//  Created by Sawan Rana on 14/01/23.
//

import Foundation
import UIKit

extension CoreEmployee {
    
    func makeEmployee() -> Employee {
        return Employee(id: id ?? UUID(), name: name ?? "", age: age, email: email ?? "", dl: toDrivingLicense?.makeDL())
    }
}

extension CoreDrivingLicense {
    func makeDL() -> DL {
        return DL(id: id ?? UUID(), drivingLicenseId: drivingLicenseId ?? "", placeOdfIssue: placeOfIssue ?? "", name: toEmployee?.name ?? "")
    }
}

extension UIView {
    
    @discardableResult
    func setupGradient(_ colors: [UIColor] ) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
