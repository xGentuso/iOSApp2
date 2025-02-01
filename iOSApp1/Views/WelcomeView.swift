import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: CoffeeOrderViewModel
    @Binding var selectedTab: Int  // Binding to the parent's selectedTab
    var logoutAction: () -> Void  // ✅ Added logoutAction closure
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.red.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Welcome to the Tim Hortons App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Text("Your daily coffee run made simpler.")
                    .font(.title3)
                    .padding(.horizontal, 30)
                
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                
                // MARK: - View Orders Button
                Button {
                    selectedTab = 1  // Switch to the Orders tab
                } label: {
                    Text("View Orders")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 180)
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                
                // MARK: - View Menu Button
                Button {
                    selectedTab = 2  // Switch to the Menu tab
                } label: {
                    Text("View Menu")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 180)
                        .background(Color.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: logoutAction) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 1)
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewModel: CoffeeOrderViewModel(), selectedTab: .constant(0), logoutAction: {})
    }
}
