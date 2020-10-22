import { EventType, FormType } from '../Enums';

// Interface with fields needed to create an event model in rails, use this when creating events
export interface Event {
  name: string;
  description: string;
  start_time: string;
  end_time: string;
  event_type: EventType;
}

// Interface with fields equivalent to the rails model, use this when dealing with existing events
export interface SerializedEvent {
  id: number;
  name: string;
  description: string;
  start_time: string;
  end_time: string;
  forms: SerializedFormData[];
  event_type: EventType;
}

export interface SerializedFormData {
  id: string;
  form_type: FormType;
  user_count: number;
  time_restricted: boolean;
}
