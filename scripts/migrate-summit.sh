#!/bin/bash

# Summit.html Design System Migration Script
# This script updates summit.html to match the unified design system

set -e  # Exit on error

echo "🎨 Starting summit.html design system migration..."

# Backup original file
cp summit.html summit.html.backup
echo "✅ Created backup: summit.html.backup"

# 1. Update font imports - Remove Newsreader/Inter, add Crimson Pro/Sora
echo "📝 Updating font imports..."
sed -i '' 's|<!-- Preload self-hosted fonts -->|<!-- Google Fonts -->|g' summit.html
sed -i '' '/<link rel="preload" href="\/assets\/fonts\/inter-latin.woff2"/d' summit.html
sed -i '' '/<link rel="preload" href="\/assets\/fonts\/newsreader-latin-400.woff2"/d' summit.html

# Add Google Fonts and Lucide after the preconnect lines
sed -i '' 's|  <link rel="preconnect" href="https://player.vimeo.com" crossorigin>|  <link rel="preconnect" href="https://player.vimeo.com" crossorigin>\n\n  <!-- Google Fonts -->\n  <link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,400;0,500;0,600;0,700;1,400\&family=JetBrains+Mono:wght@400;500\&family=Sora:wght@300;400;500;600;700\&display=swap" rel="stylesheet">\n\n  <!-- Lucide Icons -->\n  <script src="https://unpkg.com/lucide@latest"></script>|g' summit.html

# 2. Replace font-family definitions in CSS
echo "📝 Updating font-family CSS..."
sed -i '' "s|font-family: 'Newsreader', Georgia, 'Times New Roman', serif|font-family: 'Crimson Pro', Georgia, 'Times New Roman', serif|g" summit.html
sed -i '' "s|font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif|font-family: 'Sora', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif|g" summit.html

# 3. Add noise overlay div before closing </body>
echo "📝 Adding noise overlay..."
sed -i '' 's|<body class="font-body|<div class="noise-overlay"></div>\n\n<body class="font-body|g' summit.html

# 4. Replace amber colors with gold
echo "🔄 Converting amber colors to gold..."
# text-amber-400 -> text-[#c9a962]
sed -i '' 's/text-amber-400/text-[#c9a962]/g' summit.html
# bg-amber-500/20 -> bg-[#c9a962]/20
sed -i '' 's/bg-amber-500\/20/bg-[#c9a962]\/20/g' summit.html
sed -i '' 's/bg-amber-500\/10/bg-[#c9a962]\/10/g' summit.html
# border-amber-500 -> border-[#c9a962]
sed -i '' 's/border-amber-500/border-[#c9a962]/g' summit.html
# from-amber-500/20 -> from-[#c9a962]/20
sed -i '' 's/from-amber-500\/20/from-[#c9a962]\/20/g' summit.html
# to-amber-600/10 -> to-[#a68b4b]/10
sed -i '' 's/to-amber-600\/10/to-[#a68b4b]\/10/g' summit.html
# from-amber-400 -> from-[#e0c078]
sed -i '' 's/from-amber-400/from-[#e0c078]/g' summit.html
# to-amber-500 -> to-[#c9a962]
sed -i '' 's/to-amber-500/to-[#c9a962]/g' summit.html
# bg-amber-900/30 -> bg-[#a68b4b]/20
sed -i '' 's/bg-amber-900\/30/bg-[#a68b4b]\/20/g' summit.html
# ring-amber-500/20 -> ring-[#c9a962]/20
sed -i '' 's/ring-amber-500\/20/ring-[#c9a962]\/20/g' summit.html
# amber-200 -> [#e0c078]
sed -i '' 's/text-amber-200/text-[#e0c078]/g' summit.html

# 5. Update text gradient gold CSS
echo "🔄 Updating gold gradient CSS..."
sed -i '' 's/#d4a84a 0%, #e8c86a 50%, #b89830 100%/#e0c078 0%, #c9a962 50%, #a68b4b 100%/g' summit.html

# 6. Update background colors
echo "🔄 Updating background colors..."
sed -i '' 's/#0a0a0f/#0a0a0b/g' summit.html
sed -i '' 's/#050507/#0a0a0b/g' summit.html
sed -i '' 's/#0d0d14/#121214/g' summit.html
sed -i '' 's/#12110a/#121214/g' summit.html

# 7. Add Lucide initialization before closing </body>
echo "📝 Adding Lucide initialization..."
sed -i '' 's|</body>|  <script>\n    document.addEventListener("DOMContentLoaded", () => {\n      lucide.createIcons();\n    });\n  </script>\n</body>|g' summit.html

# 8. Add noise overlay CSS if not present
echo "📝 Adding noise overlay CSS..."
sed -i '' '/\/\* Custom utilities not in Tailwind \*\//a\
    /* Noise texture overlay */\
    .noise-overlay {\
      position: fixed;\
      top: 0;\
      left: 0;\
      width: 100%;\
      height: 100%;\
      pointer-events: none;\
      z-index: 1000;\
      opacity: 0.03;\
      background-image: url("data:image/svg+xml,%3Csvg viewBox=\'0 0 256 256\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cfilter id=\'noise\'%3E%3CfeTurbulence type=\'fractalNoise\' baseFrequency=\'0.9\' numOctaves=\'4\' stitchTiles=\'stitch\'/%3E%3C/filter%3E%3Crect width=\'100%25\' height=\'100%25\' filter=\'url(%23noise)\'/%3E%3C/svg%3E");\
    }\
' summit.html

# 9. Add custom scrollbar CSS
echo "📝 Adding custom scrollbar CSS..."
sed -i '' '/\/\* Mobile optimizations \*\//i\
    /* Custom scrollbar */\
    ::-webkit-scrollbar {\
      width: 8px;\
    }\
    ::-webkit-scrollbar-track {\
      background: #121214;\
    }\
    ::-webkit-scrollbar-thumb {\
      background: #a68b4b;\
      border-radius: 4px;\
    }\
    ::-webkit-scrollbar-thumb:hover {\
      background: #c9a962;\
    }\
    * {\
      scrollbar-width: thin;\
      scrollbar-color: #a68b4b #121214;\
    }\
' summit.html

# 10. Add focus-visible styles for accessibility
echo "📝 Adding accessibility styles..."
sed -i '' '/\/\* Mobile optimizations \*\//i\
    /* Focus states for accessibility */\
    :focus-visible {\
      outline: 2px solid #c9a962;\
      outline-offset: 2px;\
    }\
    a:focus-visible,\
    button:focus-visible {\
      outline: 2px solid #c9a962;\
      outline-offset: 2px;\
    }\
' summit.html

# 11. Remove duplicate font face declarations since we're using Google Fonts
echo "🧹 Removing self-hosted font declarations..."
sed -i '' '/@font-face {/,/}/d' summit.html

# 12. Remove the Tailwind output.css reference since we'll use inline styles
echo "📝 Updating CSS reference..."
sed -i '' 's|<link rel="stylesheet" href="/dist/output.css">|<!-- Design system styles are inline -->|g' summit.html

echo ""
echo "✅ Migration complete!"
echo ""
echo "Summary of changes:"
echo "  - Fonts: Newsreader+Inter → Crimson Pro+Sora+JetBrains Mono"
echo "  - Colors: Amber → Gold (#c9a962)"
echo "  - Backgrounds: #0a0a0f → #0a0a0b"
echo "  - Added: Noise overlay, Lucide icons, custom scrollbar"
echo "  - Added: Focus states for accessibility"
echo ""
echo "Next steps:"
echo "  1. Review summit.html manually for any remaining amber references"
echo "  2. Replace inline SVG icons with Lucide equivalents"
echo "  3. Test the page in browser"
echo "  4. Compare with other standardized pages"
echo ""
echo "Backup available at: summit.html.backup"