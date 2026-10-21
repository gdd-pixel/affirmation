//
//  AffirmationWidget.swift
//  AffirmationWidget
//

import WidgetKit
import SwiftUI

// MARK: - Données partagées avec Flutter

struct WidgetPayload: Codable {
    let mode: String
    let affirmations: [String]
    let currentIndex: Int?
    let updatedAt: String?
}

// MARK: - Entrée de timeline

struct AffirmationEntry: TimelineEntry {
    let date: Date
    let affirmation: String
    let mode: String
}

// MARK: - Provider

struct Provider: TimelineProvider {

    // IMPORTANT : mets ici ton App Group exact.
    private let appGroupIdentifier =
        "group.com.mycompany.affirmation"

    // Doit correspondre à la clé utilisée dans FlutterFlow.
    private let storageKey =
        "widget_content_json"

    private let fallbackAffirmations: [String] = [
        "Je mérite de belles choses.",
        "Je suis capable d’avancer à mon rythme.",
        "Je fais confiance à mon chemin.",
        "Je choisis de voir le positif aujourd’hui.",
        "Je suis plus fort que mes doutes.",
        "Chaque petit pas compte.",
        "Je mérite le calme et la sérénité.",
        "Je suis fier de la personne que je deviens.",
        "J’accueille cette journée avec confiance.",
        "Je peux créer une vie qui me ressemble.",
        "Je suis digne d’amour et de respect.",
        "Je me donne le droit d’être heureux.",
        "Je progresse chaque jour.",
        "Je mérite de prendre soin de moi.",
        "Je choisis la paix intérieure.",
        "Je peux dépasser les difficultés.",
        "Je crois en mes capacités.",
        "Je m’autorise à ralentir.",
        "Je suis suffisant tel que je suis.",
        "Je transforme mes pensées avec douceur.",
        "Je mérite une vie épanouissante.",
        "Je fais de mon mieux et cela suffit.",
        "Je peux recommencer à tout moment.",
        "Je suis ouvert aux belles opportunités.",
        "Je choisis de me parler avec bienveillance.",
        "Je mérite de me sentir en sécurité.",
        "Je suis en train de devenir plus confiant.",
        "Je peux apprendre de chaque expérience.",
        "Je suis capable de créer du changement.",
        "Aujourd’hui, je choisis de croire en moi.",
        "Je choisis de me concentrer sur le positif.",
        "Je laisse aller ce qui ne me sert plus.",
        "Je suis reconnaissant pour tout ce que j’ai.",
        "Je m’entoure de personnes positives.",
        "Je mérite de recevoir le meilleur.",
        "Je choisis d’être ma priorité.",
        "J’avance avec confiance et détermination.",
        "Je suis l’auteur de ma propre histoire.",
        "Je choisis l’amour, la joie et la paix.",
        "Je fais de chaque jour une belle aventure."
    ]

    func placeholder(
        in context: Context
    ) -> AffirmationEntry {
        AffirmationEntry(
            date: Date(),
            affirmation: "Je crois en moi.",
            mode: "general"
        )
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (AffirmationEntry) -> Void
    ) {
        let payload = loadWidgetPayload()

        completion(
            makeEntry(
                for: Date(),
                payload: payload,
                hourOffset: 0
            )
        )
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (
            Timeline<AffirmationEntry>
        ) -> Void
    ) {
        let calendar = Calendar.current
        let now = Date()
        let payload = loadWidgetPayload()

        let startOfCurrentHour =
            calendar.dateInterval(
                of: .hour,
                for: now
            )?.start ?? now

        var entries: [AffirmationEntry] = []

        // L'affirmation actuelle utilise currentIndex.
        // Chaque heure suivante passe à l'affirmation suivante.
        for hourOffset in 0..<48 {
            guard let entryDate = calendar.date(
                byAdding: .hour,
                value: hourOffset,
                to: startOfCurrentHour
            ) else {
                continue
            }

            entries.append(
                makeEntry(
                    for: entryDate,
                    payload: payload,
                    hourOffset: hourOffset
                )
            )
        }

        let refreshDate = calendar.date(
            byAdding: .hour,
            value: 48,
            to: startOfCurrentHour
        ) ?? now.addingTimeInterval(48 * 60 * 60)

        completion(
            Timeline(
                entries: entries,
                policy: .after(refreshDate)
            )
        )
    }

    // MARK: - Lecture du JSON partagé

    private func loadWidgetPayload() -> WidgetPayload {
        guard
            let sharedDefaults = UserDefaults(
                suiteName: appGroupIdentifier
            ),
            let jsonString = sharedDefaults.string(
                forKey: storageKey
            ),
            let jsonData = jsonString.data(
                using: .utf8
            )
        else {
            return fallbackPayload()
        }

        do {
            let decodedPayload =
                try JSONDecoder().decode(
                    WidgetPayload.self,
                    from: jsonData
                )

            let cleanedAffirmations =
                cleanAffirmations(
                    decodedPayload.affirmations
                )

            guard !cleanedAffirmations.isEmpty else {
                return fallbackPayload()
            }

            let safeIndex = normalizedIndex(
                decodedPayload.currentIndex ?? 0,
                count: cleanedAffirmations.count
            )

            return WidgetPayload(
                mode: normalizedMode(decodedPayload.mode),
                affirmations: cleanedAffirmations,
                currentIndex: safeIndex,
                updatedAt: decodedPayload.updatedAt
            )
        } catch {
            print(
                "Erreur de lecture de widget_content_json : \(error)"
            )

            return fallbackPayload()
        }
    }

    // MARK: - Création de l'entrée

    private func makeEntry(
        for date: Date,
        payload: WidgetPayload,
        hourOffset: Int
    ) -> AffirmationEntry {
        let affirmations = payload.affirmations

        guard !affirmations.isEmpty else {
            return AffirmationEntry(
                date: date,
                affirmation:
                    "Ouvre Phil'O pour configurer ton widget.",
                mode: "general"
            )
        }

        let baseIndex = normalizedIndex(
            payload.currentIndex ?? 0,
            count: affirmations.count
        )

        let displayedIndex = normalizedIndex(
            baseIndex + hourOffset,
            count: affirmations.count
        )

        return AffirmationEntry(
            date: date,
            affirmation: affirmations[displayedIndex],
            mode: payload.mode
        )
    }

    // MARK: - Valeurs de secours

    private func fallbackPayload() -> WidgetPayload {
        WidgetPayload(
            mode: "general",
            affirmations: fallbackAffirmations,
            currentIndex: 0,
            updatedAt: nil
        )
    }

    // MARK: - Utilitaires

    private func normalizedIndex(
        _ index: Int,
        count: Int
    ) -> Int {
        guard count > 0 else {
            return 0
        }

        return ((index % count) + count) % count
    }

    private func cleanAffirmations(
        _ values: [String]
    ) -> [String] {
        var seen = Set<String>()
        var result: [String] = []

        for value in values {
            let cleaned = value.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            if !cleaned.isEmpty &&
                seen.insert(cleaned).inserted {
                result.append(cleaned)
            }
        }

        return result
    }

    private func normalizedMode(
        _ mode: String
    ) -> String {
        switch mode {
        case "general",
             "myAffirmations",
             "favorites",
             "categories":
            return mode

        default:
            return "general"
        }
    }
}

// MARK: - Vue

struct AffirmationWidgetEntryView: View {

    @Environment(\.widgetFamily)
    private var family

    let entry: Provider.Entry

    var body: some View {
        Text(entry.affirmation)
            .font(fontForFamily)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineLimit(lineLimitForFamily)
            .minimumScaleFactor(0.5)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .padding(paddingForFamily)
    }

    private var fontForFamily: Font {
        switch family {
        case .accessoryInline:
            return .caption

        case .accessoryCircular:
            return .caption2

        case .accessoryRectangular:
            return .caption

        case .systemMedium:
            return .title3

        default:
            return .headline
        }
    }

    private var lineLimitForFamily: Int {
        switch family {
        case .accessoryInline:
            return 1

        case .accessoryCircular:
            return 3

        case .accessoryRectangular:
            return 4

        case .systemMedium:
            return 5

        default:
            return 6
        }
    }

    private var paddingForFamily: CGFloat {
        switch family {
        case .accessoryInline:
            return 0

        case .accessoryCircular,
             .accessoryRectangular:
            return 4

        default:
            return 14
        }
    }
}

// MARK: - Fond

struct AffirmationWidgetBackground: View {

    @Environment(\.widgetFamily)
    private var family

    var body: some View {
        switch family {
        case .accessoryInline,
             .accessoryCircular,
             .accessoryRectangular:
            Color.clear

        default:
            LinearGradient(
                colors: [
                    Color(
                        red: 0.14,
                        green: 0.14,
                        blue: 0.17
                    ),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

// MARK: - Déclaration

struct AffirmationWidget: Widget {

    let kind: String = "AffirmationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            if #available(iOS 17.0, *) {
                AffirmationWidgetEntryView(
                    entry: entry
                )
                .containerBackground(
                    for: .widget
                ) {
                    AffirmationWidgetBackground()
                }
            } else {
                ZStack {
                    AffirmationWidgetBackground()

                    AffirmationWidgetEntryView(
                        entry: entry
                    )
                }
            }
        }
        .configurationDisplayName(
            "Affirmations Phil'O"
        )
        .description(
            "Une affirmation différente chaque heure selon tes préférences."
        )
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular
        ])
        .contentMarginsDisabledIfAvailable()
    }
}

// MARK: - Compatibilité iOS 16

extension WidgetConfiguration {
    /// `contentMarginsDisabled()` n'existe qu'à partir d'iOS 17 ; avant,
    /// les widgets n'ont pas ces marges.
    func contentMarginsDisabledIfAvailable() -> some WidgetConfiguration {
        if #available(iOSApplicationExtension 17.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}

// MARK: - Aperçus
//
// Format compatible iOS 16 (le macro #Preview des widgets exige iOS 17).

struct AffirmationWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AffirmationWidgetEntryView(
                entry: AffirmationEntry(
                    date: .now,
                    affirmation: "Je mérite de belles choses.",
                    mode: "general"
                )
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Écran d'accueil")

            AffirmationWidgetEntryView(
                entry: AffirmationEntry(
                    date: .now,
                    affirmation: "Je suis capable d’avancer à mon rythme.",
                    mode: "favorites"
                )
            )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Format moyen")

            AffirmationWidgetEntryView(
                entry: AffirmationEntry(
                    date: .now,
                    affirmation: "Je crois en mes capacités.",
                    mode: "categories"
                )
            )
            .previewContext(
                WidgetPreviewContext(family: .accessoryRectangular)
            )
            .previewDisplayName("Écran verrouillé")
        }
    }
}
