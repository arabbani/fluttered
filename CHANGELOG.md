## [0.0.1]

- PVC architecture added
## [0.0.1+1]

- README file modified

## [0.0.2]

- a `dispose` parameter added to `ImmutablePVC`s to cleanup resources.

## [0.1.0]

**Breaking Change:**
- `StatelessMutabalePVC`, `StatefulMutabalePVC`, `StatelessImmutabalePVC` 
and `StatefulImmutabalePVC` are removed. Use `MutablePVC` and `ImmutablePVC` instead.

**New Features:**
- StatefulWrapper widget added.

## [0.2.0]

**Breaking Change:**
- `onInit` parameter changed to `initState` in `StatefulWrapper`.

**New Features:**
- `didUpdateWidget` parameter added to `StatefulWrapper`.

**New Widgets:**
- ThemeManager
- LifecycleManager
- LandingPageManager

**New Services:**
- SharedPrefsService

**Others:**
- Utility methods `calculateHeight` and `calculateWidth` added to calculate `height` and `width` based on `screenSize`.

## [0.3.0]

**Breaking Change:**

- `requireLogin` property removed from `LandingPageManager`.
- `lifecycleStateStream` stream removed from `LifecycleManager`.

**New Features:**
- `dispose` callback added to `StatefulWrapper`.

**New Widgets:**
- GridOrListView

**Others:**
- `screenSize`, `screenHeight` and `screenWidth` method added.



