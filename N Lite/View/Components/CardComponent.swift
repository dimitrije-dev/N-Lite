import SwiftUI

struct CardComponent: View {
    
    let title: String
    let descrription: String
    let iconImage : String
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.secondaryColorCustom)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: iconImage)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.textColorCustom)
                        .font(.largeTitle)
                    

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.textColorCustom)
                        Text(descrription)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(10)
        }
        .frame(height: 150)
        .padding()
    }
}

#Preview {
    CardComponent(title: "Glassmorphism Card", descrription: "Beautiful frosted glass effect" , iconImage: "person.crop.circle")
}
