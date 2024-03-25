
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var store :Store
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Text("登录｜Login")
            
            Form {
                TextField("用户名", text: $username)
                SecureField("密码", text: $password)
                
                Button(action: {
                    print("您输入的用户名是:\(username)")
                    print("您输入的密码是:\(password)")
                    store.loginOK=true
                }, label: {
                    Text("登录")
                })
            }
        }
    }
}
