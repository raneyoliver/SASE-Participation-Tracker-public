// Interface with fields needed to create an event model in rails, use this when creating events
export interface Form {
    id: string;
    event_id: number;
    start_time: string;
    form_type: string;
    data: string;
  }
