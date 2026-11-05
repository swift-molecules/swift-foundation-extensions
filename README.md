# swift-foundation-extensions

Use this package when your code already works in Foundation's `Foundation.Date` and `Foundation.Calendar` and you need calendar arithmetic, period bounds, weekday and business-day navigation, or short English duration and relative-time strings, with the calendar always passed explicitly rather than taken from the system's current calendar. Start from the extensions on `Foundation.Date`, `Foundation.Calendar` and `Foundation.DateComponents`; `Foundation.Locale.Weekday` lives in the internationalization half. Use the sibling swift-calendar-gregorian instead when you want Gregorian dates without Foundation. Use Foundation's own format styles when the output must be localized: every string produced here is fixed English.

## Laws

- Periods are half-open. A day, week, month or year runs from its first instant up to, not including, the first instant of the next one, so `endOfDay(in:)`, `endOfWeek(in:)`, `endOfMonth(in:)` and `endOfYear(in:)` return that next first instant, and the period does not contain it. Bounds are taken in the passed calendar's time zone, and a week starts on its `firstWeekday`.
- The `Foundation.Date` year-month-day initializer returns nil both for out-of-range fields and for dates the calendar does not have, such as February 29 in a common year: it round-trips the components through the calendar instead of letting Foundation roll them over.
- Weekday numbers follow `Foundation.Calendar`: Sunday is 1, Saturday 7. A number outside 1 through 7 gives nil.
- The weekend is whatever the calendar's `isDateInWeekend` says. The weekend-skipping methods return a weekday unchanged; `addingBusinessDays(_:in:)` with a negative count walks backwards, and weekend days never count.
- `daysBetween(_:in:)` counts calendar days between the two start-of-days and is signed: it is negative when the argument is earlier.
- `Foundation.DateComponents` arithmetic (`adding`, `subtracting`, `multiplied`) applies the offsets to `now` and decomposes the resulting span again, so the result is normalized and depends on `now`: two weeks minus three days is one week and four days. `isValid(for:)` checks only field ranges unless a year or week-based year is set, so an offset such as two months is valid for any calendar.
- `formattedDuration` uses the largest unit the interval reaches: seconds and minutes whole, hours, days and weeks to one decimal, rounding half to even (1.25 hours is `1.2h`). A negative interval is always formatted in seconds, because every negative value is below one minute.
- `Foundation.AttributedString(highlighting:open:close:)` drops the markers and strongly emphasizes the text between them; it and the ranges initializer exist on Apple platforms only.
