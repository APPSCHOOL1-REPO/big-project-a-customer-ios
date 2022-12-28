//
//  MyPageInfoEdit.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

// 비밀번호 체크 후 나오는 정보를 수정할 수 있는 뷰

struct MyPageInfoEditView: View {
    @StateObject var vm = MyPageViewModel()
    
    @State var newPassword = ""
    @State var checkPassword = ""
    
    @State var newAddress = ""
    
    @State var showingAlert = false
    
    var body: some View{
        VStack{
            Text("비밀 번호 수정")
                .font(.title)
            
            SecureField("Input new password.", text: $newPassword)
                .modifier(InputModifier())
            
            SecureField("One more time.", text: $checkPassword)
                .modifier(InputModifier())
            
            
            Button {
                print("변경버튼 클릭")
                
                /// 패스워드가 공백이거나, 엔터가 눌린 상태에서 변경 버튼이 눌리지 않게끔하는 조건을 걸고
                /// 그 안에 두 번 입력한 패스워드가 같을 경우 비밀번호 변경을 시행 가능하게 함
                if newPassword.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                    if newPassword == checkPassword {
                        vm.users.userPassward = newPassword
                        print("변경 완료: \(vm.users.userPassward)")
                    } else {
                        showingAlert = true
                    }
                }
                
            } label: {
                Text("비밀번호 변경")
                    .modifier(ConfirmModifier())
            }
            .padding(.bottom,20)
            
            
            Text("주소 변경하기")
                .font(.title)
            
            TextField("New Address", text: $newAddress)
                .modifier(InputModifier())
            
            Button {
                print("변경")
                
                if newAddress.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                    vm.users.userAddress = newAddress
                    print("변경완료: \(vm.users.userAddress)")
                    
                }
            } label: {
                Text("주소 변경")
                    .modifier(ConfirmModifier())
            }
        }
        .alert("비밀번호 불일치", isPresented: $showingAlert) {
            Button("Ok") {
                newPassword = ""
                checkPassword = ""
            }
        } message: {
            Text("비밀번호를 다시 입력해주세요")
        }
        
    }
}

struct MyPageInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoEditView()
    }
}