![aphero logo](assets/images/app_name_dark.png)

A multi-platform project built with Flutter, featuring a collection of engaging games and interactive experiences.

## 🏰 Heroic Feats & Challenges

A collection of modular tavern games set in a medieval realm, where warriors test their mettle through trials of wit, courage, and camaraderie.

### Game Modules

| Icon  | Game                | Description |
|-------|--------------------|-------------|
| 🗡️  | **Arrow of Destiny** | *"The council must choose!"*<br>Players anonymously vote for the most capable soldier to undertake a perilous quest, revealing alliances and rivalries. |
| 🏛️  | **Babylon Tower**   | *"Knowledge is the true shield."*<br>A general knowledge challenge where correct answers help players ascend the mythical tower. |
| ⚔️  | **Bravery or Confession** | *"Swear it on your honor!"*<br>Medieval truth-or-dare: choose between revealing secrets or completing dares. |
| 👂  | **Gossip Hunting**  | *"A whisper becomes a dragon's roar."*<br>Players race to match scandalous rumors to their owners. |
| 🐎  | **Joust of Horses** | *"Fortune favors the bold bettor!"*<br>Betting game where players wager on anonymous tournament champions. |
| 🛡️  | **Joust of Secrets** | *"Two paths lie before you..."*<br>Present moral dilemmas for group debate and voting. |
| 🚫  | **Taboos of Heroes** | *"By my oath, I swear..."*<br>"Never Have I Ever" with medieval punishments. |
| 🃏  | **Under Border**    | *"Spies lurk in the feast hall!"*<br>Social deduction with hidden roles (Knights vs Spies). |

## 🍻 How to Play

1. Gather your warband (4+ players recommended)
2. Choose your challenge from the game modules
3. May fortune favor the bold!

> *"A kingdom is built on more than swords alone - it is forged in the bonds tested by fire and ale!"* - Unknown Tavernkeep

## Project Structure

The project follows a standard Flutter project structure with additional organization for features:
<pre>
📦 aphero
├── 📁 android                   # Android platform-specific files
├── 📁 assets                    # All static assets
│   ├── 📁 fonts                 # Custom fonts
│   ├── 📁 icons                 # App icons
│   ├── 📁 images                # All image assets
│   │   ├── 📁 background        # Background images
│   │   ├── 📁 characters        # Character sprites
│   │   └── 📁 ui                # UI elements
│   └── 📄 bravery_or_confession_questions.json  # Game content
│
├── 📁 build                     # Build outputs (auto-generated)
├── 📁 ios                       # iOS platform-specific files
├── 📁 lib                       # Main application code
│   ├── 📁 features              # Feature modules
│   │   ├── 📁 arrow_of_destiny  # Arrow of Destiny game
│   │   ├── 📁 babylon_tower     # Babylon Tower game
│   │   ├── 📁 bravery_or_confession  # Truth or Dare-style game
│   │   ├── 📁 gossip_hunting    # Gossip Hunting game
│   │   ├── 📁 joust_of_horses   # Horse jousting game
│   │   ├── 📁 joust_of_secrets  # Secret questions game
│   │   ├── 📁 shared            # Shared components
│   │   ├── 📁 taboos_of_heroes  # Hero taboos game
│   │   └── 📁 under_border      # Under Border game
│   │
│   ├── 📁 i18n                  # Localization files
│   │   ├── 📄 en.json           # English translations
│   │   └── 📄 es.json           # Spanish translations
│   │
│   ├── 📁 core                  # Core application architecture
│   │   ├── 📁 constants         # App-wide constants
│   │   ├── 📁 providers         # State providers
│   │   ├── 📁 routing           # Navigation routing
│   │   ├── 📁 services          # Services layer
│   │   └── 📁 theme             # Theme configuration
│   │
│   └── 📄 main.dart             # Application entry point
│
├── 📁 linux                     # Linux platform-specific files
├── 📁 macos                     # macOS platform-specific files
├── 📁 test                      # Test files
├── 📁 web                       # Web platform-specific files
├── 📁 windows                   # Windows platform-specific files
│
├── 📄 .gitignore                # Git ignore rules
├── 📄 analysis_options.yaml     # Linter configuration
├── 📄 pubspec.lock              # Version lock file
└── 📄 pubspec.yaml              # Dart dependencies and metadata
</pre>
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK (version 3.32.25 or later recommended)
- Dart SDK (version 3.8.1)
- A code editor like VS Code, Android Studio, or IntelliJ IDEA with Flutter and Dart plugins installed.

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/nonocro/aphero.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd apero
    ```
3.  Get the project dependencies:
    ```bash
    flutter pub get
    ```

## Running the Project

To run the application on a connected device or simulator/emulator:

```bash
flutter run
```