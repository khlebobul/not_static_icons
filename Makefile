.PHONY: check-icons bump-version update-lock help

# Helper targets for contributors.
# Use `make help` to see available commands. Override `LUCIDE_REPO_PATH`
# if the Lucide repository lives elsewhere (defaults to ../lucide).

# Variables
LUCIDE_REPO_PATH ?= ../lucide
PUBSPEC_PATH = not_static_icons_app/pubspec.yaml
PUBSPEC_LOCK_PATH = not_static_icons_app/pubspec.lock

# Help
help:
	@echo "Available commands:"
	@echo "  check-icons    - Run the Lucide icons check script"
	@echo "  bump-version   - Increment the version in pubspec.yaml"
	@echo "  update-lock    - Update pubspec.lock"
	@echo "  all            - Run all commands in sequence"
	@echo ""
	@echo "Variables:"
	@echo "  LUCIDE_REPO_PATH - Path to the Lucide repository (default: ../lucide)"

# Run the icons check script
check-icons:
	@echo "Running icon check script..."
	dart run tool/check_lucide_icons.dart $(LUCIDE_REPO_PATH)

# Increment the patch version (third number) and build number
bump-version:
	@echo "Incrementing patch and build version in $(PUBSPEC_PATH)..."
	@current_version=$$(grep '^version:' $(PUBSPEC_PATH) | sed 's/version: //'); \
	echo "Current version: $$current_version"; \
	version_core=$$(echo $$current_version | cut -d'+' -f1); \
	build_part=$$(echo $$current_version | cut -d'+' -f2); \
	major=$$(echo $$version_core | cut -d'.' -f1); \
	minor=$$(echo $$version_core | cut -d'.' -f2); \
	patch=$$(echo $$version_core | cut -d'.' -f3); \
	new_patch=$$((patch + 1)); \
	new_build=$$((build_part + 1)); \
	new_version_core="$$major.$$minor.$$new_patch"; \
	new_version="$$new_version_core+$$new_build"; \
	echo "New version: $$new_version"; \
	sed -i '' "s/^version: .*/version: $$new_version/" $(PUBSPEC_PATH)

# Update pubspec.lock
update-lock:
	@echo "Updating pubspec.lock..."
	cd not_static_icons_app && flutter pub get

# Run all commands
all: check-icons bump-version update-lock
	@echo "All commands executed successfully!"
