import { SerializedEvent } from '../types/Event';

export default function hasRSVP(event: SerializedEvent): boolean {
  const formTypes = event.forms.map((form) => (
    form.form_type.toString()
  ));
  if (formTypes.includes('RSVP')) {
    return true;
  }
  return false;
}
