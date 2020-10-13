import {
  lastDayOfMonth, startOfWeek, endOfWeek, eachDayOfInterval,
} from 'date-fns';

export function previousMonth(year: number, month: number): [number, number] {
  if (month === 0) return [year - 1, 11];
  return [year, month - 1];
}

export function nextMonth(year: number, month: number): [number, number] {
  if (month === 11) return [year + 1, 0];
  return [year, month + 1];
}

// Returns array of date objects corresponding to the sunday before the month starts to
// the saturday after it ends.
export function daysForMonth(year: number, month: number): Date[] {
  const startOfMonth = new Date(year, month, 1);
  const endOfMonth = lastDayOfMonth(startOfMonth);

  const firstDay = startOfWeek(startOfMonth);
  const lastDay = endOfWeek(endOfMonth);

  return eachDayOfInterval({ start: firstDay, end: lastDay });
}
