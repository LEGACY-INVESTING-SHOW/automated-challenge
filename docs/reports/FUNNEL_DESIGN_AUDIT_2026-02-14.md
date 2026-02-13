# Funnel Design + Migration Audit (2026-02-14)

## Scope Reviewed

- All files in `/automated challenge`
- Funnel pages reviewed in browser using `agent-browser` and scrolled end-to-end:
  - `summit.html`
  - `ticket-redesign.html`
  - `vip-redesign.html`
  - `vip-ticket-modern.html`
  - `prepkitvip-redesign.html`
  - `tax report upsell.html`
  - `challengeconfirmation-redesign.html`
- Utility page reviewed: `pdf-render.html`
- Screenshots captured to: `screenshots/design-audit/`

## Migration Verification Status

### Overall Status: **Partially complete**

What is working:
- All 7 funnel pages include Google Fonts + Lucide
- All 7 funnel pages include noise overlay markup
- 6/7 pages include `design-system.css` (missing on `summit.html`)
- Brand gold palette appears in most pages

What is not fully migrated:
- `summit.html` still uses mixed architecture (`/dist/output.css`, Tailwind utility classes, inline CSS, legacy `Inter`/`Newsreader` font-face blocks)
- Event automation was injected incorrectly in all 7 pages:
  - `<!-- Event Date Automation -->n  <script src="event-automation.js"></script>`
  - Literal `n` is present in markup
- `event-automation.js` is not actually wired to page countdown/date systems:
  - No page references `window.eventTargetDate`
  - No page uses expected hooks (`data-date-type`, `.event-date-range`, etc.)
- Several pages still use hardcoded countdown dates in inline JS
- Multiple pages initialize Lucide twice

## Critical Cross-Page Inconsistencies

### 1) CTA system inconsistency (highest conversion risk)
- **Tax report upsell** CTA pattern is clean and premium:
  - Primary CTA as strong gold button
  - Single clear decline link
- **Prep kit page** CTA pattern is weaker:
  - Two separate decline links stacked (decision friction + visual clutter)
  - Long negative copy lines reduce scannability
- **VIP modern page** has button-only CTAs without clear destination links in the main pricing area

### 2) Design architecture inconsistency
- Mix of:
  - Tailwind CDN pages (`tax report upsell.html`, `vip-ticket-modern.html`, `ticket-redesign.html`)
  - Custom CSS pages (`prepkitvip-redesign.html`, `vip-redesign.html`, `challengeconfirmation-redesign.html`)
  - Hybrid legacy page (`summit.html`)
- Result: visual drift and difficult maintenance

### 3) Typography and token drift on `summit.html`
- Still contains old font-face declarations for `Inter` and `Newsreader`
- Uses amber fragments and slate-heavy surfaces in spots
- Not linked to `design-system.css`

### 4) Accessibility inconsistency
- Focus styles are not consistently defined via shared system classes
- Some pages rely on custom one-off styles only

## Page-by-Page Findings

### `tax report upsell.html`
- Strongest CTA structure and hierarchy
- Good emotional contrast between accept/decline actions
- Uses Tailwind + custom CSS + design-system (hybrid complexity)

### `prepkitvip-redesign.html`
- Visually flatter than other upsell pages
- CTA section feels dated relative to tax report page
- Two decline links create unnecessary friction/noise

### `vip-ticket-modern.html`
- Strong visual polish and pacing
- Primary CTA in pricing block is a `<button>` (not a direct checkout link)
- Main decline action is also a `<button>` (flow ambiguity)

### `vip-redesign.html`
- Cohesive custom-CSS structure
- Includes duplicate Lucide initialization
- Hardcoded countdown date remains

### `ticket-redesign.html`
- Contains large internal utility class duplication despite Tailwind usage
- Hardcoded countdown date remains
- Includes duplicate Lucide initialization

### `challengeconfirmation-redesign.html`
- Good structure and information architecture
- Date copy has duplication artifacts (example: "Friday, Friday")
- Hardcoded countdown date remains
- Includes duplicate Lucide initialization

### `summit.html`
- Most inconsistent page in code architecture
- Still carries legacy font-face blocks and `/dist/output.css`
- Still includes amber-gradient button styles in key CTAs
- Migration not complete relative to other pages

## Migration/Automation Defects To Fix First

1. Replace malformed event script injection in all pages
2. Wire countdown logic to `window.eventTargetDate` fallback model
3. Remove duplicate Lucide initialization blocks
4. Normalize summit architecture to same foundation as other pages
5. Standardize CTA component pair across upsell pages:
   - Primary (`btn-primary` style)
   - Secondary decline link style (single, consistent)

## Folder Cleanup Completed

The root folder was reduced and organized without deleting core runtime assets.

### New structure
- `docs/reports/` → report artifacts
- `docs/migration/` → migration + automation docs
- `scripts/` → migration scripts
- `backups/` → backup HTML files

### Runtime assets kept in root
- All funnel `.html` pages
- `design-system.css`
- `event-automation.js`
- `screenshots/`

## Evidence

- Desktop full-page screenshots:
  - `screenshots/design-audit/summit-full.png`
  - `screenshots/design-audit/ticket-redesign-full.png`
  - `screenshots/design-audit/vip-redesign-full.png`
  - `screenshots/design-audit/vip-ticket-modern-full.png`
  - `screenshots/design-audit/prepkitvip-full.png`
  - `screenshots/design-audit/tax-report-upsell-full.png`
  - `screenshots/design-audit/challengeconfirmation-full.png`
  - `screenshots/design-audit/pdf-render-full.png`
