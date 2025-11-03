import SwiftUI

struct CardComponent: View {
    
    let title: String
    let description: String
    let iconImage : String
    var gradientColors : [Color] = [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]
    var isPressed: Bool = false
    
    
    
    var body: some View {
        HStack(spacing: 16){
            ZStack{
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: 50,height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 15,style: .continuous))
                Image(systemName: iconImage)
                    .font(.system(size: 22 ,weight: .semibold))
                    .foregroundStyle(Color.textColorCustom)
            }
            
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.system(size:22, weight: .semibold , design: .rounded))
                    .foregroundStyle(.primary)
                Text(description)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                
                
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)

        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20 , style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(
                    color: Color.black.opacity(0.06),
                    radius: isPressed ? 2 : 9,
                    x:0,
                    y: isPressed ? 1 : 4
                    
                )
        )
        .scaleEffect(isPressed ? 0.90: 1.0)
    }
}

#Preview {
    CardComponent(title: "Glassmorphism Card", description: "Beautiful frosted glass effect" , iconImage: "person.crop.circle")
}
