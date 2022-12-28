//
//  MyPageInfo.swift
//  MyPageView
//
//  Created by greenthings on 2022/12/27.
//

import SwiftUI

// 마이페이지 탭을 누르면 보이는 -> 마이페이지가 시작되는 뷰

struct MyPageInfoView: View {
    
    @StateObject var vm = MyPageViewModel()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    //더미 데이터
    var sampleActions = ["좋아요", "구매내역", "쿠폰함", "작성한 리뷰", "작성한 문의 글", "최근 본 상품"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    // 유저 이름
                    Text(vm.users.name)
                        .modifier(NameModifier())
                    Text("반갑습니다")
                        .modifier(SayHelloModifier())
                    Spacer()
                    NavigationLink {
                        MyPageInfoDetailView()
                    } label: {
                        // 내 정보 관리로 이어지는 링크
                        Text("설정")
                    }
                }
                .padding(30)
                Text("혜택")
                    .modifier(GiftModifier())
               
                    
                // 좋아요, 구매내역, 쿠폰함 등 이후 다른 뷰들과 연결될 그리드
                LazyVGrid(columns: columns, spacing: 0) {
                    //뷰들과 연결되면 ForEach문은 없앨 예정
                    ForEach(sampleActions, id: \.self) { action in
                        // 더미 데이터들
                            NavigationLink {
                                Text(action)
                            } label: {
                                ZStack {
                                    Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                                        .cornerRadius(15)
                                        .frame(width: 120, height: 100)
                                        .padding()
                                Text(action)
                                    .foregroundColor(.accentColor)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
                //목업 상태
                List {
                    Label("주문목록", systemImage: "star")
                    Label("취소, 반품, 교환목록", systemImage: "star")
                    Label("리뷰관리", systemImage: "star")
                }
                .listStyle(.plain)
            }
            //        .padding()
        }
    }
    
}

struct MyPageInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageInfoView()
    }
}
