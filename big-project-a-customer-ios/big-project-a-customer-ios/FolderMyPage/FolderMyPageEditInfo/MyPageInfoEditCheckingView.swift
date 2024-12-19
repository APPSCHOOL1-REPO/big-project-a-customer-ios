//
//  MyPageInfoEditChecking.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

//회원정보 수정을 누르면 보이는 -> 비밀번호 체크 뷰

struct MyPageInfoEditCheckingView: View {
    
    @EnvironmentObject private var signupViewModel: SignUpViewModel
    @State var showingAlert = false
    @State var password = ""
    @State var isLogedIn = false
    @FocusState var isInFocusPassword: Bool
    
    @Binding var navStack: NavigationPath
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                Text("회원정보확인")
                    .bold()
                Text("정보를 안전하게 보호하기 위해 다시 한번 입력해주세요.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Image(systemName: "mail")
                        // 유저 이메일
                        Text(signupViewModel.currentUser?.userEmail ?? "이메일")
                    }
                    
                    HStack{
                        Image(systemName: "key")
                            .padding(.horizontal, 3)
                        VStack {
                            SecureField("Password", text: $password)
                            Rectangle()
                                .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusPassword, padding: 0))
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            
            // 입력한 비밀번호가 일치할 시 네비게이션 링크를 보여주고,
            // 불일치할 시 버튼을 보여주고, alert를 띄운다
            Button {
                Task {
                    // 로그인 성공 유무에 따라 Bool값을 return하는 reAuthLoginIn을 사용하여 비밀번호가 맞는지 확인
                    isLogedIn = await signupViewModel.reAuthLoginIn(withEmail: signupViewModel.currentUser?.userEmail ?? "", withPassword: password)
                    showingAlert = !isLogedIn
                }
            } label: {
                Text("확인")
                    .frame(width: 330)
                    .modifier(ColoredButtonModifier(cornerRadius: 10))
            }
            .navigationDestination(isPresented: $isLogedIn) {
                MyPageInfoEditView(navStack: $navStack)
            }
            .padding(.top, 10)
            
            Spacer()
            
        }
        // 비밀번호 체크 후 일치하지 않을 시 나오는 alert
        .modifier(PasswordAlertModifier(showingAlert: $showingAlert, password: $password, password_2: $password))
        .navigationBarTitle("회원정보 수정")
        
    }
}

struct MyPageInfoEditCheckingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPageInfoEditCheckingView(navStack: .constant(NavigationPath()))
                .environmentObject(SignUpViewModel())
        }
    }
}
