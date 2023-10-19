# Flutter Drift Sample

Shows how to use [drift](https://pub.dev/packages/drift) by modelling a simple relational DB with parent - child relationship using foreign keys constraints with cascade deletes. Furthermore table changes, following migrations and testing those are shown exemplary.

![alt text](doc/relationship.svg)

## Build
* `git clone https://github.com/d-wolf/flutter_drift_sample.git`
* `dart run build_runner build --delete-conflicting-outputs`
* `flutter run`
