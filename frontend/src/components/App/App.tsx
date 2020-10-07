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
import ConfirmUpdatePage from '../ConfirmUpdatePage/ConfirmUpdatePage';
import EditEventErrorPage from '../EditEventErrorPage/EditEventErrorPage';

const App: React.SFC = () => (
  <ThemeProvider theme={theme}>
    <MuiPickersUtilsProvider utils={DateFnsUtils}>
      <NavBar />
      <Box padding={1}>
        <Router>
          <Homepage path="/" />
          <CreateEventPage path="/create_event" />
          <EditEventPage path="/edit_event/:eventId" />
          <EditEventErrorPage path="edit_event/error" />
          <LoginPage path="/login" />
          <FormPage path="/form/:formId" />
          <NewUserPage path="/form/:formId/new_user/:UIN" />
          <ConfirmSubmissionPage path="/form/confirm_submission" />
          <ConfirmUpdatePage path="/form/confirm_update" />
          <FormErrorPage path="/form/error" />
        </Router>
      </Box>
    </MuiPickersUtilsProvider>
  </ThemeProvider>
);

export default App;
