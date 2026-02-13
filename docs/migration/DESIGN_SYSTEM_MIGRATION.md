# Legacy Investing Show - Design System Migration Guide

## Overview
This document provides step-by-step instructions for standardizing all 7 HTML pages to use the unified design system.

---

## Critical Changes Required

### 1. Font Standardization
**Current Issue:** Summit uses Newsreader + Inter, others use Crimson Pro + Sora

**Fix:** Update summit.html `<head>`:
```html
<!-- Remove these -->
<link rel="preload" href="/assets/fonts/inter-latin.woff2" as="font" type="font/woff2" crossorigin>
<link rel="preload" href="/assets/fonts/newsreader-latin-400.woff2" as="font" type="font/woff2" crossorigin>

<!-- Add these -->
<link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,400;0,500;0,600;0,700;1,400&family=JetBrains+Mono:wght@400;500&family=Sora:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>
```

**CSS Updates:**
- Replace `.font-display { font-family: 'Newsreader', ... }` with `.font-display { font-family: 'Crimson Pro', ... }`
- Replace `.font-body { font-family: 'Inter', ... }` with standard body font
- Update all `text-amber-400` to `text-[#c9a962]` or custom class

### 2. Color Standardization

**Amber → Gold Migration:**
```css
/* Old (Summit) */
#d4a84a, #e8c86a, #b89830, #f59e0b, #d97706, #fbbf24

/* New (Standard) */
#c9a962, #e0c078, #a68b4b
```

**Background Colors:**
```css
/* Old */
#0a0a0f, #050507, #0d0d14, #12110a

/* New */
#0a0a0b, #121214, #1a1a1d
```

### 3. Icon Standardization

**Replace inline SVGs with Lucide:**
```html
<!-- Old -->
<svg class="w-5 h-5"><use href="#star-icon"/></svg>

<!-- New -->
<i data-lucide="star" class="w-5 h-5 text-gold fill-current"></i>
```

**Initialize Lucide:**
```javascript
<script>
  document.addEventListener('DOMContentLoaded', () => {
    lucide.createIcons();
  });
</script>
```

### 4. Button Standardization

**Standard Primary Button:**
```html
<a href="#cta" class="btn btn-primary">
  Button Text
  <i data-lucide="arrow-right" class="w-5 h-5"></i>
</a>
```

**Standard Secondary Button:**
```html
<a href="#cta" class="btn btn-secondary">
  Button Text
</a>
```

### 5. Card Standardization

**Standard Card:**
```html
<div class="card">
  <div class="card-header">
    <div class="card-icon">
      <i data-lucide="icon-name" class="w-6 h-6 text-gold"></i>
    </div>
    <span class="card-step">Step 01</span>
  </div>
  <h3 class="card-title">Card Title</h3>
  <div class="card-body">
    <p>Card content...</p>
  </div>
</div>
```

### 6. Countdown Timer Standardization

**Standard Countdown:**
```html
<div class="countdown">
  <div class="countdown-item">
    <div class="countdown-number" id="days">00</div>
    <div class="countdown-label">Days</div>
  </div>
  <!-- Repeat for hours, minutes, seconds -->
</div>
```

### 7. Progress Bar Standardization

**Standard Progress Bar:**
```html
<div class="progress-bar">
  <div class="progress-bar-fill" style="width: 75%;"></div>
</div>
```

### 8. Badge Standardization

**Standard Badges:**
```html
<!-- VIP Badge -->
<span class="badge badge-vip">VIP Access</span>

<!-- Urgency Badge -->
<span class="badge badge-urgency">Limited Time</span>

<!-- Guarantee Badge -->
<span class="badge badge-guarantee">7-Day Guarantee</span>
```

### 9. FAQ Accordion Standardization

**Standard FAQ:**
```html
<div class="faq-item">
  <button class="faq-question" aria-expanded="false">
    Question text
    <i data-lucide="plus" class="w-5 h-5 faq-icon"></i>
  </button>
  <div class="faq-answer">
    <div class="faq-answer-content">
      Answer text...
    </div>
  </div>
</div>
```

---

## Page-Specific Tasks

### summit.html (CRITICAL)
- [ ] Update font imports to Crimson Pro + Sora
- [ ] Replace all amber colors with gold (#c9a962)
- [ ] Add Lucide icons CDN
- [ ] Replace inline SVG icons with Lucide
- [ ] Update background colors to #0a0a0b
- [ ] Add noise overlay
- [ ] Standardize button styles
- [ ] Standardize card styles
- [ ] Add custom scrollbar styling
- [ ] Add focus states for accessibility

### challengeconfirmation-redesign.html
- [ ] Link to design-system.css
- [ ] Update button classes to use standardized names
- [ ] Standardize card border opacities
- [ ] Ensure all icons use Lucide

### ticket-redesign.html
- [ ] Remove duplicate Tailwind classes
- [ ] Link to design-system.css
- [ ] Standardize countdown styling
- [ ] Update button hover effects

### vip-redesign.html
- [ ] Link to design-system.css
- [ ] Standardize progress bar height (12px)
- [ ] Update VIP badge styling
- [ ] Standardize session list styling

### prepkitvip-redesign.html
- [ ] Link to design-system.css
- [ ] Standardize product card hover effects
- [ ] Update urgency badge styling

### vip-ticket-modern.html
- [ ] Link to design-system.css
- [ ] Standardize benefit card icons
- [ ] Update pricing card border styling

### tax report upsell.html
- [ ] Link to design-system.css
- [ ] Standardize comparison table styling
- [ ] Update editorial grid classes

---

## Implementation Order

1. **Phase 1: Foundation**
   - Create design-system.css ✓
   - Fix summit.html (most critical)
   - Test summit.html thoroughly

2. **Phase 2: Core Pages**
   - Update challengeconfirmation-redesign.html
   - Update ticket-redesign.html
   - Update vip-redesign.html

3. **Phase 3: Secondary Pages**
   - Update prepkitvip-redesign.html
   - Update vip-ticket-modern.html
   - Update tax report upsell.html

4. **Phase 4: Testing**
   - Cross-browser testing
   - Mobile responsiveness check
   - Accessibility audit

---

## CSS Architecture

### Design System Structure
```
design-system.css
├── 1. CSS Variables (Colors, Typography, Spacing)
├── 2. Base Styles & Reset
├── 3. Typography System
├── 4. Layout Utilities
├── 5. Button Components
├── 6. Card Components
├── 7. Badge Components
├── 8. Form Components
├── 9. Navigation
├── 10. Countdown Timer
├── 11. Progress Bar
├── 12. FAQ Accordion
├── 13. Utility Classes
├── 14. Special Effects (Noise, Glow)
├── 15. Keyframe Animations
├── 16. Accessibility
├── 17. Responsive Utilities
└── 18. Custom Scrollbar
```

### Usage in HTML Files
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Crimson+Pro:ital,wght@0,400;0,500;0,600;0,700;1,400&family=JetBrains+Mono:wght@400;500&family=Sora:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  
  <!-- Lucide Icons -->
  <script src="https://unpkg.com/lucide@latest"></script>
  
  <!-- Design System -->
  <link rel="stylesheet" href="design-system.css">
  
  <!-- Page-specific styles (override if needed) -->
  <style>
    /* Page-specific overrides */
  </style>
</head>
<body>
  <!-- Noise overlay -->
  <div class="noise-overlay"></div>
  
  <!-- Content -->
  
  <script>
    // Initialize Lucide icons
    document.addEventListener('DOMContentLoaded', () => {
      lucide.createIcons();
    });
  </script>
</body>
</html>
```

---

## Testing Checklist

### Visual Consistency
- [ ] All gold colors match #c9a962
- [ ] All fonts use Crimson Pro (headings) + Sora (body)
- [ ] Noise overlay visible (3% opacity)
- [ ] Custom scrollbar styled (gold on dark)
- [ ] Button shimmer effects work
- [ ] Card hover effects consistent

### Functionality
- [ ] All Lucide icons render
- [ ] Countdown timers update
- [ ] FAQ accordions expand/collapse
- [ ] Smooth scroll works
- [ ] Sticky headers function

### Responsive
- [ ] Mobile layout correct
- [ ] Tablet layout correct
- [ ] Desktop layout correct
- [ ] No horizontal overflow
- [ ] Touch targets minimum 44px

### Accessibility
- [ ] Focus states visible
- [ ] ARIA labels on interactive elements
- [ ] Reduced motion respected
- [ ] Color contrast WCAG AA compliant
- [ ] Skip link present

---

## Common Issues & Solutions

### Issue: Icons not showing
**Solution:** Ensure `lucide.createIcons()` is called after DOM loads

### Issue: Colors not matching
**Solution:** Check for inline styles overriding CSS variables

### Issue: Fonts not loading
**Solution:** Verify Google Fonts link and check for typos in font-family

### Issue: Buttons missing shimmer
**Solution:** Add `btn-primary` class and ensure `::before` pseudo-element CSS is present

### Issue: Cards not hovering
**Solution:** Check that card has `transition` property and hover state defined

---

## File Inventory

| File | Priority | Status | Notes |
|------|----------|--------|-------|
| design-system.css | CRITICAL | ✅ Complete | Foundation file |
| summit.html | CRITICAL | 🔄 In Progress | Major changes needed |
| challengeconfirmation-redesign.html | HIGH | ⏳ Pending | Medium changes |
| ticket-redesign.html | HIGH | ⏳ Pending | Medium changes |
| vip-redesign.html | HIGH | ⏳ Pending | Medium changes |
| prepkitvip-redesign.html | MEDIUM | ⏳ Pending | Minor changes |
| vip-ticket-modern.html | MEDIUM | ⏳ Pending | Minor changes |
| tax report upsell.html | MEDIUM | ⏳ Pending | Minor changes |

---

## Success Criteria

All pages must:
1. Use Crimson Pro + Sora + JetBrains Mono fonts
2. Use brand gold (#c9a962) consistently
3. Include Lucide icons (not inline SVGs)
4. Have noise overlay texture
5. Use custom gold scrollbar
6. Have consistent button styles
7. Have consistent card styles
8. Include focus states
9. Support reduced motion
10. Be fully responsive

---

*Last Updated: February 14, 2026*
*Version: 1.0.0*
