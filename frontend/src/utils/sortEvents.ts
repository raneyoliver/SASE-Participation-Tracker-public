import { EventWithID } from '../types/Event';

// This module is for all functions related to sorting events, we might add more in the future
export function sortEventsByTimeAscending(events: EventWithID[]): EventWithID[] {
  return events.sort((a, b) => (new Date(a.start_time) >= new Date(b.start_time) ? 1 : -1));
}

export function sortEventsByTimeDescending(events: EventWithID[]): EventWithID[] {
  return events.sort((a, b) => (new Date(a.start_time) >= new Date(b.start_time) ? -1 : 1));
}
