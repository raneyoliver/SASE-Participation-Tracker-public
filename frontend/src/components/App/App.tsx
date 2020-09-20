import * as React from 'react';
import DateFnsUtils from '@date-io/date-fns';
import { Box, ThemeProvider } from '@material-ui/core';
import { MuiPickersUtilsProvider } from '@material-ui/pickers';
import { Router } from '@reach/router';
import theme from '../../theme';
import Homepage from '../Homepage/Homepage';
import NavBar from '../Navbar/Navbar';
import CreateEventPage from '../CreateEventPage/CreateEventPage';
import FormPage from '../FormPage/FormPage';
import NewUserFormPage from '../NewUserFormPage/NewUserFormPage';
import ConfirmSubmissionPage from '../ConfirmSubmissionPage/ConfirmSubmissionPage';

const App: React.SFC = () => (
  <ThemeProvider theme={theme}>
    <MuiPickersUtilsProvider utils={DateFnsUtils}>
      <NavBar />
      <Box padding={1}>
        <Router>
          <Homepage path="/" />
          <CreateEventPage path="/create_event" />
          <FormPage path="/form/:form_id" />
          <NewUserFormPage path="/form/:form_id/new_user" />
          <ConfirmSubmissionPage path="/form/confirm_submission" />
        </Router>
      </Box>
    </MuiPickersUtilsProvider>
  </ThemeProvider>
);

export default App;
