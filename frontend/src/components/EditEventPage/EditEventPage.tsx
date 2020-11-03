import * as React from 'react';
import { RouteComponentProps, useParams } from '@reach/router';
import ManageEventPage from '../ManageEventPage/ManageEventPage';

const EditEventPage: React.FC<RouteComponentProps> = () => {
  const { eventId } = useParams();
  return (
    <ManageEventPage eventId={eventId} />
  );
};

export default EditEventPage;
