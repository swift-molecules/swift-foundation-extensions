# swift-foundation-extensions

Use this package when you work with Foundation dates and want calendar arithmetic, period bounds, weekday and business-day navigation, or short duration and relative-time strings, without reaching for `Calendar.current`: every calendar-dependent operation takes the `Calendar` explicitly. It also adds a few small conveniences on `Data`, `String` and `AttributedString`. Use Foundation's own `FormatStyle`s and `RelativeDateTimeFormatter` instead when you need localized output; the strings here are fixed English.

## Model

All additions are extensions on Foundation and standard-library value types; nothing here holds state.

- `Date(year:month:day:hour:minute:second:in:)` is a failable initializer. Component accessors (`year(in:)`, `weekday(in:)`, `quarter(in:)`, …) return `Int`; `adding(_:in:)` and `subtracting(_:in:)` return `Date?`.
- `Int` builds `DateComponents` offsets: `1.day`, `2.hours`, `3.months`, `2.weeksOfYear`. `DateComponents` gains `negated()`, `adding(_:in:now:)`, `subtracting(_:in:now:)`, `multiplied(by:in:now:)`, `zero`, `isValid` and `isValid(for:)`.
- `Calendar.day(containing:)`, `week(containing:)`, `month(containing:)` and `year(containing:)` return the period as `Range<Date>?`. `Date.startOfDay(in:)` and `startOfWeek/Month/Year(in:)` give its lower bound; `endOfDay/Week/Month/Year(in:)` give its upper bound.
- `Calendar.nextHour(after:)` and `Calendar.date(day:time:)` exist both as instance methods and as static methods taking `in calendar:`. `Calendar(identifier:timeZone:)` sets the time zone at creation.
- Weekdays: `next(_:in:)` and `previous(_:in:)` take `Calendar` weekday numbers (Sunday 1 … Saturday 7). With the internationalization half, `Locale.Weekday.number` maps a `Locale.Weekday` to that number, and `Date.next(_:in:)` and `Calendar.next(_:after:)` accept a `Locale.Weekday`.
- Workdays: `isWeekend(in:)`, `nextWeekday(in:)`, `ifWeekendThenNextWorkday(in:)`, `ifWeekendThenPreviousWorkday(in:)`, `addingBusinessDays(_:in:)` and `daysBetween(_:in:)`.
- Descriptions: `age(at:in:)`, `timeAgoSince(_:in:)`, `timeUntil(_:in:)`, `relativeFormatted(in:now:)`, and `TimeInterval.formattedDuration`. `TimeInterval` also has `.minute`, `.hour`, `.day`, `.week`, scaling (`TimeInterval(2).hours`) and conversion (`asDays`).
- `FormatStyle.dateFormat(_:)` formats a `Date` with a `DateFormatter` pattern, through the `StringDateFormat` style. `Data.append(_:encoding:)` appends a string's bytes; `String.trimmed` drops surrounding whitespace and newlines.
- On Apple platforms only, `AttributedString(_:emphasizing:)` marks the given ranges strongly emphasized, and `AttributedString(highlighting:open:close:)` emphasizes the text between the markers and drops the markers.

## Rules

- Periods are half-open: `endOfDay(in:)` is the next midnight, `endOfMonth(in:)` the first instant of the next month, and `day(containing:)` does not contain its upper bound. Bounds follow the calendar's time zone and `firstWeekday`.
- `Date(year:month:…:in:)` returns nil for out-of-range fields and for dates the calendar does not have (February 29 in a common year), by round-tripping the components.
- `next(_:in:)` and `Calendar.nextHour(after:)` are strictly after the moment and return the start of the matched day or hour (09:00 gives 10:00). `previous(_:in:)` keeps the time of day. Weekday numbers outside 1…7 return nil.
- `ifWeekendThenNextWorkday(in:)` and `ifWeekendThenPreviousWorkday(in:)` return a weekday unchanged; `addingBusinessDays(0, in:)` returns the date itself, and negative counts walk backwards. Weekends are what the calendar's `isDateInWeekend` says.
- `daysBetween(_:in:)` counts calendar days between start-of-days and is signed.
- `DateComponents.adding`, `subtracting` and `multiplied` apply the offsets to `now` (default `Date()`) and re-decompose the result, so month lengths depend on `now`; they return an empty `DateComponents` if the calendar cannot compute a date. `isValid` checks field ranges only; `isValid(for:)` also round-trips through the calendar when a year or week-based year is set.
- `isToday`, `isThisWeek`, `isThisMonth` and `isThisYear` compare against the current moment.
- `timeAgoSince` and `timeUntil` pick the largest non-zero unit; ten seconds or less reads "just now" or "now". `formattedDuration` shows seconds and minutes whole, hours, days and weeks to one decimal, rounding half to even (`1.25` hours gives `"1.2h"`).
- `StringDateFormat` uses a fresh `DateFormatter` with the current locale and time zone. `Data.append(_:encoding:)` appends nothing if the string cannot be encoded.

## Example

```swift
let calendar = Calendar(identifier: .gregorian, timeZone: TimeZone(identifier: "UTC")!)

let friday = Date(year: 2025, month: 7, day: 25, in: calendar)!
let monday = friday.addingBusinessDays(1, in: calendar)       // 2025-07-28
let day = calendar.day(containing: friday)!                   // 25th 00:00 ..< 26th 00:00
let label = TimeInterval(90).formattedDuration                // "2m"
```
