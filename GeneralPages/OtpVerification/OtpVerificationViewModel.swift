//
//  File.swift
//  
//
//  Created by Mark Amoah on 9/17/23.
//

import Foundation




class OtpRequestViewModel: CheckoutRequirements{
    
    weak var delegate: ViewStatesDelegate?
    
    init(delegate: ViewStatesDelegate){
        self.delegate = delegate
    }
    
    func handleApiResponseForPreApprovalConfirm(value: ApiResponse<OtpResponse?>?){
        guard let data = value else {
            self.delegate?.showErrorMessagetToUser?(message: MyError.someThingHappened.message)
            return
        }
        
       
        guard let responseObject  = data.data else {
            self.delegate?.showErrorMessagetToUser?(message: data.message ?? "")
            return
        }
       
        self.delegate?.dismissLoaderToPerformMomoPayment?()
    }
    
    func handleOtpResponse(value: ApiResponse<OtpResponseModel?>?){
        
        print(value)
        guard let data = value else {
            self.delegate?.showErrorMessagetToUser?(message: MyError.someThingHappened.message)
            return
        }
        
        
        if data.code == 200 {
            DispatchQueue.main.async {
                self.delegate?.dismissLoaderForReceiveMoney?()
            }
            return
        }
        guard let responseObject  = data.data else {
            self.delegate?.showErrorMessagetToUser?(message: data.message ?? "")
            return
        }
        DispatchQueue.main.async{
            self.delegate?.dismissLoaderForReceiveMoney?()
        }
        
    }
    
    
    func makeotpVerification(body: OtpBodyRequest){
        
        delegate?.showLoadingStateWhileMakingNetworkRequest?(with: true)
        NetworkManager.makeVerifyOtpRequest(merchantId: salesID ?? "", authKey: merchantApiKey ?? "", body: body) { data, error in
            
            
            guard error == nil else {
                DispatchQueue.main.async {
                    self.delegate?.showErrorMessagetToUser?(message: MyError.someThingHappened.message)
                }
                return
            }
            
            guard let data = data  else {
                DispatchQueue.main.async {
                    self.delegate?.showErrorMessagetToUser?(message: MyError.someThingHappened.message)
                    self.delegate?.showLoaderOnBottomButtonIfNeeded?(with: false)
                }
                return
            }
            
            let decodedData = NetworkManager.decode(data: data, decodingType: ApiResponse<OtpResponse?>.self)
            
            self.handleApiResponseForPreApprovalConfirm(value: decodedData)
            
        }
    }
    
    func makeMomoOtpRequest(body: VerifyMomoRequest){
        
        delegate?.showLoadingStateWhileMakingNetworkRequest?(with: true)
        NetworkManager.verifyMomoOtp(salesID: salesID ?? "", authKey: merchantApiKey ?? "", requestBody: body) { data, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    self.delegate?.showErrorMessagetToUser?(message: MyError.someThingHappened.message)
                }
                return
            }
            
            guard let data = data  else {
                DispatchQueue.main.async {
                    self.delegate?.showErrorMessagetToUser?(message: MyError.someThingHappened.message)
                    self.delegate?.showLoaderOnBottomButtonIfNeeded?(with: false)
                }
                return
            }
            
            let decodedData = NetworkManager.decode(data: data, decodingType: ApiResponse<OtpResponseModel?>.self)
            
            self.handleOtpResponse(value: decodedData)
            
        }
    }
    
    
    
}
