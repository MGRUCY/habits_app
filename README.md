# Habits

A simple daily habit tracker built with Flutter, backed by a local SQLite database.

## About

This is a personal Flutter learning project. It's a habit-tracking app where you can create habits, define how often you want to do them (specific weekdays or a number of times per week), and check them off day by day. It tracks streaks, shows a 30-day history per habit, and lets you attach free-text notes to each habit. It is not a published or production app — just a project used to practice real Flutter concepts beyond a basic template.

## Features

- Create, edit, and delete habits, each with a name, an optional note, and a color
- Set a schedule per habit: either specific days of the week or a target number of times per week
- Mark today as "done" or "grace" (an excused/partial day) for a habit, or unmark it
- Automatic streak calculation based on consecutive done/grace days
- Home screen "Rhythm" panel showing a combined streak across all habits plus a 30-day dot timeline for each one
- Small trend sparkline on each habit card showing the last few days
- Habit detail screen with streak / days-done / days-graced counters and a 30-day calendar-style grid
- Per-habit notes screen: add, list, and swipe-to-delete timestamped notes
- All data is persisted locally in SQLite, so habits and history survive app restarts

## Flutter Concepts Used

- **State Management** — Riverpod, using code-generated providers (`@riverpod` classes/functions via `riverpod_annotation`), including family providers for per-habit data (logs, notes)
- **Local Database (SQLite)** — the Drift package for typed tables, a custom `TypeConverter` (storing a list of weekdays as JSON in a text column), unique keys, a foreign key relation, and a schema migration (`schemaVersion` bump that adds the notes table)
- **Navigation** — `Navigator.push` with `MaterialPageRoute` between the habit list, add/edit form, detail screen, and notes screen
- **Forms & Validation** — text fields with controllers, a required-name check before saving, and `SnackBar` feedback on invalid input
- **Custom Widgets** — habit list tiles, the streak/"Rhythm" summary panel, per-day status dot rows, and the 30-day calendar grid
- **Data Visualization** — `fl_chart` line sparklines per habit, plus a hand-built grid/heatmap for 30-day history
- **Theming** — `flex_color_scheme` for a pre-built Material color scheme (dark theme)

## Packages Used

- `flutter_riverpod`, `riverpod`, `riverpod_annotation` (+ `riverpod_generator`, `build_runner`) — state management and code generation
- `drift` (+ `drift_dev`) — local SQLite database/ORM
- `path_provider`, `path` — resolving the on-device path for the SQLite file
- `fl_chart` — sparkline charts on habit tiles
- `google_fonts` — handwriting-style "Patrick Hand" font used throughout the UI
- `flex_color_scheme` — app theming
- `day_picker` — weekday selector used in the add/edit habit form
- `toggle_switch` — segmented control for switching between "specific days" and "times per week"
- `count_stepper` — numeric stepper for the times-per-week target
- `intl` — date formatting

## Screenshots

> Add screenshots here.

## Learning Purpose

This project was likely used to practice wiring a real local database (Drift/SQLite) into a Flutter app, including migrations and custom column type converters, and to learn modern Riverpod with code generation (notifiers, `family` providers, and cache invalidation after writes). It also covers integrating several third-party UI packages into a single form, and basic data visualization with `fl_chart` alongside a custom-built calendar/heatmap widget.

## Notes

- The app only defines a dark theme (`FlexThemeData.dark`) in `MaterialApp`; no explicit light theme is set.
- The pubspec includes a few dependencies (e.g. `shared_preferences`, `flex_color_picker`, `m3e_buttons`, `flutter_toggle_button`, `drift_flutter`) that aren't actually used in the current code — likely left over from experimentation.
- The project has no `assets/` folder; nothing is declared under `flutter: assets` in `pubspec.yaml`.
