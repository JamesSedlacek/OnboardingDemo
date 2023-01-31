
import SwiftUI

struct OnboardingView: View {
    let tabs: [OnboardingItem] = [OnboardingItem(image: Image.entriesTab,
                                                 title: "Entries Tab",
                                                 subtitle: "Track and Sort through your trades"),
                                  OnboardingItem(image: Image.statsTab,
                                                 title: "Stats Tab",
                                                 subtitle: "Get information about how you trade"),
                                  OnboardingItem(image: Image.calendarTab,
                                                 title: "Calendar Tab",
                                                 subtitle: "Visualize how you trade historically"),
                                  OnboardingItem(image: Image.moreTab,
                                                 title: "More Tab",
                                                 subtitle: "Everything else is here")]
    @State private var currentTab = 0
    let isOnboarding: Bool
    let onDismiss: () -> ()

    init(isOnboarding: Bool = true, onDismiss: @escaping () -> ()) {
        self.isOnboarding = isOnboarding
        self.onDismiss = onDismiss
    }

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            skipSection()
            mainSection()
            nextButton()
        }
        .padding(20)
        .animation(.spring(), value: currentTab)
    }

    private func skipSection() -> some View {
        return HStack {
            if currentTab > 0 {
                Button {
                    if currentTab > 0 {
                        currentTab -= 1
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            if currentTab < tabs.count - 1 {
                Button {
                    onDismiss()
                } label: {
                    Text("Skip")
                        .foregroundColor(.blue)
                }
            }
        }
    }

    private func nextButton() -> some View {
        return Button {
            if currentTab < tabs.count - 1 {
                
                currentTab += 1
                
            } else {
                onDismiss()
               
                
            }
        } label: {
            Text(currentTab < tabs.count - 1 ? "Next" : isOnboarding ? "Get Started" : "Done")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 24)
        }
    }

    private func mainSection() -> some View {

        return VStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .center) {
                screenshot()
                    .overlay(magnificationEffect(),alignment: .bottom)

            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .center, spacing: 16) {
                Text(tabs[currentTab].title)
                    .font(.system(size: 26, weight: .semibold))
                Text(tabs[currentTab].subtitle)
                    .foregroundColor(.secondary)
                    .font(.system(size: 18, weight: .medium))
            }.padding(.vertical, 20)
        }
    }

    private func screenshot() -> some View {
        return tabs[currentTab].image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.8), lineWidth: 2)
            )
            .cornerRadius(12)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onDismiss: {})
    }
}


extension OnboardingView {
    
    private func magnificationEffect() -> some View {
        
        ZStack {
            GeometryReader{ reader in
                let tabWidth: CGFloat = reader.size.width / 5
                let circleSize: CGSize = CGSize(width: tabWidth, height: tabWidth)
                let circleScale: CGFloat = 2.6
                let iconScale: CGFloat = 2.5
                HStack{
                    Image(systemName: "placeholdertext.fill")
                        .foregroundColor(Color.clear)
                        .overlay( currentTab == 0 ?
                                  Circle()
                            .strokeBorder(.black.opacity(0.6), lineWidth: 0.5)
                            .background(Circle().fill(.white))
                            .frame(width: circleSize.width, height: circleSize.width)
                            .scaleEffect(circleScale, anchor: .center)
                            .shadow(color: Color.black, radius: 4)
                            .overlay(
                                currentTab == 0 ?
                                VStack{
                                    Image(systemName: "doc.plaintext.fill")
                                        .scaleEffect(iconScale)
                                        .foregroundColor(.black)
                                    
                                    Text("Entries")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(.top)
                                }
                                    .frame(width: circleSize.width*2.5, height: circleSize.width*2.5)
                                    .background(Color.clear)
                                : nil )
                                  : nil , alignment: .center )
                        Spacer()
                        
                        
                        
                        Image(systemName: "placeholdertext.fill")
                        .foregroundColor(Color.clear)
                        .overlay( currentTab == 1 ?
                                  Circle()
                            .strokeBorder(.black.opacity(0.6), lineWidth: 0.5)
                            .background(Circle().fill(.white))
                            .frame(width: circleSize.width, height: circleSize.width)
                            .scaleEffect(circleScale, anchor: .center)
                            .shadow(color: Color.black, radius: 4)
                            .overlay(
                                currentTab == 1 ?
                                VStack{
                                    Image(systemName: "chart.line.uptrend.xyaxis")
                                        .scaleEffect(iconScale)
                                        .foregroundColor(.black)
                                    
                                    Text("Stats")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(.top)
                                }
                                    .frame(width: circleSize.width*2.5, height: circleSize.width*2.5)
                                    .background(Color.clear)
                                : nil )
                                  : nil , alignment: .center )
                        Spacer()
                        
                        
                    Image(systemName: "placeholdertext.fill")
                        .background(Color.clear)
                        .foregroundColor(Color.clear)
                        Spacer()
                    
                    Image(systemName: "placeholdertext.fill")
                        .foregroundColor(Color.clear)
                        .overlay( currentTab == 2 ?
                                  Circle()
                            .strokeBorder(.black.opacity(0.6), lineWidth: 0.5)
                            .background(Circle().fill(.white))
                            .frame(width: circleSize.width, height: circleSize.width)
                            .scaleEffect(circleScale, anchor: .center)
                            .shadow(color: Color.black, radius: 4)
                            .overlay(
                                currentTab == 2 ?
                                VStack{
                                    Image(systemName: "calendar")
                                        .scaleEffect(iconScale)
                                        .foregroundColor(.black)
                                    
                                    Text("Calendar")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(.top)
                                }
                                    .frame(width: circleSize.width*2.5, height: circleSize.width*2.5)
                                    .background(Color.clear)
                                
                                : nil)
                                  :nil ,alignment: .center )
                    Spacer()
                            
                    Image(systemName: "placeholdertext.fill")
                        .foregroundColor(Color.clear)
                        .overlay( currentTab == 3 ?
                                  Circle()
                            .strokeBorder(.black.opacity(0.6), lineWidth: 0.5)
                            .background(Circle().fill(.white))
                            .frame(width: circleSize.width, height: circleSize.width)
                            .scaleEffect(circleScale, anchor: .center)
                            .shadow(color: Color.black, radius: 4)
                            .overlay(
                                currentTab == 3 ?
                                
                                VStack{
                                    Image(systemName: "ellipsis")
                                        .scaleEffect(iconScale)
                                        .foregroundColor(Color.black)
                                    
                                    Text("More")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .padding(.top)
                                }
                                    .frame(width: circleSize.width*2.5, height: circleSize.width*2.5)
                                    .background(Color.clear)
                                : nil )
                                  :nil ,alignment: .center)
                    }
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(Color.clear)
                .frame(height: reader.size.height / 0.53)
            }
        }
    }
}
