import { Box, Paper, Typography } from '@material-ui/core';
import { grey } from '@material-ui/core/colors';
import * as React from 'react';
import { SASEBlue } from '../../../../theme';
import { SerializedEvent } from '../../../../types/Event';
import { daysForMonth } from '../../../../utils/calendarUtils';
import EventSortButtons from '../EventSortButtons/EventSortButtons';
import EventChips from './EventChips/EventChips';
import MonthSelect from './MonthSelect/MonthSelect';

interface EventCalendarProps {
  events: SerializedEvent[];
}

const now = new Date();
const currentYear = now.getFullYear();
const currentMonth = now.getMonth();
const currentDay = now.getDate();

const weekdayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
const weekdayStyle: React.CSSProperties = { width: `${100 / 7}%`, textAlign: 'center' };
const weekdays = weekdayNames.map((day) => (
  <Typography style={weekdayStyle} key={day}>
    {day}
  </Typography>
));

const EventCalendar: React.FC<EventCalendarProps> = ({ events: initialEvents }) => {
  const [events, setEvents] = React.useState(initialEvents);
  const handleEventSort = React.useCallback((newEvents: SerializedEvent[]): void => {
    setEvents(newEvents);
  }, []);

  const [selectedYearMonth, setSelectedYearMonth] = React.useState([currentYear, currentMonth]);
  const [selectedYear, selectedMonth] = selectedYearMonth;

  const handleMonthChange = (newMonth: [number, number]): void => {
    setSelectedYearMonth(newMonth);
  };

  // eventMap is a 3D map with year, month, and day for each event
  // To get events for a month: eventMap.get(year).get(month).get(day)
  const eventMap = React.useMemo(() => {
    const ret = new Map<number, Map<number, Map<number, SerializedEvent[]>>>();
    events.forEach((event) => {
      const eventTime = new Date(event.start_time);
      const eventYear = eventTime.getFullYear();
      const eventMonth = eventTime.getMonth();
      const eventDay = eventTime.getDate();

      // Map event to its year
      if (!ret.get(eventYear)) {
        ret.set(eventYear, new Map<number, Map<number, SerializedEvent[]>>());
      }
      const eventsForYear = ret.get(eventYear);

      // Map event to its month
      if (!eventsForYear.get(eventMonth)) {
        eventsForYear.set(eventMonth, new Map<number, SerializedEvent[]>());
      }
      const eventsForMonth = eventsForYear.get(eventMonth);

      // Map event to its day
      const eventsForDay = eventsForMonth.get(eventDay) || [];
      eventsForDay.push(event);
      eventsForMonth.set(eventDay, eventsForDay);
    });

    return ret;
  }, [events]);

  // Calendar grid items
  const calendarDays = daysForMonth(selectedYear, selectedMonth).map((date) => {
    const year = date.getFullYear();
    const month = date.getMonth();
    const day = date.getDate();
    const isToday = day === currentDay && month === currentMonth && year === currentYear;
    const eventsForDay = eventMap.get(year)?.get(month)?.get(day) || [];
    const key = `${year}${month}${day}`;

    // Give gray names + background for days in other months
    const textColor = month === selectedMonth ? 'textPrimary' : 'textSecondary';
    let backgroundColor = month === selectedMonth ? 'white' : grey[300];

    // If day is the current day, highlight it on the calendar
    if (isToday) backgroundColor = `${SASEBlue}40`;

    return (
      <Paper style={{ backgroundColor }} elevation={1} key={key}>
        <Box
          display="flex"
          flexDirection="column"
          height="100%"
          paddingX={0.5}
        >
          <Box paddingLeft={1} paddingTop={1} width="calc(min-content + 8px)">
            <Typography variant="h4" color={textColor}>
              {day}
            </Typography>
          </Box>
          <EventChips events={eventsForDay} />
        </Box>
      </Paper>
    );
  });

  return (
    <>
      <Box paddingBottom={1}>
        <MonthSelect onMonthChange={handleMonthChange} />
      </Box>
      <Box paddingBottom={1}>
        <EventSortButtons events={events} variant="calendar" onSort={handleEventSort} />
      </Box>
      <Box paddingBottom={1} display="flex">
        {weekdays}
      </Box>
      <Box
        display="grid"
        gridGap={8}
        gridTemplateColumns="repeat(7, 1fr)"
        gridAutoRows="max(150px, 15vh)"
      >
        {calendarDays}
      </Box>
    </>
  );
};

export default EventCalendar;
