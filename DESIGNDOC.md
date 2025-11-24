# Social Constellation - Design Document
## Swift Student Challenge 2025

---

## Executive Summary

**App Name:** Social Constellation  
**Platform:** iOS (Swift Playgrounds 4.6+ / Xcode 26+)  
**Experience Duration:** 3 minutes  
**File Size:** Under 25 MB  
**Language:** English  

**One-Line Pitch:** Transform your relationships into a living galaxy where each person becomes a star whose brightness reflects your connection strength.

**Problem Statement:** In our digital age, it's easy to lose track of meaningful relationships. We get busy, forget to reach out, and suddenly realize months have passed since talking to people we care about.

**Solution:** Social Constellation creates a beautiful, non-judgmental visualization of your social universe that gently encourages reconnection through wonder rather than guilt.

---

## Design Principles

### Core Values
1. **Privacy First** - All processing on-device, no data sharing
2. **Non-Judgmental** - Encourage, don't shame
3. **Beauty in Simplicity** - Every galaxy is beautiful, regardless of size
4. **Emotional Resonance** - Create moments of reflection and warmth
5. **Immediate Understanding** - No tutorial needed

### What This App Is NOT
- Not a social media platform
- Not a contact manager
- Not a messaging app
- Not a guilt-inducing reminder system
- Not a social comparison tool

---

## User Journey Map

### Moment 0: Launch (0-5 seconds)
**User State:** Curious  
**Screen:** Dark space with subtle particle dust  
**Action:** Brief pause for anticipation  
**Emotion:** Wonder beginning  

### Moment 1: The Reveal (5-30 seconds)
**User State:** Discovering  
**Experience:**
- Stars begin materializing from the center outward
- Closest relationships appear first with gentle light blooms
- Each star finds its orbital position
- Constellation lines fade in between mutual connections
- Soft ambient music swells

**Emotional Arc:** "Oh wow, this is my social world"

### Moment 2: Recognition (30-60 seconds)
**User State:** Exploring  
**Interactions:**
- User naturally taps brightest star
- Sees it's their best friend/family member
- Tries tapping other stars
- Discovers the visual language (size = depth, brightness = recency)

**Emotional Arc:** "Each star is someone I know!"

### Moment 3: Patterns (60-90 seconds)
**User State:** Understanding  
**Discoveries:**
- Notice friend groups forming constellations
- See the dimming stars at edges
- Recognize the time-based distance pattern
- Spot the color differences for relationship types

**Emotional Arc:** "I can see who I'm losing touch with"

### Moment 4: Deeper Exploration (90-120 seconds)
**User State:** Investigating  
**Interactions:**
- Long-press for relationship details
- Pinch to zoom out and see full galaxy
- Pan to explore different regions
- Notice special indicators (birthdays, time zones)

**Emotional Arc:** "There's so much depth here"

### Moment 5: Insight (120-150 seconds)
**User State:** Reflecting  
**Realizations:**
- See clustering of work vs personal relationships
- Notice seasonal patterns in communication
- Identify neglected but important relationships
- Appreciate the size of their social network

**Emotional Arc:** "I should reach out to..."

### Moment 6: Action (150-180 seconds)
**User State:** Motivated  
**The Reconnection Moment:**
- Galaxy gently rotates to highlight a dimming star
- Soft prompt: "Jamie's star is fading... 43 days"
- Shake to send cosmic pulse
- Star brightens with renewed intention
- Optional quick action to send message

**Emotional Arc:** "I'm going to reconnect"

---

## Visual Design System

### Color Palette

**Primary Space Colors**
- Deep Space: `#0A0E27` (RGB: 10, 14, 39)
- Nebula Purple: `#1B1464` (RGB: 27, 20, 100)  
- Cosmic Blue: `#2E3A67` (RGB: 46, 58, 103)
- Stardust: `#FFFFFF10` (RGB: 255, 255, 255, 6% opacity)

**Star Type Colors**
- Family Gold: `#FFD700` (RGB: 255, 215, 0)
- Close Friend Blue: `#00A6FB` (RGB: 0, 166, 251)
- Friend Cyan: `#5DFDCB` (RGB: 93, 253, 203)
- Acquaintance Silver: `#C8C8C8` (RGB: 200, 200, 200)
- Dormant Gray: `#696969` (RGB: 105, 105, 105)

**Effect Colors**
- Pulse Purple: `#9D4EDD` (RGB: 157, 78, 221)
- Connection Line: `#FFFFFF20` (RGB: 255, 255, 255, 12% opacity)
- Selection Glow: `#FFE66D` (RGB: 255, 230, 109)

### Typography
- **Star Labels:** SF Pro Display, 13pt, Semibold
- **Relationship Info:** SF Pro Text, 11pt, Regular
- **Time Indicators:** SF Mono, 10pt, Medium
- **Prompts:** SF Pro Display, 17pt, Regular

### Star Visual Properties

**Size Classes:**
| Relationship Depth | Diameter | Glow Radius |
|-------------------|----------|-------------|
| New (< 1 month) | 5pt | 2pt |
| Casual (< 6 months) | 8pt | 4pt |
| Friend (< 2 years) | 12pt | 7pt |
| Close (< 5 years) | 17pt | 12pt |
| Deep (5+ years) | 23pt | 18pt |

**Brightness Mapping:**
| Last Contact | Opacity | Pulse Speed |
|-------------|---------|-------------|
| Today | 100% | 60 bpm |
| This week | 85% | 40 bpm |
| This month | 65% | 20 bpm |
| 2-3 months | 40% | 10 bpm |
| 3+ months | 20% | 5 bpm |

**Distance Orbits:**
| Ring | Distance from Center | Time Since Contact |
|------|---------------------|-------------------|
| Core | 50-100pt | < 3 days |
| Inner | 100-175pt | 3-14 days |
| Middle | 175-275pt | 14-30 days |
| Outer | 275-400pt | 30-90 days |
| Edge | 400+pt | 90+ days |

### Animation Specifications

**Star Appearance** (on launch)
- Duration: 0.8s per star
- Easing: Spring(response: 0.6, dampingFraction: 0.8)
- Sequence: Staggered by 0.05s
- Effect: Scale from 0 â†’ 1, opacity from 0 â†’ target

**Pulse Animation** (continuous)
- Scale: 1.0 â†’ 1.1 â†’ 1.0
- Duration: Based on pulse speed (see table)
- Easing: Ease-in-out

**Selection Feedback**
- Scale: 1.0 â†’ 1.3 â†’ 1.1
- Duration: 0.3s
- Haptic: Light impact

**Constellation Lines**
- Draw duration: 1.5s
- Opacity: 0 â†’ 20%
- Style: Dotted, 1pt width

---

## Interaction Design

### Touch Gestures

**Tap**
- Target: Individual star
- Response: Show name + days since contact
- Animation: Star scales up 20%, glows briefly
- Haptic: Light tap
- Duration: Display for 3 seconds or until next interaction

**Long Press (0.5s)**
- Target: Individual star
- Response: Detailed relationship card
- Content: 
  - Full name
  - Relationship duration
  - Last interaction type
  - Mutual connections count
  - Time zone if different
- Animation: Background blur, card slides up
- Haptic: Medium impact

**Pinch**
- Zoom range: 0.5x to 3.0x
- Behavior: Smooth scaling with momentum
- Detail levels: More stars visible when zoomed out

**Pan**
- Resistance: Slight elastic resistance at edges
- Momentum: Natural scrolling with deceleration

**Shake**
- Trigger: Device shake detection
- Response: Send reconnection pulse to selected star
- Animation: Ripple effect from star
- Haptic: Success notification pattern

### Information Architecture

**Level 1 (Ambient)** - No interaction
- Star size, brightness, color, position tell the story

**Level 2 (Tap)** - Quick info
- Name only
- "X days ago"
- Relationship emoji (ðŸ‘¨â€ðŸ‘©â€ðŸ‘§â€ðŸ‘¦ ðŸŽ“ ðŸ’¼ â¤ï¸)

**Level 3 (Long Press)** - Full details
- Complete relationship information
- Action options
- Historical pattern mini-graph

---

## Special Features

### Time Zone Intelligence
- Show moon icon (ðŸŒ™) when contact is likely sleeping
- Brightness adjusts based on their local time
- Don't suggest reconnection during their night hours

### Real-Time Events
- **Incoming Message:** Shooting star effect toward their star
- **Birthday:** Star sparkles throughout the day
- **Anniversary:** Connection line glows between relevant stars

### Constellation Patterns
**Automatic Detection:**
- Family clusters
- School friends
- Work colleagues
- Interest groups

**Visual Treatment:**
- Faint connecting lines
- Shared subtle background glow
- Maintain individual star properties

### The Dimming Star System
**Progressive States:**
1. Healthy (full brightness)
2. Cooling (75% brightness, slower pulse)
3. Dimming (50% brightness, minimal pulse)
4. Fading (25% brightness, no pulse)
5. Lost (10% brightness, static)

**Recovery:** Any interaction immediately brings star to 100% for 24 hours

---

## Data Design

### Information We Use
| Data Point | Source | Purpose | Privacy Level |
|------------|--------|---------|---------------|
| Contact Names | Contacts App | Star identification | Required |
| Contact Groups | Contacts App | Constellation patterns | Optional |
| Interaction Frequency | On-device calculation | Star brightness | Required |
| Last Contact Time | On-device tracking | Star distance | Required |
| Relationship Start | Contact creation date | Star size | Optional |
| Time Zones | Contact addresses | Smart suggestions | Optional |

### Calculations

**Interaction Score Formula:**
```
Score = (MessageFreq Ã— 0.3) + (CallFreq Ã— 0.5) + 
        (PhotoShare Ã— 0.2) + (Duration Ã— 0.1) + 
        (Favorite Ã— 0.3) - (DaysSince Ã— 0.01)
```

**Brightness Mapping:**
```
Brightness = min(1.0, Score / 100)
```

**Distance Calculation:**
```
Distance = BaseOrbit + (DaysSinceContact Ã— DriftRate)
```

### Privacy Commitments
- âœ… All processing happens on-device
- âœ… No network requests
- âœ… No message content access
- âœ… No third-party analytics
- âœ… Clear permission explanations
- âœ… Works offline completely

---

## Sound Design

### Ambient Soundscape
**Base Layer**
- Deep space ambience (brown noise, high-pass filtered at 200Hz)
- Volume: 20% of device volume
- Loops seamlessly

**Particle Layer**
- Occasional crystalline twinkles
- Randomized timing (every 5-10 seconds)
- Positioned in stereo field based on star positions

### Interactive Sounds
| Action | Sound | Duration | Volume |
|--------|-------|----------|--------|
| Star Tap | Glass chime (C, E, G notes based on size) | 0.3s | 40% |
| Long Press | Soft synth pad swell | 0.5s | 30% |
| Zoom | Subtle whoosh | 0.2s | 20% |
| Shake Pulse | Warm wave | 1.0s | 50% |
| Constellation Draw | Harp glissando | 0.8s | 35% |

### Music
- Ambient, contemplative
- Key: A minor
- Tempo: 60 BPM
- Instruments: Soft pad, subtle strings, glass marimba
- Dynamic: Responds to interaction density

---

## Edge Cases & Solutions

### Scenario Handling

**Few Contacts (< 10 stars)**
- Add subtle "undiscovered stars" in background
- Make existing stars larger and more prominent
- Message: "Every galaxy starts small and grows"

**Many Contacts (> 200 stars)**
- Show top 150 based on interaction score
- Cluster similar relationships
- Add "galaxy layers" for navigation

**No Recent Interactions**
- Avoid shame language
- Show "constellation potential" between dormant stars
- Message: "Stars are patient"

**Very Active User**
- Celebrate with aurora borealis effect
- All stars bright creates "galaxy bloom"
- Message: "Your galaxy is thriving"

### Performance Optimizations
- Frustum culling for off-screen stars
- Level-of-detail system for zoomed out view
- Particle effects scale with device capability
- 60 FPS target, graceful degradation to 30 FPS

---

## Accessibility

### VoiceOver Support
- Every star has meaningful label: "[Name], [Relationship], last contact [X] days ago"
- Spatial audio indicates star position
- Gesture instructions provided
- Constellation patterns described

### Visual Accommodations
- High contrast mode available
- Colorblind-friendly palette option
- Reduced motion setting
- Adjustable star sizes

### Interaction Alternatives
- All gestures have button alternatives
- Voice control for navigation
- Switch control compatible
- No time-based requirements

---

## Technical Requirements

### Frameworks Needed
- SwiftUI (primary UI)
- SpriteKit (particle effects)
- CoreMotion (shake detection)
- Contacts (data source)
- AVFoundation (sound)
- CoreHaptics (tactile feedback)

### Device Requirements
- iOS 17.0+
- iPhone 12 or newer recommended
- Works on iPad with adapted layout
- 50MB storage for app + cache

### Performance Targets
- Launch time: < 2 seconds
- Star render: 60 FPS
- Memory usage: < 150MB
- Battery impact: Minimal

---

## Success Metrics

### For Swift Student Challenge Judges

**Technical Excellence**
- Smooth 60 FPS animations
- No crashes or bugs
- Efficient memory usage
- Creative use of iOS frameworks

**Innovation**
- Novel visualization approach
- Unique interaction patterns
- Creative problem solving

**Impact**
- Addresses real problem
- Emotional resonance
- Practical value

**Design Polish**
- Cohesive visual language
- Attention to detail
- Delightful microinteractions
- Sound design integration

**Code Quality**
- Clean architecture
- Well-commented
- Efficient algorithms
- Proper error handling

---

## Implementation Phases

### Phase 1: Core Visualization (Days 1-5)
- Basic star rendering
- Position calculation
- Color system
- Touch detection

### Phase 2: Data Integration (Days 6-9)
- Contacts permission
- Scoring algorithm
- Update mechanism
- Privacy handling

### Phase 3: Interactions (Days 10-12)
- Gesture recognizers
- Animation system
- Haptic feedback
- Sound integration

### Phase 4: Polish (Days 13-14)
- Special effects
- Edge cases
- Performance optimization
- Accessibility

### Phase 5: Testing (Day 15)
- Device testing
- User feedback
- Final adjustments
- Submission preparation

---

## Conclusion

Social Constellation transforms the abstract concept of "keeping in touch" into a tangible, beautiful experience. It turns relationship maintenance from a chore into a moment of wonder and reflection.

The app succeeds when users feel:
1. Wonder at seeing their social universe
2. Awareness without guilt
3. Motivated to reconnect
4. Appreciation for their relationships

Every design decision should support these emotional goals while maintaining technical excellence and accessibility.

---

*Remember: The goal isn't to have the brightest galaxy or the most stars - it's to be intentional about the relationships that matter to you.*