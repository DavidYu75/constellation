import SwiftUI

@main
struct SocialConstellationApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .preferredColorScheme(.dark)
                .onAppear {
                    dataController.initialize()
                }
        }
    }
}

// MARK: - Main Content View
struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @State private var showPermissionView = true
    @State private var galaxyRevealed = false
    
    var body: some View {
        ZStack {
            // Deep space background
            SpaceBackgroundView()
            
            if dataController.hasContactsPermission {
                // Main galaxy visualization
                GalaxyView()
                    .opacity(galaxyRevealed ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.0)) {
                            galaxyRevealed = true
                        }
                    }
            } else if showPermissionView {
                // Permission request
                PermissionRequestView(
                    onAllow: {
                        Task {
                            await dataController.requestContactsPermission()
                            showPermissionView = false
                        }
                    },
                    onSkip: {
                        // Demo mode with sample data
                        dataController.loadDemoData()
                        showPermissionView = false
                    }
                )
            }
        }
    }
}

// MARK: - Space Background
struct SpaceBackgroundView: View {
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.05, blue: 0.15),
                    Color(red: 0.11, green: 0.08, blue: 0.39),
                    Color(red: 0.18, green: 0.23, blue: 0.40)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Animated star particles
            GeometryReader { geometry in
                ForEach(0..<50, id: \.self) { _ in
                    StarParticle()
                        .position(
                            x: .random(in: 0...geometry.size.width),
                            y: .random(in: 0...geometry.size.height)
                        )
                }
            }
        }
    }
}

// MARK: - Star Particle
struct StarParticle: View {
    @State private var opacity: Double = Double.random(in: 0.1...0.3)
    @State private var scale: CGFloat = CGFloat.random(in: 0.5...1.5)
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 2, height: 2)
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut(duration: Double.random(in: 2...5)).repeatForever(autoreverses: true)) {
                    opacity = Double.random(in: 0.3...0.7)
                    scale = CGFloat.random(in: 0.8...2.0)
                }
            }
    }
}

// MARK: - Permission Request View
struct PermissionRequestView: View {
    let onAllow: () -> Void
    let onSkip: () -> Void
    @State private var animateIcon = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Animated icon
            Image(systemName: "sparkles")
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .rotationEffect(.degrees(animateIcon ? 10 : -10))
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        animateIcon = true
                    }
                }
            
            Text("Constellation")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Transform your relationships into\na living galaxy of stars")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: onAllow) {
                    Label("Use My Contacts", systemImage: "person.2.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: onSkip) {
                    Text("Try Demo Galaxy")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
        }
    }
}

// MARK: - Galaxy View
struct GalaxyView: View {
    @EnvironmentObject var dataController: DataController
    @State private var selectedStar: Star?
    @State private var zoomScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Stars
            ForEach(dataController.stars) { star in
                StarView(
                    star: star,
                    isSelected: selectedStar?.id == star.id
                )
                .position(star.position)
                .scaleEffect(zoomScale)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedStar = star
                    }
                }
            }
            
            // Selected star info
            if let star = selectedStar {
                VStack {
                    Spacer()
                    StarInfoCard(star: star)
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    zoomScale = min(max(value, 0.5), 3.0)
                }
        )
    }
}

// MARK: - Individual Star View
struct StarView: View {
    let star: Star
    let isSelected: Bool
    @State private var isPulsing = false
    
    var body: some View {
        ZStack {
            // Glow effect
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            star.color.opacity(star.brightness * 0.5),
                            star.color.opacity(0)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: star.glowRadius
                    )
                )
                .frame(width: star.size * 3, height: star.size * 3)
            
            // Star core
            Circle()
                .fill(star.color)
                .frame(width: star.size, height: star.size)
                .opacity(star.brightness)
                .scaleEffect(isPulsing ? 1.2 : 1.0)
                .scaleEffect(isSelected ? 1.5 : 1.0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: star.pulseSpeed).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
        }
    }
}

// MARK: - Star Info Card
struct StarInfoCard: View {
    let star: Star
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(star.color.opacity(0.3))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Text(star.initials)
                            .font(.headline)
                            .foregroundColor(star.color)
                    )
                
                VStack(alignment: .leading) {
                    Text(star.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("\(star.daysSinceContact) days ago")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Button(action: { /* Reconnect action */ }) {
                    Image(systemName: "message.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.purple)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

// MARK: - Data Models
struct Star: Identifiable {
    let id = UUID()
    let name: String
    let initials: String
    let position: CGPoint
    let size: CGFloat
    let color: Color
    let brightness: Double
    let glowRadius: CGFloat
    let pulseSpeed: Double
    let daysSinceContact: Int
    let relationshipType: RelationshipType
    
    enum RelationshipType {
        case family, closeFriend, friend, colleague, acquaintance
        
        var color: Color {
            switch self {
            case .family: return .yellow
            case .closeFriend: return .blue
            case .friend: return .cyan
            case .colleague: return .gray
            case .acquaintance: return .white.opacity(0.7)
            }
        }
    }
}

// MARK: - Data Controller
@MainActor
class DataController: ObservableObject {
    @Published var stars: [Star] = []
    @Published var hasContactsPermission = false
    
    func initialize() {
        // Check for existing permissions
    }
    
    func requestContactsPermission() async {
        // In a real app, request contacts permission
        // For now, load demo data
        loadDemoData()
        hasContactsPermission = true
    }
    
    func loadDemoData() {
        // Create sample galaxy
        let sampleNames: [(String, Star.RelationshipType, Int)] = [
            ("Alex Johnson", .family, 2),
            ("Sam Chen", .closeFriend, 5),
            ("Jordan Williams", .friend, 15),
            ("Taylor Davis", .friend, 30),
            ("Morgan Lee", .colleague, 45),
            ("Casey Brown", .acquaintance, 90),
            ("Riley Smith", .friend, 20),
            ("Avery Wilson", .closeFriend, 7)
        ]
        
        let centerX = UIScreen.main.bounds.width / 2
        let centerY = UIScreen.main.bounds.height / 2
        
        stars = sampleNames.enumerated().map { index, data in
            let angle = (Double(index) / Double(sampleNames.count)) * .pi * 2
            let distance = 50.0 + (Double(data.2) * 3.0) // Distance based on days
            
            return Star(
                name: data.0,
                initials: String(data.0.split(separator: " ").compactMap { $0.first }),
                position: CGPoint(
                    x: centerX + cos(angle) * distance,
                    y: centerY + sin(angle) * distance
                ),
                size: data.1 == .family ? 20 : data.1 == .closeFriend ? 16 : 12,
                color: data.1.color,
                brightness: max(0.3, 1.0 - (Double(data.2) / 100.0)),
                glowRadius: data.1 == .family ? 30 : 20,
                pulseSpeed: 2.0 + Double(data.2) / 30.0,
                daysSinceContact: data.2,
                relationshipType: data.1
            )
        }
        
        hasContactsPermission = true
    }
}
