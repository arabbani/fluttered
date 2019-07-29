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
-`ThemeManager` widget added.
- `didUpdateWidget` and `didChangeDependencies` parameter added to `StatefulWrapper`.


