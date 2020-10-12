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
  onYearChange: (newYear: number) => any;
  onMonthChange: (newMonth: number) => any;
}

const MonthSelect: React.FC<MonthSelectProps> = ({ onYearChange, onMonthChange }) => {
  const [year, setYear] = React.useState(currentYear);
  const [month, setMonth] = React.useState(currentMonth);

  /* eslint-disable react-hooks/exhaustive-deps */
  React.useEffect(() => { onYearChange(year); }, [year]);
  React.useEffect(() => { onMonthChange(month); }, [month]);
  /* eslint-enable react-hooks/exhaustive-deps */

  const handleYearChange = (e: React.ChangeEvent<HTMLSelectElement>): void => {
    setYear(Number(e.target.value));
  };

  const handleMonthChange = (e: React.ChangeEvent<HTMLSelectElement>): void => {
    setMonth(Number(e.target.value));
  };

  const handlePreviousMonthClick = (): void => {
    const [newYear, newMonth] = previousMonth(year, month);
    if (newYear < minYear) return;
    setYear(newYear);
    setMonth(newMonth);
  };

  const handleNextMonthClick = (): void => {
    const [newYear, newMonth] = nextMonth(year, month);
    if (newYear > maxYear) return;
    setYear(newYear);
    setMonth(newMonth);
  };

  const previousDisabled = previousMonth(year, month)[0] < minYear;
  const nextDisabled = nextMonth(year, month)[0] > maxYear;

  return (
    <Box display="flex" alignItems="center" justifyContent="center">
      <Box paddingRight={1}>
        <IconButton disabled={previousDisabled} onClick={handlePreviousMonthClick}>
          <ChevronLeft />
        </IconButton>
      </Box>
      <Box paddingRight={1}>
        <NativeSelect value={month} onChange={handleMonthChange} name="Month">
          {monthOptions}
        </NativeSelect>
      </Box>
      <Box paddingRight={1}>
        <NativeSelect value={year} onChange={handleYearChange} name="Year">
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
