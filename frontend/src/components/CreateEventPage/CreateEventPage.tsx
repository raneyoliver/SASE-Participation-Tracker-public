import * as React from 'react';
import { RouteComponentProps } from '@reach/router';
import ManageEventPage from '../ManageEventPage/ManageEventPage';

const CreateEventPage: React.FC<RouteComponentProps> = () => (
  <ManageEventPage eventId="create" />
);

export default CreateEventPage;
