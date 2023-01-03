////
////  MyPageShoppingListView.swift
////  big-project-a-customer-ios
////
////  Created by greenthings on 2022/12/28.
////
//
//import SwiftUI
//
//
//struct MyPageShoppingItem {
////접수일: Timestamp < 작성
////주문번호: String <- 받기
////상품id <- 받기
////문의제목: String < 작성
////문의내용: String < 작성
////문의id:String < UUID
//    var userId: String//질문자id: String < CurrentUser
//    var nickName : String//질문자: String CurrentUser
//    var date: String//DateFormatter
//    var itemName: String
//    var purchaseDate: String
//}
//
//struct MyPageShoppingListView: View {
//    
//    @Binding var isShowingShoppinglist: Bool
//    @Binding var myShoppingList: [String]
//    @Binding var selectItem: (image: String, name: String)?
//    @State var checked: Bool = false
//    
//    var body: some View {
//        List{
//            VStack{
//                ForEach($myShoppingList, id: \.self) { item in
//                    MyPageShoppingListRowView(item: item, checked: $checked, isShowingShoppinglist: $isShowingShoppinglist, selectItem: $selectItem)
//                }
//                Spacer()
//            }
//            
//        
//        }
//        .listStyle(.inset)
//        
//        VStack{
//            if checked{
//                Button {
//                    print("확인")
//                    isShowingShoppinglist.toggle()
//                } label: {
//                    Text("확인")
//                        .frame(width:300, height: 100)
//                }
//                
//            }
//        }
//    }
//
//    
//    
//    struct MyPageShoppingListRowView: View{
//        
//        @Binding var item: String
//        @Binding var checked: Bool
//        @Binding var isShowingShoppinglist: Bool
//        @Binding var selectItem: (image: String, name: String)?
//
//        var body: some View{
//            
//            VStack{
//                
//                Text(checked ? "주문일: 2022.12.22" : "")
//                
//                HStack{
//                    
//                    Image(systemName: checked ? "checkmark.square.fill" : "square")
//                        .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
//                        .onTapGesture {
//                            self.checked.toggle()
//                            selectItem = (image: "itemImage", name: "ipTIME 외장케이스 WHITE HDD 3135 Plus")
//                        }
//                    
//                    
//                    Image("itemImage")
//                        .ImageResizeModifier()
//                    
//                    
//                    VStack{
//                        Text("ipTIME 외장케이스 WHITE HDD 3135 Plus")
//                            .bold()
//                        
//                        HStack{
//                            Text("29400원")
//                                .font(.caption)
//                            Spacer()
//                            Text("1개")
//                                .font(.caption)
//                        }
//                        .foregroundColor(.gray)
//
//                    }
//                    
//                    
//                }
//                .frame(width: 350, height: 100)
//                .padding(10)
//                
//                
//            //Divider()
//                
//            }
//            
//            
//        }
//    }
//    
//    struct MyPageShoppingListView_Previews: PreviewProvider {
//        static var previews: some View {
//            MyPageShoppingListView(isShowingShoppinglist: .constant(false), myShoppingList: .constant(["Mac"]), selectItem: .constant(nil))
//        }
//    }
//    
//}


//
//  PurchaseHistoryView.swift
//  MyPageLike
//
//  Created by 이민경 on 2022/12/27.
//


import SwiftUI
import PopupView

// 재사용
//struct OrderInfo: Identifiable {
//    var id = UUID().uuidString
//    var orderDate: String
//    var itemAmount: Int
//    var price: Int
//    var deliveryStatusText: String
//    var itemName: String
//    var itemImage: String
//    var deliveryStatus: DeliveryStatusEnum = .pending
//}
//
//class OrderInfoViewModel: ObservableObject {
//    // ShoppingCartItems 약자
//    @Published var orders: [OrderInfo] = [
//        OrderInfo(orderDate: "2022. 12. 27", itemAmount: 1, price: 24900, deliveryStatusText: "배송중", itemName: "유그린 메탈쉘 외장하드 케이스 C to USB3.0", itemImage: "itemImage"),
//        OrderInfo(orderDate: "2022. 11. 30", itemAmount: 1, price: 24900, deliveryStatusText: "배송완료", itemName: "벨킨 부스트업 24W 듀얼 A타입 가정용 충전기 WCB002krWH, 화이트", itemImage: "itemImage", deliveryStatus: .deliveryCompleted),
//        OrderInfo(orderDate: "2022. 11. 28", itemAmount: 1, price: 66400, deliveryStatusText: "배송완료", itemName: "벨킨 7in1 USB C타입 멀티 허브 AVC009btSGY, 그레이", itemImage: "itemImage", deliveryStatus: .createReview),
//        OrderInfo(orderDate: "2022. 09. 30", itemAmount: 1, price: 34900, deliveryStatusText: "배송완료", itemName: "트리플블랙 RX 4in1 충전 스테이션, 블랙", itemImage: "itemImage", deliveryStatus: .deliveryCompleted),
//        OrderInfo(orderDate: "2022. 09.30", itemAmount: 1, price: 20800, deliveryStatusText: "배송완료", itemName: "벨킨 부스트업 USB C to 라이트닝 아이폰 고속 충전케이블 CAA003bt1MBK, 1m, 블랙", itemImage: "itemImage", deliveryStatus: .deliveryCompleted)
//    ]
//}

// MARK: 전체 구매목록
struct MyPageShoppingListView: View {
    @ObservedObject var orderStore: OrderInfoViewModel = OrderInfoViewModel()
    @State private var searchItem = ""
    @State private var deliveryCompletedChecked = false
    
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    @Binding var isShowingShoppinglist: Bool

    
    var body: some View {
        NavigationStack {
            
            VStack {

                HStack{
                    Spacer()
                    Button{
                        isShowingShoppinglist.toggle()
                    } label: {
                        Text("확인")
                    }
                }
                .padding()
                
                ScrollView {

                    ForEach(Array(orderStore.orders.enumerated()), id: \.offset){ (index, order) in
                        VStack {
                            MyShoppingListCell(orderStore: orderStore, order: order, index: index, isDeliveryCompleted: $deliveryCompletedChecked, isShowingShoppinglist: $isShowingShoppinglist) // 프로퍼티 추가해줌
                        }
                        .padding(10)
                    }
                }
                
            } // VStack

            

        }
    }
}
// MARK: 재사용하기 위한 구매목록 cell
struct MyShoppingListCell: View {
    @ObservedObject var orderStore: OrderInfoViewModel
    var order: OrderInfo
    let index: Int
    @Binding var isDeliveryCompleted: Bool
    
    @Binding var isShowingShoppinglist : Bool
    
    @State var checked: Bool = false
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(order.deliveryStatusText)")
                    .font(.headline)
                Spacer()
                
            }
            HStack(alignment: .center){
                
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                    .onTapGesture {
                        self.checked.toggle()
                        // 1안 - itemID 만 넘겨주기
                        // 2안 - itemID 및 item 데이터도 같이 넘겨주기
                        // 상위 뷰로 넘겨줄 때 사용할 방법...
                        
                    }
                Image(order.itemImage)
                    .ImageResizeModifier()
                VStack(spacing: 10){
                    Text("\(order.itemName)")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.callout)
                    HStack{
                        Text("\(order.price)원")
                            .font(.caption)
                        Text("\(order.itemAmount)개")
                            .font(.caption)
                        Spacer()
                        
                    }
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }

        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .modifier(PurchaseHistoryButtonModifier())
    }
}

//struct MyPageShoppingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPageShoppingListView()
//    }
//}
