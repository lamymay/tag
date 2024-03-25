import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var store :Store
    
    var body: some View {
        MainView()
//        if store.loginOK {
//            MainView()
//        }else{
//            
//             LoginView()
// 
//        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
