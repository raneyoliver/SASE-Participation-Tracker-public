import * as React from 'react';
import { Box, IconButton, NativeSelect } from '@material-ui/core';
import { ChevronLeft, ChevronRight } from '@material-ui/icons';
import { previousMonth, nextMonth } from '../../../../../utils/calendarUtils';

const now = new Date();
const currentYear = now.getFullYear();
const currentMonth = now.getMonth();

// Create static options for months
const monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

const monthOptions = monthNames.map((month, idx) => (
  <option value={idx} key={month}>{month}</option>
));

// Year options start at 2020 (when the site was created) and go to the current year + 2
const years = [];
const minYear = 2020;
const maxYear = currentYear + 2;
for (let year = minYear; year <= maxYear; year++) years.push(year);
const yearOptions = years.map((year) => (
  <option value={year} key={year}>{year}</option>
));

interface MonthSelectProps {
  onMonthChange: (newMonth: [number, number]) => any;
}

const MonthSelect: React.FC<MonthSelectProps> = ({ onMonthChange }) => {
  const [month, setMonth] = React.useState<[number, number]>([currentYear, currentMonth]);

  /* eslint-disable react-hooks/exhaustive-deps */
  React.useEffect(() => { onMonthChange(month); }, [month]);
  /* eslint-enable react-hooks/exhaustive-deps */

  const [currYear, currMonth] = month;

  const handleYearChange = (e: React.ChangeEvent<HTMLSelectElement>): void => {
    setMonth([Number(e.target.value), currMonth]);
  };

  const handleMonthChange = (e: React.ChangeEvent<HTMLSelectElement>): void => {
    setMonth([currYear, Number(e.target.value)]);
  };

  const handlePreviousMonthClick = (): void => {
    const [newYear, newMonth] = previousMonth(currYear, currMonth);
    if (newYear < minYear) return;
    setMonth([newYear, newMonth]);
  };

  const handleNextMonthClick = (): void => {
    const [newYear, newMonth] = nextMonth(currYear, currMonth);
    if (newYear > maxYear) return;
    setMonth([newYear, newMonth]);
  };

  const previousDisabled = previousMonth(currYear, currMonth)[0] < minYear;
  const nextDisabled = nextMonth(currYear, currMonth)[0] > maxYear;

  return (
    <Box display="flex" alignItems="center" justifyContent="center">
      <Box paddingRight={1}>
        <IconButton disabled={previousDisabled} onClick={handlePreviousMonthClick}>
          <ChevronLeft />
        </IconButton>
      </Box>
      <Box paddingRight={1}>
        <NativeSelect value={currMonth} onChange={handleMonthChange} name="Month">
          {monthOptions}
        </NativeSelect>
      </Box>
      <Box paddingRight={1}>
        <NativeSelect value={currYear} onChange={handleYearChange} name="Year">
          {yearOptions}
        </NativeSelect>
      </Box>
      <IconButton disabled={nextDisabled} onClick={handleNextMonthClick}>
        <ChevronRight />
      </IconButton>
    </Box>
  );
};

export default MonthSelect;
