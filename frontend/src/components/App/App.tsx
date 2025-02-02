import * as React from 'react';
import DateFnsUtils from '@date-io/date-fns';
import { Box, ThemeProvider } from '@material-ui/core';
import { MuiPickersUtilsProvider } from '@material-ui/pickers';
import { Router } from '@reach/router';
import theme from '../../theme';
import Homepage from '../Homepage/Homepage';
import NavBar from '../Navbar/Navbar';
import LoginPage from '../LoginPage/LoginPage';
import CreateEventPage from '../CreateEventPage/CreateEventPage';
import EditEventPage from '../EditEventPage/EditEventPage';
import FormPage from '../FormPage/FormPage';
import NewUserPage from '../NewUserPage/NewUserPage';
import ChangePasswordPage from '../ChangePasswordPage/ChangePasswordPage';
import ViewEventsPage from '../ViewEventsPage/ViewEventsPage';
import TextBoxPage from '../TextBoxPage/TextBoxPage';
import HelpPage from '../HelpPage/HelpPage';

const App: React.SFC = () => (
  <ThemeProvider theme={theme}>
    <MuiPickersUtilsProvider utils={DateFnsUtils}>
      <NavBar />
      <Box padding={1}>
        <Router>
          <Homepage path="/" />
          <ViewEventsPage path="/view_events" />
          <CreateEventPage path="/create_event" />
          <EditEventPage path="/edit_event/:eventId" />
          <TextBoxPage path="/edit_event/error" title="Uh Oh!" text="There was an issue navigating to the event you are trying to edit. Please try again." />
          <LoginPage path="/login" />
          <ChangePasswordPage path="/change_password" />
          <FormPage path="/form/:formId" />
          <NewUserPage path="/form/:formId/new_user/:UIN" />
          <TextBoxPage path="/form/confirm_submission" title="Thank You!" text="Your submission has been recorded. You may safely close this page." />
          <TextBoxPage path="/form/repeat_submission" title="Submission Already Received" text="You already responded to this form. Your submission remains unchanged." />
          <TextBoxPage path="/form/error" title="Uh Oh!" text="There was an issue navigating to your form. Please try again." />
          <TextBoxPage path="/form/unavailable" title="Form Unavailable" text="This form is unavailable at this time." />
          <HelpPage path="/help" />
        </Router>
      </Box>
    </MuiPickersUtilsProvider>
  </ThemeProvider>
);

export default App;
