# Zleppu (iOS)

Native SwiftUI-app baserad på Zleppu-designen.

## Öppna och kör

1. Dubbelklicka på `Zleppu.xcodeproj`
2. Välj iPhone-simulator
3. Tryck **▶ Play**

## Skärmar (enligt design)

| Skärm | Hur du når den |
|-------|----------------|
| Landing | Startskärm — soluppgång, Create account / Log in |
| Inloggning | Create account → valfri 6-siffrig kod |
| Home | Dashboard med nästa väckning, statistik, upcoming |
| Chat | Tryck på "Gym-gänget"-kortet eller Rooms-fliken |
| Inkommande samtal | Klockikonen uppe till höger på Home |
| Godkänn alarm | Tryck på ett alarm i Upcoming, eller Alarms-fliken |
| Aktivt samtal | Accept på inkommande samtal |
| Morgonsammanfattning | Avsluta aktivt samtal |
| Profil | Profile-fliken |

## Design

- Färger: navy, peach, lavender, sunrise orange
- Rundade kort med mjuka skuggor
- Soluppgångsgradient på landing och samtal

## Nästa steg

1. Riktig SMS-inloggning (Twilio/Firebase)
2. Backend för rum och chatt
3. Native alarm + CallKit
