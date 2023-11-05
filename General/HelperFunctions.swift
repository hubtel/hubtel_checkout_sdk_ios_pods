//
//  HelperFunctions.swift
//  hubtel_merchant_checkout_sdk
//
//  Created by Mark Amoah on 11/4/23.
//

import Foundation


func imageNamed(_ name: String) -> UIImage {
  let cls = CheckoutViewController.self
  var bundle = Bundle(for: cls)
  let traitCollection = UITraitCollection(displayScale: 3)
  
    print(bundle)
  if let resourceBundle = bundle.resourcePath.flatMap({ Bundle(path: $0 + "/hubtel_merchant_checkout_sdk.bundle") }) {
      
    bundle = resourceBundle
  }
    

  guard let image = UIImage(named: name, in: bundle, compatibleWith: traitCollection) else {
    return UIImage()
  }

  return image
}
