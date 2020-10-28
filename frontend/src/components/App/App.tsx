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
import ConfirmSubmissionPage from '../ConfirmSubmissionPage/ConfirmSubmissionPage';
import FormErrorPage from '../FormErrorPage/FormErrorPage';
import FormUnavailablePage from '../FormUnavailablePage/FormUnavailablePage';
import ChangePasswordPage from '../ChangePasswordPage/ChangePasswordPage';
import ConfirmUpdatePage from '../ConfirmUpdatePage/ConfirmUpdatePage';
import EditEventErrorPage from '../EditEventErrorPage/EditEventErrorPage';
import ViewEventsPage from '../ViewEventsPage/ViewEventsPage';
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
          <EditEventErrorPage path="edit_event/error" />
          <LoginPage path="/login" />
          <ChangePasswordPage path="/change_password" />
          <FormPage path="/form/:formId" />
          <NewUserPage path="/form/:formId/new_user/:UIN" />
          <ConfirmSubmissionPage path="/form/confirm_submission" />
          <ConfirmUpdatePage path="/form/confirm_update" />
          <FormErrorPage path="/form/error" />
          <FormUnavailablePage path="/form/unavailable" />
          <HelpPage path="/help" />
        </Router>
      </Box>
    </MuiPickersUtilsProvider>
  </ThemeProvider>
);

export default App;
