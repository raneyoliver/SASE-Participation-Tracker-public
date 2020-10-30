import * as React from 'react';
import {
  Typography, Box, Grid, List, ListItem, ListItemText,
} from '@material-ui/core';
import { RouteComponentProps } from '@reach/router';
import CardWithHeader from '../CardWithHeader/CardWithHeader';

const HelpPage: React.FC<RouteComponentProps> = () => (
  <>
    <Box textAlign="center" marginTop={5}>
      <Typography variant="h4">
        Help and FAQ
      </Typography>
    </Box>
    <Box padding={8}>
      <Grid container spacing={10}>
        <Grid item xs={12} md={6}>
          <CardWithHeader title="FAQ">
            <List>
              <ListItem>
                <ListItemText
                  primary="Why can't I sign into an event form?"
                  secondary="The creator of the event may have restricted
                  the sign-in form to only be accessible during the event time
                  or the RSVP form to be accessible before the event time. Another
                  reason may be that the form was deleted. Try refreshing your
                  browser."
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="As an administrator, how do I make changes to an event?"
                  secondary="In the top right corner of each event on the homepage,
                  there is a dropdown box represented by three dots. Click
                  them and select 'Edit Event' to change the event, or
                  'Delete Event' to delete the event altogether."
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="Do I need to be logged in if I'm not an administrator?"
                  secondary="No. Non-admins do not have to login, but you can still
                  sign into events without being logged in
                  by just typing your TAMU UIN into an event form."
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="How do I sign into an event if it's my first time?"
                  secondary="From the homepage, click on a form for an event,
                  enter your UIN, and submit. If this is your first time signing in, you will
                  automatically be redirected to the new user page. Here you
                  can put in your info so that the system will remember you
                  next time."
                />
              </ListItem>
            </List>
          </CardWithHeader>
        </Grid>
        <Grid item xs={12} md={6}>
          <CardWithHeader title="How To...">
            <List>
              <ListItem>
                <ListItemText
                  primary="Add an RSVP form to an existing event as an administrator"
                  secondary="From the homepage, click on the three dots on the
                  top right corner of an event card. Select 'Create RSVP Form'"
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="Change time restrictions of forms as an administrator"
                  secondary="From the homepage, click on the three dots on the
                  top right corner of an event card. Select 'Edit Event'. Then
                  toggle which restrictions should apply at the bottom of the form."
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="View past events in a list view"
                  secondary="Click 'List' at the top left of the homepage and then
                  go to 'Date Filter' and select 'All' or 'Past'. You can also use
                  combinations of filters to see exactly what events you need."
                />
              </ListItem>
              <ListItem>
                <ListItemText
                  primary="Quickly return to the homepage"
                  secondary="Click 'SASE-Participation Tracker' at the very top
                  of any page to return to the homepage."
                />
              </ListItem>
            </List>
          </CardWithHeader>
        </Grid>
        <Grid item xs={12} md={12}>
          <CardWithHeader title="Credits">
            <List>
              <ListItem>
                <ListItemText
                  primary="This website was created by
                  Ryan, Davis, Oliver, Evelio, and Matthew
                  in CSCE 431, Fall 2020, at Texas A&M University."
                />
              </ListItem>
            </List>
          </CardWithHeader>
        </Grid>
      </Grid>
    </Box>
  </>
);

export default HelpPage;
