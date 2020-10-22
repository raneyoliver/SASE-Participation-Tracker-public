import { SerializedEvent } from '../types/Event';

export default function hasRSVP(event: SerializedEvent): boolean {
  return event.forms.some((form) => form.form_type.toString() === 'RSVP');
}
