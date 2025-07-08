#!/bin/bash

echo "🔧 Building Flutter web app with cache busting..."

# Convert line endings (if needed)
dos2unix pubspec.yaml 2>/dev/null || true

# Increment build version
echo "📈 Incrementing build version..."
perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)\+(\d+)$/$1.($2+1)."+".($3+1)/e' pubspec.yaml

# Clean and build
echo "🧹 Cleaning project..."
flutter clean
flutter packages get

echo "🏗️  Building web app..."
flutter build web --release --pwa-strategy=none

# Update base href
echo "🔗 Updating base href..."
baseHref="/"
sed -i '' "s|<base href=\".*\">|<base href=\"$baseHref\">|g" build/web/index.html

# Get version from pubspec.yaml
echo "📋 Reading version from pubspec.yaml..."
version=$(grep version: pubspec.yaml | sed 's/version: //g' | sed 's/+//g')
echo "   Version: $version"

# Add version to main.dart.js references
echo "🔄 Patching main.dart.js references with version..."
sed -i '' "s/\"main.dart.js\"/\"main.dart.js?v=$version\"/g" build/web/flutter.js
sed -i '' "s/\"main.dart.js\"/\"main.dart.js?v=$version\"/g" build/web/flutter_bootstrap.js
sed -i '' "s/\"main.dart.js\"/\"main.dart.js?v=$version\"/g" build/web/index.html

# Add version to assets loader
echo "🎯 Patching assets loader with version..."
sed -i '' "s/self\.window\.fetch(a),/self.window.fetch(a + '?v=$version'),/g" build/web/main.dart.js

# Add version to manifest.json
echo "📱 Adding version to manifest.json..."
sed -i '' 's/"manifest.json"/"manifest.json?v='"$version"'"/' build/web/index.html

# Add version to service worker (if exists)
if [ -f "build/web/flutter_service_worker.js" ]; then
    echo "⚙️  Adding version to service worker..."
    sed -i '' "s/flutter_service_worker.js/flutter_service_worker.js?v=$version/g" build/web/index.html
fi

echo "✅ Build completed! Version: $version"
echo "📦 Built files are in build/web/"
echo ""
echo "🚀 Ready to deploy to Vercel!"
echo "   All critical files now have version parameters to prevent caching issues." 