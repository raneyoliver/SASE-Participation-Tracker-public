import { SerializedEvent } from '../types/Event';

export default function getFormRestriction(
  form_type: string,
  event: SerializedEvent,
): boolean {
  if (form_type === 'RSVP' && event.has_rsvp_form === false) {
    return false;
  }
  if (event.forms[0].form_type.toString() === form_type) {
    return event.forms[0].time_restricted;
  }
  if (event.forms[1].form_type.toString() === form_type) {
    return event.forms[1].time_restricted;
  }
  return false;
}
