import { SerializedEvent } from '../types/Event';

// This module is for all functions related to sorting events, we might add more in the future
export function filterEventsOnlyPast(events: SerializedEvent[]): SerializedEvent[] {
  const now = new Date();
  return events.filter((event) => (new Date(event.start_time) < now));
}

export function filterEventsOnlyUpcoming(events: SerializedEvent[]): SerializedEvent[] {
  const now = new Date();
  return events.filter((event) => (new Date(event.start_time) >= now));
}
