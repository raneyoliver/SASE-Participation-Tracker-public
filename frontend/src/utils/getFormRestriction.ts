import hasRSVP from './hasRSVP';
import { SerializedEvent } from '../types/Event';
import { FormType } from '../Enums';

export default function getFormRestriction(
  form_type: FormType,
  event: SerializedEvent,
): boolean {
  if (form_type === FormType.RSVP && !hasRSVP(event)) {
    return false;
  }
  if (event.forms[0].form_type === form_type) {
    return event.forms[0].time_restricted;
  }
  if (event.forms[1].form_type === form_type) {
    return event.forms[1].time_restricted;
  }
  return false;
}
