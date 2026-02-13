/**
 * Event Date Automation Script
 * Automatically calculates and updates dates for recurring Friday-Sunday events
 * 
 * Usage: Include this script in the <head> of your HTML pages
 * <script src="event-automation.js"></script>
 */

(function() {
  'use strict';

  // Configuration
  const CONFIG = {
    eventDay: 5, // Friday (0 = Sunday, 5 = Friday)
    eventHour: 10, // 10:00 AM
    eventMinute: 0,
    timezone: 'EST'
  };

  /**
   * Get the next occurrence of Friday at 10 AM EST
   * @returns {Date} The next Friday 10 AM date
   */
  function getNextEventDate() {
    const now = new Date();
    const currentDay = now.getDay(); // 0 = Sunday, 5 = Friday
    
    // Calculate days until next Friday
    let daysUntilFriday = CONFIG.eventDay - currentDay;
    if (daysUntilFriday < 0) {
      daysUntilFriday += 7;
    }
    
    // Create date for next Friday at 10 AM
    const nextFriday = new Date(now);
    nextFriday.setDate(now.getDate() + daysUntilFriday);
    nextFriday.setHours(CONFIG.eventHour, CONFIG.eventMinute, 0, 0);

    // If it's already Friday after event start, move to next Friday.
    if (daysUntilFriday === 0 && now.getTime() >= nextFriday.getTime()) {
      nextFriday.setDate(nextFriday.getDate() + 7);
    }
    
    return nextFriday;
  }

  /**
   * Format date as "Month Day" (e.g., "February 20")
   * @param {Date} date - Date to format
   * @returns {string} Formatted date string
   */
  function formatDateShort(date) {
    const options = { month: 'long', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
  }

  /**
   * Format date as "Month Dayth" (e.g., "February 20th")
   * @param {Date} date - Date to format
   * @returns {string} Formatted date string with ordinal
   */
  function formatDateWithOrdinal(date) {
    const day = date.getDate();
    const suffix = getOrdinalSuffix(day);
    const month = date.toLocaleDateString('en-US', { month: 'long' });
    return `${month} ${day}${suffix}`;
  }

  /**
   * Get ordinal suffix for a number (st, nd, rd, th)
   * @param {number} n - Number
   * @returns {string} Ordinal suffix
   */
  function getOrdinalSuffix(n) {
    const s = ["th", "st", "nd", "rd"];
    const v = n % 100;
    return s[(v - 20) % 10] || s[v] || s[0];
  }

  /**
   * Get day name (Friday, Saturday, Sunday)
   * @param {Date} date - Date object
   * @returns {string} Day name
   */
  function getDayName(date) {
    return date.toLocaleDateString('en-US', { weekday: 'long' });
  }

  /**
   * Update all date elements on the page
   */
  function updateAllDates() {
    const nextFriday = getNextEventDate();
    const nextSaturday = new Date(nextFriday);
    nextSaturday.setDate(nextFriday.getDate() + 1);
    const nextSunday = new Date(nextFriday);
    nextSunday.setDate(nextFriday.getDate() + 2);

    // Format date strings
    const dateRangeShort = `${formatDateShort(nextFriday)} - ${formatDateShort(nextSunday)}`;
    const dateRangeFull = `${formatDateWithOrdinal(nextFriday)} - ${formatDateWithOrdinal(nextSunday)}`;
    const day1Full = `${getDayName(nextFriday)}, ${formatDateWithOrdinal(nextFriday)} at 10:00 AM EST`;
    const day2Full = `${getDayName(nextSaturday)}, ${formatDateWithOrdinal(nextSaturday)} at 10:00 AM EST`;
    const day3Full = `${getDayName(nextSunday)}, ${formatDateWithOrdinal(nextSunday)} at 10:00 AM EST`;

    // Update data attributes for CSS/JS reference
    document.documentElement.setAttribute('data-event-day-1', day1Full);
    document.documentElement.setAttribute('data-event-day-2', day2Full);
    document.documentElement.setAttribute('data-event-day-3', day3Full);
    document.documentElement.setAttribute('data-event-range', dateRangeShort);

    // Find and update specific elements by class or ID
    updateElementsByClass('event-date-range', dateRangeShort);
    updateElementsByClass('event-date-day-1', day1Full);
    updateElementsByClass('event-date-day-2', day2Full);
    updateElementsByClass('event-date-day-3', day3Full);
    
    // Update elements with specific data attributes
    document.querySelectorAll('[data-date-type="range"]').forEach(el => {
      el.textContent = dateRangeFull;
    });
    
    document.querySelectorAll('[data-date-type="day1"]').forEach(el => {
      el.textContent = day1Full;
    });
    
    document.querySelectorAll('[data-date-type="day2"]').forEach(el => {
      el.textContent = day2Full;
    });
    
    document.querySelectorAll('[data-date-type="day3"]').forEach(el => {
      el.textContent = day3Full;
    });

    // Update countdown timer target
    updateCountdownTarget(nextFriday);

    console.log('Event dates updated:', dateRangeFull);
  }

  /**
   * Update text content of elements by class name
   * @param {string} className - CSS class to find
   * @param {string} text - Text to set
   */
  function updateElementsByClass(className, text) {
    document.querySelectorAll(`.${className}`).forEach(el => {
      el.textContent = text;
    });
  }

  /**
   * Update countdown timer target date
   * @param {Date} targetDate - The target date for countdown
   */
  function updateCountdownTarget(targetDate) {
    // Store in window for access by other scripts
    window.eventTargetDate = targetDate.getTime();
    window.dispatchEvent(new CustomEvent('event-target-updated', {
      detail: { timestamp: window.eventTargetDate }
    }));
    
    // Update existing countdown elements
    const countdownElements = document.querySelectorAll('[id*="countdown"], [id*="timer"]');
    countdownElements.forEach(el => {
      el.setAttribute('data-target', targetDate.getTime());
    });

    // Trigger countdown update if function exists
    if (typeof updateCountdown === 'function') {
      updateCountdown();
    }
  }

  /**
   * Remove early bird pricing text
   */
  function removeEarlyBirdText() {
    // Hide only explicitly early-bird tagged UI blocks.
    document.querySelectorAll('[data-early-bird], [class*="early-bird"], [id*="early-bird"]').forEach(el => {
      el.style.display = 'none';
    });

    // Update countdown labels
    document.querySelectorAll('.countdown-label, .timer-label, [class*="countdown"]').forEach(el => {
      const text = (el.textContent || '').toLowerCase();
      if (text.includes('early bird')) {
        el.textContent = 'Challenge Starts In';
      }
      if (text.includes('pricing expires')) {
        el.textContent = 'Event Starts In';
      }
    });

    // Fix common duplicated weekday artifacts in legacy static copy.
    const weekdayFixes = [
      [/Friday,\s*Friday,/g, 'Friday,'],
      [/Saturday,\s*Saturday,/g, 'Saturday,'],
      [/Sunday,\s*Sunday,/g, 'Sunday,']
    ];

    document.querySelectorAll('p, span, li, h1, h2, h3, h4').forEach(el => {
      let text = el.textContent;
      if (!text) return;

      weekdayFixes.forEach(([regex, replacement]) => {
        text = text.replace(regex, replacement);
      });

      if (text !== el.textContent) {
        el.textContent = text;
      }
    });
  }

  /**
   * Initialize everything when DOM is ready
   */
  function init() {
    // Update all dates
    updateAllDates();
    
    // Remove early bird text
    removeEarlyBirdText();
    
    // Re-run after a short delay to catch dynamically loaded content
    setTimeout(() => {
      updateAllDates();
      removeEarlyBirdText();
    }, 1000);
  }

  // Make target date available immediately for page-level countdown scripts.
  window.eventTargetDate = getNextEventDate().getTime();

  // Run when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // Expose to global scope for manual triggering
  window.EventAutomation = {
    updateDates: updateAllDates,
    getNextEventDate: getNextEventDate,
    refresh: init
  };

})();
