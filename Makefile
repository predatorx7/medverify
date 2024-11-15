runm:
	flutter run --dart-define-from-file=./.env
gen:
	dart run build_runner watch --delete-conflicting-outputs
l10n:
	flutter gen-l10n
