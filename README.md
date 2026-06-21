<div align="center">

# ⚡ Ahmed Atef — Flutter Developer Portfolio

### A production-grade, motion-rich portfolio built entirely in Flutter Web.

<br />

![Flutter](https://img.shields.io/badge/Flutter-3.7+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.7+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Web-FF6F00?style=for-the-badge&logo=googlechrome&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Feature--First-7C6FFF?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-success?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

<br />

![Portfolio Banner](link-to-banner-image.gif)

<br />

**[🌐 Live Demo](link-to-live-demo)** · **[🐛 Report Bug](link-to-issues)** · **[✨ Request Feature](link-to-issues)**

</div>

<br />

## 📖 Overview

This repository powers my personal **Flutter Web portfolio** — not a template, not a static site, but a fully engineered single-codebase application that doubles as a live demonstration of production Flutter craftsmanship.

Every pixel here is intentional: a custom parallax grid background that reacts to scroll, a 3D-tilting hero avatar that tracks the cursor, scroll-triggered reveal animations, and a theme engine that respects system preference out of the box. Under the hood, it's organized with the same **Feature-First Clean Architecture** discipline I bring to client and production apps — because a portfolio that *talks* about good architecture should also *be* one.

> 💡 **Why this matters to recruiters:** Most portfolios are marketing pages. This one is a working engineering artifact — readable code, sensible boundaries, and zero throwaway hacks.

<br />

## ✨ Key Features

| | |
|---|---|
| 🌗 **Flawless Theming** | Light / Dark / **System-synced** theme modes, persisted locally via `SharedPreferences` and reactive through a dedicated `ThemeController` (`ChangeNotifier` + `Provider`). |
| 🎬 **Custom 60fps Animations** | Hand-built animation primitives — no animation package dependency. `ScrollReveal` triggers fade/slide/scale on viewport entry via `visibility_detector`; `FadeSlideAnimation` choreographs staggered entrances; `TypeWriterText` drives the hero headline. |
| 🪄 **3D Tilt Hero Avatar** | A `MouseRegion`-driven `HeroAvatar` widget that maps cursor position to real-time `Matrix4` perspective rotation — a tactile, physical-feeling interaction, not just a CSS trick. |
| 🌌 **Parallax Grid Background** | A custom `CustomPainter`-based dot-grid backdrop (`GridBackground`) with adjustable spacing, intensity, parallax offset, and an optional spotlight glow that tracks the cursor — fully theme-aware. |
| 📱 **Adaptive Layouts** | A first-party `Responsive` utility (no breakpoint package) drives mobile / tablet / desktop layout decisions everywhere — from nav bar to hero grid to typography scale. |
| 🧭 **Declarative Routing** | `GoRouter` with a persistent `ShellRoute` shell, nested project-detail routes (`/projects/:id`), and custom fade + scale page transitions for a native-app feel on the web. |
| 🪟 **Adaptive Navigation** | A responsive `NavBar` for desktop/tablet that collapses into a polished `AppDrawer` on mobile — shared layout logic, zero duplicated state. |
| 🎨 **Typed Design System** | Centralized `AppColors`, `AppTheme`, and `AppSizes` constants ensure every spacing, radius, and color value is sourced from one place — never a magic number in a widget tree. |

<br />

## 🏗️ Architecture

This project follows **Feature-First Clean Architecture** — the same structural pattern used across my production apps (NewsWave, Social Mate) — adapted for a presentation-focused web app.

```
lib/
├── core/                 # Cross-cutting, app-wide building blocks
│   ├── animations/       # ScrollReveal, FadeSlideAnimation, TypeWriterText
│   ├── constants/        # AppSizes, AppStrings — no magic numbers/strings
│   ├── responsive/       # Custom breakpoint engine (mobile/tablet/desktop)
│   ├── theme/            # AppColors, AppTheme, ThemeController
│   └── widgets/          # GridBackground & other shared low-level UI
│
├── features/             # Self-contained, screen-level feature modules
│   ├── home/             # Hero section, avatar, tech strip
│   ├── about/             
│   ├── projects/         # Project data, cards, detail pages
│   └── contact/          
│
├── routing/              # GoRouter configuration & route contracts
│
├── shared/               # Reusable UI shared *across* features
│   ├── layout/           # ShellLayout, NavBar, AppDrawer
│   └── widgets/          # Buttons, GradientText, HoverCard, SectionHeader
│
└── main.dart             # Composition root — DI via Provider, app bootstrap
```

**Why this matters:**
- 🧩 **Feature isolation** — `features/projects` doesn't know or care how `features/contact` is built. Each is independently navigable and testable.
- 🎯 **Single source of truth** — design tokens live in `core/`, never duplicated inline.
- 🔌 **Dependency direction is deliberate** — `shared/` and `core/` never import from `features/`, keeping the dependency graph acyclic and predictable.
- 📈 **Scales cleanly** — adding a new section means adding a new `features/<name>/` folder, not hunting through a monolithic `widgets/` dump.

<br />

## 🚀 Projects Showcase

The portfolio's centerpiece — a fully data-driven `projects_data.dart` model — showcases three flagship, production-grade applications:

### 💬 Social Mate
> *Connect · Share · Discover · Belong*

A real-time social platform with 1-on-1 & group chat, audio/video calling, stories, and live presence — built on Supabase Realtime.

`Flutter` · `Supabase` · `Firebase` · `ZEGOCLOUD` · `BLoC`

### 📰 NewsWave
> *Your world, curated — in real time*

A bilingual (EN/AR) news reader with reactive RTL support, offline-first Hive caching, and a custom dependency-free connectivity layer that correctly detects captive portals.

`Flutter` · `Cubit` · `Hive` · `Supabase` · `REST API`

### 📊 FinDash
> *Responsive Finance Dashboard*

A finance admin dashboard with dedicated mobile/tablet/desktop layouts, interactive `fl_chart` visualizations, and zero platform-specific code.

`Flutter` · `fl_chart` · `Adaptive UI` · `Dart`

<br />

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| **Framework** | Flutter (Web) |
| **Language** | Dart `^3.7.2` |
| **Routing** | [`go_router`](https://pub.dev/packages/go_router) — declarative, shell-based navigation |
| **State Management** | [`provider`](https://pub.dev/packages/provider) — lightweight `ChangeNotifier`-based theme state |
| **Persistence** | [`shared_preferences`](https://pub.dev/packages/shared_preferences) — theme mode persistence |
| **Typography** | [`google_fonts`](https://pub.dev/packages/google_fonts) — Space Grotesk + Inter pairing |
| **Iconography** | [`font_awesome_flutter`](https://pub.dev/packages/font_awesome_flutter), Material Icons |
| **Scroll Detection** | [`visibility_detector`](https://pub.dev/packages/visibility_detector) — powers `ScrollReveal` |
| **Linking** | [`url_launcher`](https://pub.dev/packages/url_launcher) — external links (GitHub, socials, mailto) |
| **Linting** | [`flutter_lints`](https://pub.dev/packages/flutter_lints) — strict static analysis |

<br />

## 📸 Preview

<div align="center">

![Home Page](link-to-home-screenshot.png)
*Hero section with 3D tilt avatar and parallax grid background*

![Projects Showcase](link-to-projects-screenshot.png)
*Project cards with gradient theming and hover interactions*

![Dark Mode](link-to-darkmode-gif.gif)
*Seamless light/dark theme transition*

</div>

<br />

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.7.2` or higher
- A configured IDE (VS Code or Android Studio) with the Flutter/Dart plugins
- Chrome (or any Chromium-based browser) for web development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ahmedatef5O5/ahmed_portfolio.git
   cd ahmed_portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app locally**
   ```bash
   flutter run -d chrome
   ```

4. **Build for production**
   ```bash
   flutter build web --release
   ```
   The optimized build output will be available in `build/web/`, ready to deploy to any static host (Firebase Hosting, Vercel, Netlify, GitHub Pages).

<br />

## 🗂️ Project Structure Philosophy

This codebase intentionally avoids two common portfolio anti-patterns:

- ❌ **The "one giant widgets folder"** — instead, every feature owns its own presentation layer.
- ❌ **Animation/effects packages for everything** — `ScrollReveal`, `FadeSlideAnimation`, the 3D tilt avatar, and the parallax grid are all hand-rolled with `AnimationController`, `CustomPainter`, and `Matrix4` — a deliberate choice to demonstrate animation fundamentals rather than configuration of a third-party widget.

<br />

## 🤝 Connect With Me

<div align="center">

[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-7C6FFF?style=for-the-badge)](link-to-live-demo)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github)](https://github.com/Ahmedatef5O5)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin)](link-to-linkedin)
[![Email](https://img.shields.io/badge/Email-Contact-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:your-email@example.com)

</div>

<br />

## 📄 License

This project is licensed under the **MIT License** — feel free to explore the code, but please don't redistribute it as your own portfolio. See the [LICENSE](LICENSE) file for details.

<br />

<div align="center">

**Built with 💜 and Flutter by Ahmed Atef**

⭐ If this repo gave you architecture or animation ideas, consider giving it a star!

</div>
