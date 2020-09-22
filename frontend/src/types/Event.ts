// Interface with fields needed to create an event model in rails, use this when creating events
export interface Event {
  name: string;
  description: string;
  start_time: string;
  end_time: string;
}

// Interface with fields equivalent to the rails model, use this when dealing with existing events
export interface SerializedEvent {
  id: number;
  name: string;
  description: string;
  start_time: string;
  end_time: string;
  forms: SerializedForm[];
}

export interface SerializedForm {
  id: string;
}
