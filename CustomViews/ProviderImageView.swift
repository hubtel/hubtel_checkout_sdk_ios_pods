//
//  ProviderImageView.swift
//
//
//  Created by Mark Amoah on 6/16/23.
//

import UIKit

class ProviderImageView: UIImageView {
    

    init(imageName: String){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            image = imageNamed(imageName).withRenderingMode(.alwaysOriginal)
        }else{
            image = imageNamed(imageName).withRenderingMode(.alwaysOriginal)
        }
        
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installImage(imageString: String,showImage: Bool=true, useConstraints: Bool = true){
        if #available(iOS 13.0, *) {
            image = imageNamed(imageString)
        }else{
         image = imageNamed(imageString)
        }
        self.isHidden = !showImage
        
        if useConstraints{
            heightAnchor.constraint(equalToConstant: 18).isActive = true
            widthAnchor.constraint(equalToConstant: 26).isActive = true
        }else{
            heightAnchor.constraint(equalToConstant: 100).isActive = true
            widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }
    
    
    
}
