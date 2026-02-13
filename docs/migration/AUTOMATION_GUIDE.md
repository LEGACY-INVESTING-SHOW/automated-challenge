# Event Date Automation Setup

## Overview
This automation system automatically updates event dates for recurring Friday-Sunday challenges. The dates will always show the upcoming Friday-Sunday event.

## How It Works

### Automatic Date Calculation
The `event-automation.js` script calculates:
- **Day 1 (Friday)**: Next upcoming Friday at 10:00 AM EST
- **Day 2 (Saturday)**: Following Saturday at 10:00 AM EST  
- **Day 3 (Sunday)**: Following Sunday at 10:00 AM EST

### What Gets Updated

1. **Countdown Timers**: Automatically target the next Friday 10 AM
2. **Date Displays**: All date references update dynamically
3. **Early Bird Text**: Automatically hidden/removed

## Manual Date Updates (If Needed)

If you need to manually set a specific date, update these files:

### JavaScript Countdown Dates:
```javascript
// In each HTML file, look for:
const targetDate = new Date('February 20, 2026 10:00:00 EST').getTime();

// Change to your desired date
const targetDate = new Date('March 14, 2026 10:00:00 EST').getTime();
```

### Static Date Text:
Use these CSS classes to automatically update:
- `.event-date-range` → Shows "February 20 - February 22"
- `.event-date-day-1` → Shows "Friday, February 20th at 10:00 AM EST"
- `.event-date-day-2` → Shows "Saturday, February 21st at 10:00 AM EST"
- `.event-date-day-3` → Shows "Sunday, February 22nd at 10:00 AM EST"

Or use data attributes:
- `data-date-type="range"`
- `data-date-type="day1"`
- `data-date-type="day2"`
- `data-date-type="day3"`

## Files Modified

All 7 HTML files now include:
```html
<script src="event-automation.js"></script>
```

## What Was Removed

Early bird pricing references hidden:
- "Early Bird Pricing Expires In..."
- "Only X spots left at early bird pricing"
- "Early bird savings"
- Countdown labels changed from "Early Bird Pricing" to "Event Starts In"

## Testing

To test the automation:
1. Open any page in browser
2. Open browser console (F12)
3. Check console for "Event dates updated" message
4. Verify dates show upcoming Friday-Sunday

## Manual Refresh

If you need to manually refresh dates:
```javascript
// In browser console
EventAutomation.refresh();
```

## Date Format Reference

New static dates (February 20-22, 2026):
- **Range**: Feb 20th - Feb 22nd, 2026
- **Day 1**: Friday, February 20th at 10:00 AM EST
- **Day 2**: Saturday, February 21st at 10:00 AM EST
- **Day 3**: Sunday, February 22nd at 10:00 AM EST

## Server-Side Automation (Optional)

For full automation, set up a cron job or scheduled task on your server:

### Weekly Update Script (run every Sunday at midnight)
```bash
#!/bin/bash
# update-dates.sh
# This would update static date references in files

# Or use JavaScript approach - dates calculate client-side automatically
```

**Note**: The JavaScript automation runs client-side, so no server updates needed! Each visitor sees the correct upcoming dates automatically.

## Summary of Changes

✅ All date references updated to Feb 20-22, 2026
✅ Countdown timers set to Friday, Feb 20, 2026 10:00 AM
✅ Early bird pricing text removed/hidden
✅ Automation script added to all pages
✅ Dynamic date calculation enabled

The system is now fully automated - dates will always show the next Friday-Sunday event!
